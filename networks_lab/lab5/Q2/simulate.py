"""
Usage: 
python <filename> <numofConnections> <interval - optional, default is 1.0>  
Example: 
for low
python ../../simulate.py 2 10.0
for med
python ../../simulate.py 7 10.0
for high
python ../../simulate.py 12 10.0
"""

from typing import List, Protocol
import sys
import collections #for default_dict

class lineInfo: 
    def __init__(self, line: List[str]) -> None:
        self.event = line[0]
        self.time = float(line[1])
        self.from_node = int(line[2])
        self.to_node = int(line[3])
        self.packet_type = line[4]
        self.packet_sz = int(line[5])
        self.flags = line[6]
        self.flow_id = int(line[7])
        self.src_addr = line[8]
        self.dest_addr = line[9]
        self.seq_num = int(line[10])
        self.packet_id = int(line[11])

def packLine(line: List[str]) ->lineInfo: 
    return lineInfo(line)

class Simulator:
    
    def __init__(self, interval: float = 1.0, filename: str = 'trace.tr') -> None: 
        self.trfile = filename
        self.lines = [packLine(x) for x in [line.split() for line in open(self.trfile).readlines()]]
        self.interval = interval
    

    def throughput(self, packet_type: str, destNode: int, file_out: str = 'throughput_out.txt'):
        fp= open(file_out,"w")
        destNode -= 1
        intervalSize = 0
        totalSize = 0
        clock = 0
        current_time=0
        last_time =0
        for line in self.lines:
            current_time = line.time
            if(line.event=="r" and line.to_node == destNode and line.packet_type == packet_type):
                intervalSize += line.packet_sz
                totalSize += line.packet_sz
            if(current_time-last_time >= self.interval):
                clock += self.interval
                last_time = current_time
                if(intervalSize>0):
                    fp.write("{} {}\n".format(current_time, 0.00008 * (intervalSize)/self.interval))
                    intervalSize = 0
        fp.close()
        print(f"Average throughput for destNode {destNode} is {0.000008*totalSize/clock} Mbits/sec")

    def bandwithUtilisation(self, packet_type: str, destNode: int, max_bw: int = 10, file_out: str = "bwu_out.txt"):
        fp= open(file_out,"w")
        destNode -= 1
        intervalSize = 0
        totalSize = 0
        clock = 0
        current_time=0
        last_time =0
        for line in self.lines:
            current_time = line.time
            if(line.event=="r" and line.to_node == destNode and line.packet_type == packet_type):
                intervalSize += line.packet_sz
                totalSize += line.packet_sz
            if(current_time-last_time >= self.interval):
                clock += self.interval
                last_time = current_time
                if(intervalSize>0):
                    fp.write("{} {}\n".format(current_time, (0.00008 * (intervalSize)/self.interval) / max_bw))
                    intervalSize = 0
        fp.close()
        print(f"Average Bandwith Utilisation is {(0.000008*totalSize/clock)/max_bw}")
        
    def get_sent_packets(self, packet_type: str, src: str, dest: str):
        sent = collections.defaultdict(lambda: set())
        for line in self.lines:
            if(line.event=="+"):
                if(line.packet_type == packet_type and line.src_addr == src and
                        line.dest_addr == dest and line.from_node == int(float(src))):
                    sent[line.packet_type].add(line.packet_id)
        info = dict([(x,len(y)) for x, y in sent.items()])
        print(f'{packet_type} Packets sent for {src}->{dest} is: {info}')
        return info

    def get_recvd_packets(self,packet_type: str,src:str,dest:str):
        recvd = collections.defaultdict(lambda: set())
        for line in self.lines:
            if(line.event=="r"):
                if(line.packet_type == packet_type and line.src_addr == (src) and
                        line.dest_addr==(dest) and line.to_node==int(float(dest))):
                    recvd[line.packet_type].add(line.packet_id)
        info = dict([(x,len(y)) for x, y in recvd.items()])
        print(f'{packet_type} Packets received for {src}->{dest} : {info}')
        return info

    def plr(self,src_nodes: List[int] , dest_nodes:List[int] , file_out: str = "plr_out.txt"):
        fp= open(file_out,"w")
        dest_nodes = [x - 1 for x in dest_nodes]
        src_nodes = [x - 1 for x in src_nodes]
        packet_recvd =0
        packet_sent = 0
        current_time=0
        last_time =0
        for line in self.lines:
            current_time = line.time
            if(line.event=="r" and line.to_node in dest_nodes ):
                packet_recvd+=1
            if(line.event=="+" and line.from_node in src_nodes):
                packet_sent+=1
            if(current_time-last_time >= self.interval):
                last_time = current_time
                if(packet_sent>0):
                    fp.write("{} {}\n".format(current_time, ( packet_sent-packet_recvd )/packet_sent))
        fp.close()

    def pdr(self, src_nodes: List[int], dest_nodes: List[int], file_out: str="pdr_out.txt"):
        fp= open(file_out,"w")
        dest_nodes = [x - 1 for x in dest_nodes]
        src_nodes = [x - 1 for x in src_nodes]
        packet_recvd =0
        packet_sent = 0
        current_time=0
        last_time =0
        for line in self.lines:
            current_time = line.time
            if(line.event=="r" and line.to_node in dest_nodes ):
                packet_recvd+=1
            if(line.event=="+" and line.from_node in src_nodes):
                packet_sent+=1
            if(current_time-last_time >= self.interval):
                last_time = current_time
                sys.last_value=current_time
                if(packet_sent>0):
                    fp.write("{} {}\n".format(current_time, ( packet_recvd )/packet_sent))
        fp.close()


    def end_to_end_delay(self,src_nodes: List[int], dest_nodes:List[int], file_out: str="e2e_delay.txt"):
        fp = open(file_out,"w")
        dest_nodes = [x - 1 for x in dest_nodes]
        src_nodes = [x - 1 for x in src_nodes]
        current_time=0
        tdelay = 0
        start_time = collections.defaultdict(lambda: 0.0)
        last_time =0
        for line in self.lines:
            current_time=line.time
            if(line.event=="r" and line.to_node in dest_nodes):
                tdelay+=current_time-start_time[line.packet_id]

            if(line.event=="+" and line.from_node in src_nodes):
                start_time[line.packet_id]= current_time
            if(current_time-last_time >= self.interval):
                last_time=current_time
                fp.write("{} {}\n".format(current_time, tdelay))
        print("Average Delay: {}".format(tdelay/(len(start_time.values()))) )

    def control_overhead(self, out_file: str = "control_overhead.txt"):
        fp = open(out_file, "w")
        control_packet = 0
        all_packets = 0
        last_time = 0
        for line in self.lines:
            if(line.event == "+"):
                all_packets += 1
                if(line.packet_type == "ack"):
                    control_packet += 1
            if(line.time-last_time >= self.interval):
                last_time = line.time
                fp.write("{} {}\n".format(
                    line.time, control_packet/all_packets))
        fp.close()

    def congestion_control(self, out_file: str = "congestion_control.txt"):
        fp = open(out_file, "w")
        last_time = 0
        congestions = 0
        acks = collections.defaultdict(lambda: 0)
        for line in self.lines:
            if(line.event == "+" and line.packet_type == "ack"):
                s = str(line.to_node)+str(line.from_node) + str(line.seq_num)
                acks[s] += 1
                if((acks[s] % 3) == 0):
                    congestions += 1
            if(line.time-last_time >= self.interval):
                last_time = line.time
                fp.write("{} {}\n".format(line.time, float(congestions)))
        fp.close()

def getNodes(n: int, file_name: str = '../../args.txt'):
    with open(file_name, 'r') as file:
        nodes = [int(num) for num in file.readline().split(' ')][:2*n]
    src, dest = nodes[:n], nodes[n:]
    return src, dest
    
def main():
    connectionNum = int(sys.argv[1])
    src, dest = getNodes(connectionNum)
    interval = 1.0
    if(len(sys.argv)>= 3):
        interval = float(sys.argv[2])
    ns = Simulator(interval)
    ns.pdr(src, dest)
    ns.control_overhead()
    ns.congestion_control()

main()
