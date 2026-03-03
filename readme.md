# this is coded in a short time without any regard to code readability or possible fault cases, this is a short, fun demonstration of an idea, nothing in this code should ever be treated as reliable or performant

# what you need to run (installed on client and target system):
- python3
- python-websockets
- python-asyncio
- python-subprocess

# how to run:
- configure ip-addresses in server and client scripts
- ***on target device***
    - place server.py and server_actions.py in the same folder on target maschine
    - start server.py
- ***on client device***
    - startup client_listener.py and client_command.py (each in seperate shell)
# items
## Clients
### client.py
- can only act on one command, then exits
### client_listener.py
- lists all returns of executed commands and stays open
### cleint_command.py
- can send commands, the returns of which will be displayed in client_listener
## Server
### server.py
- handles websocket connection
### server_actions.py
- all the code that can be executed by sent command is placed here