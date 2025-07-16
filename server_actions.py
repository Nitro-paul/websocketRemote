import subprocess

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
        return f"unknown command: {argument}"