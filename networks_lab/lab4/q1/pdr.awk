#packet Delivery Ratio
BEGIN {
	sendPkt =0
	recvPkt=0
	dropPkt=0
}

{
packet=$5
event = $1
if((packet == "tcp" ||packet == "cbr") && event !="r") {
	sendPkt++;
}

if(event =="r" && (packet == "tcp" || packet == "cbr") ) {
	recvPkt++;
}

if(event =="d") {
	dropPkt++;
}

}

END {
	printf ("the sent packets are %d \n", sendPkt/2);
	printf ("the received packets are %d \n", recvPkt);
	printf ("the dropped packets are %d \n", dropPkt);
	printf ("Packet Delivery Ratio is %f \n", (recvPkt*2/sendPkt));
}