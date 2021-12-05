#import libraries
import socket
import fcntl
import struct

#convert interface name to ip address
def interface_to_ip_address(interface_name):
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    return socket.inet_ntoa(fcntl.ioctl(
        s.fileno(),
        0x8915, 
        struct.pack('256s', bytes(interface_name[:15],'utf-8'))
    )[20:24])

#define constants
HOST=interface_to_ip_address('eth0')
PORT=7777

addr = (HOST,PORT)

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    # s1.setsockopt(socket.SOL_SOCKET, 25, ('eth0'+'\0').encode())
    # connect to server
    s.connect(addr)
    print("Connected to server...")
    string = input('Enter binary input to send to the decoding server: ')
    #send string to server
    s.send(string.encode())
    #get data from server
    result = s.recv(1024).decode()
    print("Received from server: "+str(result))
