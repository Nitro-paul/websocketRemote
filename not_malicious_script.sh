sudo apt install python
echo "# server.py
import asyncio
import websockets
from websockets import WebSocketServerProtocol
from typing import Set
import server_actions
import time


class WebSocketServer:
    def __init__(self, host: str = 'localhost', port: int = 8765):
        self.host = host
        self.port = port
        self.connected_clients: Set[WebSocketServerProtocol] = set()

    async def register(self, ws: WebSocketServerProtocol):
        """Register a new client."""
        self.connected_clients.add(ws)
        print(f"[INFO] Client connected: {ws.remote_address}")

    async def unregister(self, ws: WebSocketServerProtocol):
        """Unregister a client on disconnect."""
        self.connected_clients.remove(ws)
        print(f"[INFO] Client disconnected: {ws.remote_address}")

    async def handle_message(self, ws: WebSocketServerProtocol, message: str):
        """Handle incoming message: broadcast and call dummy."""
        #print(f"[RECEIVED] From {ws.remote_address}: {message}")
        await self.on_incoming_message(message)
        #await self.broadcast(message)

    async def broadcast(self, message: str):
        """Send message to all connected clients."""
        for client in self.connected_clients:
            try:
                await client.send(message)
                print(f"[SENT] To {client.remote_address}: {message}")
            except Exception as e:
                print(f"[ERROR] Failed to send to {client.remote_address}: {e}")

    async def on_incoming_message(self, message: str):
        """Dummy method called when message is received."""
        print(f"[RECEIVED]: {message}")
        if message == "killswitch":
            self.broadcast("server suicide")
            time.sleep(3)
            await asyncio.
            exit()
        await self.broadcast(str(server_actions.execute(message)))

    async def handler(self, ws: WebSocketServerProtocol):
        """Main handler for each client connection."""
        await self.register(ws)
        try:
            async for message in ws:
                await self.handle_message(ws, message)
        except websockets.exceptions.ConnectionClosed:
            print(f"[WARN] Connection closed unexpectedly: {ws.remote_address}")
        finally:
            await self.unregister(ws)

    async def start(self):
        """Start the WebSocket server."""
        print(f"[STARTING] WebSocket server at ws://{self.host}:{self.port}")
        async with websockets.serve(self.handler, self.host, self.port):
            await asyncio.Future()  # Run forever

if __name__ == "__main__":
    server = WebSocketServer()
    asyncio.run(server.start())
" > server.py
echo "import subprocess

def bash(argument, arg_len)-> str:
    return f'bash {argument[1:arg_len]} -> {subprocess.run(argument[1:arg_len], capture_output=True, text=True)}'

def test(argument) -> str:
    o = ""
    for c,i in enumerate(argument):
        o += str(c)
        o += "-"
        o+= str(i)
        o += " "
    return o

def file(argument)->str:
    path = argument[0]
    cntent = argument[1:len(argument)]
    content = ""
    for i in cntent:
        content += i
        content += " "
    try:
        print(path, content)
        with open(path, "w") as f:
            f.write(content)
    except Exception:
        return "failed to write file"
    return "file written"

def execute(argument:str)->str:
    argument = argument.split(" ")
    arg_len = len(argument) 
    if argument[0] == "help":
        return "available commands: bash, file, test"
    elif argument[0] == "bash":
        return bash(argument, arg_len)
    elif argument[0] == "test":
        return test(argument)
    elif argument[0] == "file":
        return file(argument[1:arg_len])
    else:
        return f"unknown command: {argument}"" > server_actions.py
pip install websocket asynciopython3 server.py