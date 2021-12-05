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
PORT = 7777        # The port used by the server

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
        s.setsockopt(socket.SOL_SOCKET, 25, ('eth0'+'\0').encode())
        s.connect((HOST, PORT))
        send_and_recv(s)
    print('Server has shut down...\nClosing Client.... Bye!!')

run_client()

