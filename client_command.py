# client_command.py
import asyncio
import websockets

# Ip adress to be configured

uri: str = 'ws://localhost:8765'

############################


class WebSocketClient:
    def __init__(self, uri: str = 'ws://localhost:8765'):
        self.uri = uri

    async def send_message(self, websocket):
        """Send a message to the server."""
        message = input("Enter message to send: ")
        if message == "exit":
            exit()
        await websocket.send(message)
        print(f"[SENT] {message}")
        #self.send_message()
    async def run(self):
        """Connect to the server and handle communication."""
        try:
            async with websockets.connect(self.uri) as websocket:
                print(f"[CONNECTED] Connected to {self.uri}")
                await asyncio.gather(
                    self.send_message(websocket),
                )
        except ConnectionRefusedError:
            print(f"[ERROR] Cannot connect to {self.uri}")

if __name__ == "__main__":
    client = WebSocketClient(uri)
    while(True):
        asyncio.run(client.run())
