#imports
import sys
#args
file = open(sys.argv[1])
X = int(sys.argv[2])
print('Processing files!')
#process input args
fields = []
for part_file in iter(file):
    part_file = part_file.split(" ")
    if(part_file[0] in ['r', 'D', 's'] and part_file[3] == 'MAC' and part_file[7] == 'cbr'):
        fields.append({'node_id': part_file[2], 'Event_Type': part_file[0], 'UPID': int(part_file[6])})


print ("----------Done parsing trace file----------")
print ("Probablity calculation happening!")

#calculating
received_Packet_len = len(set(trace['UPID'] for trace in fields if trace['Event_Type'] == 'r' and trace['node_id'] == '_0_'))
#computation of P
Packets_sent = len(set(trace['UPID'] for trace in fields))
print("Probability is %.2f%%" % (float(received_Packet_len)/Packets_sent*100))
#preparing output file
pr = (float(received_Packet_len)/Packets_sent)
output_file = open('pr-values.txt', 'a')
output_file.write(f'{X} {pr} \n')
output_file.close()