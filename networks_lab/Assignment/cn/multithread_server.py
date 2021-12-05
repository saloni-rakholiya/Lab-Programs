#import
import socket
from _thread import *

server_socket = socket.socket()

#define constants
host = '127.0.0.1'
port = 7777
thread_no = 0

#binding server to port
try:
    server_socket.bind((host, port))
except socket.error as err:
    print(str(err))

print('Listening ...')
server_socket.listen(2)

def new_threading_client(connection):
    while True:
        data = connection.recv(2048)
        server_msg =data.decode('utf-8')
        if not data:
            break
        connection.sendall(str.encode(server_msg))
    connection.close()

# keep accepting clients and threading
while True:
    Client, address = server_socket.accept()
    print('Connected to-> ' + address[0] + ':' + str(address[1]))
    #start thread for client connected
    start_new_thread(new_threading_client, (Client, ))
    thread_no+=1
    print('Thread -> ' + str(thread_no))
server_socket.close()