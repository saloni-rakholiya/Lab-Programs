
// Server side C/C++ program to demonstrate Socket programming
#include <unistd.h>
#include <stdio.h>
#include <sys/socket.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <string.h>
#define PORT 8080
int main(int argc, char const *argv[])
{
    int server_fd, new_socket, valread;
    struct sockaddr_in address;
    int opt = 1;
    int addrlen = sizeof(address);
    
       
    // Creating socket file descriptor
    if ((server_fd = socket(AF_INET, SOCK_STREAM, 0)) == 0)
    {
        perror("socket failed");
        exit(EXIT_FAILURE);
    }
       
    // Forcefully attaching socket to the port 8080
    if (setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT,
                                                  &opt, sizeof(opt)))
    {
        perror("setsockopt");
        exit(EXIT_FAILURE);
    }
    address.sin_family = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;
    address.sin_port = htons( PORT );
       
    // Forcefully attaching socket to the port 8080
    if (bind(server_fd, (struct sockaddr *)&address, 
                                 sizeof(address))<0)
    {
        perror("bind failed");
        exit(EXIT_FAILURE);
    }
    if (listen(server_fd, 3) < 0)
    {
        perror("listen");
        exit(EXIT_FAILURE);
    }
    if ((new_socket = accept(server_fd, (struct sockaddr *)&address, 
                       (socklen_t*)&addrlen))<0)
    {
        perror("accept");
        exit(EXIT_FAILURE);
    }

    while(1)
    {
    char buffer[1024] = {0};
    valread = read( new_socket , buffer, 1024);
    printf("Recieved %s\n",buffer );
    if(strcmp(buffer, "BYEBYE") == 0)
    {
        send(new_socket , buffer , strlen(buffer) , 0 );
        break;
    }
    else {
        //Any character otherthan a letter or a digit will be replaced by a period(.)”
        for(int i=0;i<strlen(buffer);++i)
        {
            if(buffer[i]>='a' && buffer[i]<='z')
            {
                if(buffer[i]=='z') buffer[i]='a';
                else buffer[i]=(char)(buffer[i]+1);
            }
            else if(buffer[i]>='A' && buffer[i]<='Z')
            {
                if(buffer[i]=='Z') buffer[i]='A';
                else buffer[i]=(char)(buffer[i]+1);
            }
            else if(buffer[i]>='0' && buffer[i]<='9')
            {
                if(buffer[i]=='9') buffer[i]='0';
                else buffer[i]=(char)(buffer[i]+1);
            }
            else buffer[i]='.';

        }
        send(new_socket , buffer , strlen(buffer) , 0 );
    }
    
    printf("Reply sent\n");
    }
    
    return 0;
}