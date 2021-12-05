""" Usage: 
python <filename> <trfile> <connection_protocol> <src_node> <dest_node> <dest_node_port> 
Example: 

python packets.py trace.tr tcp 0 3 3.0
find the number of tcp packets sent from src_node 0 on the network
find the number of tcp packets received at sink (dest_node) 3 from node 0 network 

"""

import sys
trfile = sys.argv[1]
connection_protocol = sys.argv[2]
src_node = sys.argv[3]
dest_node = sys.argv[4]
dest_node_port = sys.argv[5]
packetSize = None

packetsSent = 0
packetsRecvd = 0

file = open(trfile, 'r')
lines = file.readlines()

for line in lines:
    tokens = line.split()
    #Check Protocol
    if(tokens[4] == connection_protocol):
        packetSize = int(tokens[5])
        if(tokens[0] == 'r' and tokens[3] == dest_node and tokens[9] == dest_node_port):
            packetsRecvd += 1
        elif(tokens[0] == '+' and tokens[2] == src_node):
            packetsSent += 1

print(f'For the {connection_protocol} connection on the network with src as {src_node} and sink as {dest_node}')
print(f'Packet Size: {packetSize} bytes \n Packets Received at destNode {dest_node}: {packetsRecvd} \npackets Sent from src_node {src_node}: {packetsSent}')

