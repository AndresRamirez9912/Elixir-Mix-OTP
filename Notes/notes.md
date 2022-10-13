# Agent

Agents are a piece of memory that contains states or list/elements

```elixir
# Create the agent as a buffer with a active process 
{:ok,agent}=Agent.start_lint fn -> [] end 

# Add element to my memory 
Agent.update(agent, fn list -> ["eggs | list"]end ) #Add an element to my list 

# Get the elements from my memory 
result = Agent.get(agent, fn list -> list end )
#result = ["eggs"]

# Stop the Agent and stop the process
Agent.stop(agent)
```

# Genserver

Genserver is a process used it to create a registry that can monitor bucket processes with different functionalities. This is because giving a process name takes a lot of server memory and then it could crash.

```elixir
defmodule GenericServer do
	
	# Init the server
	def init(param) do
	IO.puts("Init server")
	{:ok, %{count:0}} #return a tuple with the ok value and an initial memory state 
	end

	# Function that receive message from the client 
	def handle_call(message, _from, state) do #_from means that I don't need to use it 
		IO.puts(message)
		result ="Hello From the server"
		{:reply, result, state} #This is the response of the server	
	end
end
```

This function, handle_call return a server response to the client, this could be a problem because if the server is delayed the client have to wait until some response (or the timeout error). Instead of this exist another function that doesn’t return anything to the client, just make a server petition and finish. Here is the example:

```elixir
# Function that receive message from the client 
		def handle_cast(message, state) do #The message is the data that I want to send 
		{:noreply, state} #When the handle_cast is correct return a :noreply
		{:reply, result, state} #This is the response of the server	
	end
```

# Supervisor

A supervisor is another process which supervises other process that I program as a supervisor’s child, this process should make this actions:

- Start the child process
- Restart the process if it ends abnormally or other conditions occurs
- Shut down the process when the main system shutting down

## Create a supervisor and a process

Here is an example creating my supervisor to check when a process fails

```elixir
# Create an array to list what are my childs to supervice
childs = [child1, child2]

# Create my supervisor and start the server link
Supervisor.start_link(childs, strategy: :one_for_one) 
```

When I make the start_link function the process are created but in this case, the supervisor launch the child process.

### Launch Process

When my supervisor launches process I can write the especificationf of each process, here is with the child_spect function, this convert a especification into a map that I have to send in start_link calling

```elixir
result = child1.child_spec([:ok]) 
#result = {id: KV.Registry, start: {KV.Registry, :start_link, [[:ok]]}}
```

# Dynamic Supervisor

When I’m creating my Supervisor sometimes the child list it’s not complete, on fly can born new childs, to handle this I can create a dynamic supervisto that is a normal supervisor but that can supervise a new process, to add a new chile I can use the following function

```elixir
{:ok, pid} = DynamicSupervisor.start_child(old_supervisor, new_Child)
```

Notice that in this case, the Dynamic supervisor con only handle the *strategy: :one_for_one*

# ETS

ETS (Erlang Term Storage) is an engine build in OTP to storage data into process and tables. I mean each process is a table

## Types of tables

- **set:** Default table one value per key
- **ordered_set:** similar as set table but the elements are ordered by Earlang
- **bag:** Many Objects per key ****
- **duplicate_bag:** Many Objects per key and allow has duplicates

## Access Control

- **public** Read/Write available for all process
- **protected** Read available for all process but Write available only for owner process ****
- **private** Read/Write only for owner process

## Create table

To create table use the following example:

```elixir
table = :ets.new(:my_table, [:set]) #Create a normal table
#table = 8122
```

The number that this function return is the table name, to give a customizable name I need to add the :named_table  at the end

```elixir
table = :ets.new(:my_table, [:set, :named_table]) #Create a normal table 
#table = my_table 
```

## Insert data

When I want to insert I must use tuples where the first element is the key

```elixir
result :ets.insert({:fairy_tail, 10, 2}) # key = fairy_tail, value = 10,2
```

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/0eaa5dd7-a96b-4906-8c7c-5a6d02069dfd/Untitled.png)

When I store data has this structure, the key and the values

## Get the table

A form to get values is to get the complete table, is the most efficient way to get any data

```elixir
:ets.lookup(:fairy_tail) #This return the values asociated to this key 
```

## Delete specific element

If I want to delete a specific element use the second argument to write which element deletes

```elixir
:ets.delete(":fairy_tail",2) #Delete the fairy tail element 2
```

## Delete element

When I want to delete my complete using the function delete and just write the key

```elixir
:ets.delete(":fairy_tail") #Delete the fairy tail element
```

## Delete Table

If I want to delete the entire table write the delete with no arguments

```elixir
:ets.delete() #Delete the talbe and process 
```