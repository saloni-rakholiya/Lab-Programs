#import libraries
import socket

#define constants
HOST='localhost'
PORT=7777

addr = (HOST,PORT)

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    #connect to server
    s.connect(addr)
    print("Connected to server...")
    string = input('Enter string to send to encoding server: ')
    #send string to server
    s.send(string.encode())
    #get result from server
    result = s.recv(1024).decode()
    print("Received from server: "+str(result))