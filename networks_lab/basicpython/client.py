import socket

host = 'localhost'
port = 7777

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.connect((host, port))
    while True:
        word = input('enter string: ')
        print(f'S: {word}')
        s.sendall(word.encode())
        result = s.recv(1024).decode()
        print(f'R: {result}')
        if result == 'BYEBYE':
            break
