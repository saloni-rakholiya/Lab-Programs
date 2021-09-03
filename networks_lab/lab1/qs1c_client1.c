#include <stdio.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <string.h>
#define PORT 8080
//struct to send
struct mystruct{
    int i;
    float f;
    char ch;
};

int main()
{
    int mysocket = 0;
    struct sockaddr_in serv_addr;
    struct mystruct currstruct={6,2.5,'x'};
    if ((mysocket = socket(AF_INET, SOCK_STREAM, 0)) < 0)
    {
        printf("\n Socket creation error \n");
        return -1;
    }
   
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_port = htons(PORT);
       
    // Convert IPv4 and IPv6 addresses from text to binary form
    if(inet_pton(AF_INET, "127.0.0.1", &serv_addr.sin_addr)<=0) 
    {
        printf("\nInvalid address/ Address not supported \n");
        return -1;
    }
   
    if (connect(mysocket, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0)
    {
        printf("\nConnection Failed \n");
        return -1;
    }
    printf("Sending struct to server with: \nchar %c:  \nint %d , \nfloat %f",currstruct.ch,currstruct.i,currstruct.f);
    send(mysocket , &currstruct , sizeof(struct mystruct), 0 );
    printf("\nStruct sent from client 1 to server\n");
    return 0;
}