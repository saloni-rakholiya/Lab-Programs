#!/usr/bin/env python3
import socket

HOST = '127.0.0.1'  # The server's hostname or IP address
PORT = 32763        # The port used by the server

def send_and_recv(sock: socket.socket()):
    while True:
        txt = input('Enter Message to send: ')
        if txt is None or len(txt) == 0: 
            break
        sock.sendall(txt.encode())
        data = sock.recv(1024).decode()
        print('Received', repr(data))
    return

def run_client():
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.connect((HOST, PORT))
        send_and_recv(s)
    print('Server has shut down...\nClosing Client.... Bye!!')

run_client()

