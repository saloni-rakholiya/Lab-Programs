import socket

client_socket = socket.socket()
host = '127.0.0.1'
port = 7777

print('Connecting to server...')
try:
    client_socket.connect((host, port))
except socket.error as err:
    print(str(err))

while True:
    our_string = input('Input message for server(bye to exit): ')
    client_socket.send(str.encode(our_string))
    if our_string=="bye":
        break
    Response = client_socket.recv(1024)
    print("Message from server: "+str(Response.decode('utf-8')))

client_socket.close()