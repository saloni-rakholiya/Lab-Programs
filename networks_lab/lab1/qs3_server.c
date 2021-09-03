// Server 
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <ctype.h>
#include <string.h>
#include <math.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
  
#define PORT     8080
#define MAXLINE 1024
  
// Driver code
int main() {
    int sockfd;
    struct sockaddr_in servaddr, cliaddr;
    int flag_done=0;  
    // Creating socket file descriptor
    if ( (sockfd = socket(AF_INET, SOCK_DGRAM, 0)) < 0 ) {
        perror("socket creation failed");
        exit(EXIT_FAILURE);
    }
      
    memset(&servaddr, 0, sizeof(servaddr));
    memset(&cliaddr, 0, sizeof(cliaddr));
      
    // Filling server information
    servaddr.sin_family    = AF_INET; // IPv4
    servaddr.sin_addr.s_addr = INADDR_ANY;
    servaddr.sin_port = htons(PORT);
      
    // Bind the socket with the server address
    if ( bind(sockfd, (const struct sockaddr *)&servaddr, 
            sizeof(servaddr)) < 0 )
    {
        perror("bind failed");
        exit(EXIT_FAILURE);
    }
      
    int len, n;
  
    len = sizeof(cliaddr);  //len is value/resuslt
  
    while(1)
    {  
    float a[5];
    float b[5];
    n = recvfrom(sockfd, a, MAXLINE, 
                MSG_WAITALL, ( struct sockaddr *) &cliaddr,
                &len);
    
    printf("Array 1:\n");
    for(int i=0;i<5;++i) printf("%f ",a[i]);

    n = recvfrom(sockfd, b, MAXLINE, 
                MSG_WAITALL, ( struct sockaddr *) &cliaddr,
                &len);
    printf("\nArray 2:\n");
    for(int i=0;i<5;++i) printf("%f ",b[i]);

    int flag=0;
    for(int i=0;i<5;++i)
    if(((int)a[i]%2) ||((int)b[i]%2) || (int)floor((double)a[i])!=(int)a[i] || (int)floor((double)b[i])!=(int)b[i]) flag=1;

    if(flag==0)
    {
        int x[2];
        int sum1=0;
        int sum2=0;
        for(int i=0;i<5;++i)
        {
            sum1+=a[i];
            sum2+=b[i];
        }
        x[0]=sum1;
        x[1]=sum2;
        sendto(sockfd, x, MAXLINE, 
        MSG_CONFIRM, (const struct sockaddr *) &cliaddr,
            len);
        printf("\nSums sent from server to client.\n"); 
        break;
    }
    else printf("\nArray had error!!\n");
    }  
    return 0;
}