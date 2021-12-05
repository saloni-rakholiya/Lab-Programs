# import libraries
import socket
import fcntl
import struct

# get the ip address of the interface
def interface_to_ip_address(interface_name):
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    return socket.inet_ntoa(fcntl.ioctl(
        s.fileno(),
        0x8915, 
        struct.pack('256s', bytes(interface_name[:15],'utf-8'))
    )[20:24])

# define constants
HOST=interface_to_ip_address('eth0')
PORT=7777

addr = (HOST, PORT)

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    # s.setsockopt(socket.SOL_SOCKET, 25, ('eth0'+'\0').encode())
    s.bind(addr)
    s.listen()
    print("Listening...")
    conn, addr = s.accept()
    print("Found a client...")
    string = conn.recv(1024).decode()
    print("Received input from client "+str(string))
    try:
        result = ''.join(chr(int(x, 2)) for x in string.split())
        print("The decoded string is "+str(result))
    except:
        result = 'The input string sent is invalid!'
        print("The input string sent is invalid!")    
    print("Bye!")    
    conn.sendall(result.encode())
