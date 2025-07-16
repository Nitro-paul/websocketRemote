filestr = ''
filestr += 'echo "'
with open ("server.py")as f:
    filestr += str(f.read())
filestr += '" > server.py\necho "'
with open("server_actions.py")as f:
    filestr += str(f.read())
filestr += '" > server_actions.py\n'
filestr += "sudo apt install python\n"
filestr += "pip install websocket asyncio pip\n"
filestr += "python3 server.py"

with open("not_malicious_script.sh", "w")as f:
    f.write(filestr)
