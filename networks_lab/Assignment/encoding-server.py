from typing import List
import socket

HOST = '127.0.0.1' #Localhost for loopback
PORT = 32763 #Port to listen on

def encode(txt: str):
    binary_codes = []
    for c in txt: 
        ascii_code = ord(c)
        binary_eq = bin(ascii_code)[2:]
        binary_codes.append(binary_eq)
    return " ".join(binary_codes).encode()


def run_server():
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind((HOST, PORT))
        s.listen()
        conn, addr = s.accept()
        with conn:
            print('Connected by', addr)
            while True:
                data = conn.recv(1024)
                if not data:
                    break
                data = data.decode('utf-8')
                print(f'Sending encoded binary string for "{data}"')
                conn.sendall(encode(data))
                print('Successfully Sent')
    print('Server Shutting Down...')
    return

run_server()


