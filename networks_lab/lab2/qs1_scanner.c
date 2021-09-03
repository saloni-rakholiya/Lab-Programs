// Client side C/C++ program to demonstrate Socket programming
#include <stdio.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <string.h>

int main()
{
	int sock = 0, valread;
	struct sockaddr_in serv_addr;
	char *hello = "Hello from client";
	char buffer[1024] = {0};
	int start,end;
	printf("Enter starting port number for searching: ");
	scanf("%d",&start);
	printf("Enter ending port number for searching: ");
	scanf("%d",&end);
	printf("\n");
	for(int i=start;i<end;++i)
    {

	if ((sock = socket(AF_INET, SOCK_STREAM, 0)) < 0)
	{
		printf("\n Socket creation error \n");
		return -1;
	}

	serv_addr.sin_family = AF_INET;
    serv_addr.sin_port = htons(i);
	
	// Convert IPv4 and IPv6 addresses from text to binary form
	if(inet_pton(AF_INET, "127.0.0.1", &serv_addr.sin_addr)<=0)
	{
		printf("\nInvalid address/ Address not supported \n");
		return -1;
	}

	if (connect(sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0)
	{
		//printf("\nPort %d closed\n",i);
	}
    else {
        printf("Port %d open\n",i);
    }
    }
	return 0;
}
