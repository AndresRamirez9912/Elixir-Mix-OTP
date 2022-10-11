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