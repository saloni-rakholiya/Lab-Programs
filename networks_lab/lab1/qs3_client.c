#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/time.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
  
#define PORT     8080
#define MAXLINE 1024

int main() {
    int socket_desc;
    //timestamp for retransmission
    struct timeval tv;
    tv.tv_sec = 0;
    tv.tv_usec = 100000;
    int flag_done=0;
    float a[5];
    float b[5];
    struct sockaddr_in     servaddr;
  
    // Creating socket file descriptor
    if ( (socket_desc = socket(AF_INET, SOCK_DGRAM, 0)) < 0 ) {
        perror("socket creation failed");
        exit(EXIT_FAILURE);
    }
  
    memset(&servaddr, 0, sizeof(servaddr));
      
    // Filling server information
    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(PORT);
    servaddr.sin_addr.s_addr = INADDR_ANY;

    //retransmission timeout

    if (setsockopt (socket_desc, SOL_SOCKET, SO_RCVTIMEO, (char *)&tv, sizeof(tv)) < 0)
    perror("setsockopt failed\n");
    //
    int n=-1, len;
    while(n<0)
    {
    printf("Enter 5 elements for array 1: \n");
    for(int i=0;i<5;++i) 
    scanf("%f",&a[i]);  

    printf("Enter 5 elements for array 2: \n");
    for(int i=0;i<5;++i) 
    scanf("%f",&b[i]);  

    sendto(socket_desc, a, sizeof(a),
        MSG_CONFIRM, (const struct sockaddr *) &servaddr, 
            sizeof(servaddr));
    printf("Array 1 sent.\n");

    sendto(socket_desc, b, sizeof(b),
        MSG_CONFIRM, (const struct sockaddr *) &servaddr, 
            sizeof(servaddr));
    printf("Array 2 sent.\n");
    int x[2];    
    n = recvfrom(socket_desc, x, sizeof(x), MSG_WAITALL, (struct sockaddr *) &servaddr,&len);   
    
    if(n>=0)       
    for(int i=0;i<2;++i)
    printf("%d ",x[i]);
    }
    //close socket
    close(socket_desc);
    return 0;
}