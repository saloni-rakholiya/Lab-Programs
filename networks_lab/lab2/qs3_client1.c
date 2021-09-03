#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <arpa/inet.h>
#define SIZE 1024

void write_file(int sockfd, char *filename)
{
	int n = -1;
	FILE *fp;
	char buffer[SIZE];

	fp = fopen(filename, "a");
	char ch;
	while (1)
	{
		n = recv(sockfd, &ch, sizeof(ch), 0);
		if (n <= 0)
			break;
		fprintf(fp, "%c", ch);
		if (ch == EOF)
			return;
	}
	return;
}

int main()
{
	char *ip = "127.0.0.1";
	int port = 8086;
	int e;

	int sockfd;
	struct sockaddr_in server_addr;

	sockfd = socket(AF_INET, SOCK_STREAM, 0);
	if (sockfd < 0)
	{
		perror("[-]Error in socket");
		exit(1);
	}
	server_addr.sin_family = AF_INET;
	server_addr.sin_port = port;
	server_addr.sin_addr.s_addr = inet_addr(ip);

	e = connect(sockfd, (struct sockaddr *)&server_addr, sizeof(server_addr));
	if (e == -1)
	{
		perror("[-]Error in socket");
		exit(1);
	}

	int buffer[10];
	char *msgask = "Send packets!\n";
	send(sockfd, msgask, strlen(msgask), 0);
	printf("%s", msgask);
	int valread = recv(sockfd, buffer, sizeof(buffer), 0);
	printf("Chunks which will be got from server A(1) and which from B(-1)\n");
	for (int i = 0; i < 10; ++i)
		printf("%d ", buffer[i]);
	//
	printf("\n");
	char *filenames[10] = {"rfile_part1", "rfile_part2", "rfile_part3", "rfile_part4", "rfile_part5", "rfile_part6", "rfile_part7", "rfile_part8", "rfile_part9", "rfile_part10"};

	for (int i = 0; i < 10; ++i)
	{
		if (buffer[i] != -1)
		{

			write_file(sockfd, filenames[i]);
			printf("Chunk %d got from server\n", i + 1);
		}
	}

	//second

		int sockfd2;
		struct sockaddr_in server_addr2;
		int port2=8080;
		sockfd2 = socket(AF_INET, SOCK_STREAM, 0);
		if (sockfd2 < 0)
		{
			perror("[-]Error in socket");
			exit(1);
		}
		server_addr2.sin_family = AF_INET;
		server_addr2.sin_port = port2;
		server_addr2.sin_addr.s_addr = inet_addr(ip);

		e = connect(sockfd2, (struct sockaddr *)&server_addr2, sizeof(server_addr2));
		if (e == -1)
		{
			perror("[-]Error in socket");
			exit(1);
		}

	send(sockfd2, buffer, sizeof(buffer), 0);

		for(int i=0;i<10;++i)
	  {
	    if(buffer[i]==-1)
	    {

	      write_file(sockfd2,filenames[i]);
		  printf("Chunk %d got from server\n",i+1);
	    }
	  }

	char thanks[1024] = "Thank You from client!";
	send(sockfd, thanks, 1024, 0);
	send(sockfd2, thanks,1024, 0);
	return 0;
}