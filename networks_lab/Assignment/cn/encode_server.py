#imports
import socket

#define constants
HOST='localhost'
PORT=7777

addr = (HOST, PORT)

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR | socket.SO_REUSEPORT, 1)
    s.bind(addr)
    # print(s.getsockname())
    #listening for clients
    s.listen()
    print("Listening...")
    #connect to the client
    conn, addr = s.accept()
    print("Found a client...")
    #get data from server
    string = conn.recv(1024).decode()
    print("Received string from client "+str(string)+" ...")
    try:
        #encode the server data
        result = ' '.join(format(ord(x), 'b') for x in string)
        print("The encoded string is "+str(result))
    except:
        result = "The input string sent is invalid!"
        print("The input string sent is invalid!")    
    print("Result sent!")  
    #send result to client
    conn.sendall(result.encode())
