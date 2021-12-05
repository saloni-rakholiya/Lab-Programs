from typing import List
import socket
import fcntl
import struct

def interface_to_ip_address(interface_name):
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    return socket.inet_ntoa(fcntl.ioctl(
        s.fileno(),
        0x8915,  # SIOCGIFADDR
        struct.pack('256s', interface_name[:15])
    )[20:24])

HOST = interface_to_ip_address(b'eth0') #Localhost for loopback
PORT = 7777 #Port to listen on

def decode(txt: str):
    binary_codes = txt.split(sep=' ')
    decode_str_chars = []    
    for code in binary_codes:
        decode_str_chars.append(chr(int(code, 2)))
    return "".join(decode_str_chars).encode()


def run_server():
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.setsockopt(socket.SOL_SOCKET, 25, ('eth0'+'\0').encode())
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
                print(f'Sending decoded string for "{data}"')
                conn.sendall(decode(data))
                print('Successfully Sent')
    print('Server Shutting Down...')
    return

run_server()


