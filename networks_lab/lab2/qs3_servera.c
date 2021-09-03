#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <arpa/inet.h>
#define SIZE 1024

void send_file(FILE *fp, int sockfd)
{
	int n;
	char data[SIZE] = {0};
	char ch;

	while ((ch = fgetc(fp)) != EOF)
	{
		if (send(sockfd, &ch, sizeof(ch), 0) == -1)
		{
			perror("[-]Error in sending file.");
			exit(1);
		}
	}
	ch = EOF;
	if (send(sockfd, &ch, sizeof(ch), 0) == -1)
	{
		perror("[-]Error in sending file.");
		exit(1);
	}
}

FILE *openforwrite(int filecounter)
{
	char fileoutputname[15];

	sprintf(fileoutputname, "file_part%d", filecounter);
	return fopen(fileoutputname, "a");
}

int main()
{
	//preprocess file
	// FILE *ptr_readfile;
	// FILE *ptr_writefile;
	// char line [128];
	// int filecounter=1, linecounter=1;

	// ptr_readfile = fopen("randomTxt2.txt","r");
	// if (!ptr_readfile)
	// 	return 1;

	// ptr_writefile = openforwrite(filecounter);

	// while (fgets(line, sizeof line, ptr_readfile)!=NULL) {
	// 	if (linecounter == 11) {
	// 		linecounter = 1;
	// 		filecounter=1;
	// 	}
	// 	ptr_writefile = openforwrite(filecounter);
	// 	if (!ptr_writefile)
	// 		return 1;
	// 	fprintf(ptr_writefile,"%s\n", line);
	// 	fclose(ptr_writefile);
	// 	linecounter++;
	// 	filecounter++;
	// }
	// fclose(ptr_readfile);
	//preprocessing ends

	//deciding chunks
	int total = 0;
	int a[10];
	for (int i = 0; i < 10; ++i)
		a[i] = -1;

	while (1)
	{
		int x = rand() % 10;
		if (a[x] == -1)
		{
			total += 1;
			a[x] = 1;
		}
		if (total == 5)
			break;
	}
	printf("Checker to track which chunks are sent from server A(1) and which are not(-1)\n");
	for (int i = 0; i < 10; ++i)
		printf("%d", a[i]);

	printf("\n");

	char *ip = "127.0.0.1";
	int port = 8086;
	int e;

	int sockfd, new_sock;
	struct sockaddr_in server_addr, new_addr;
	socklen_t addr_size;
	char buffer[SIZE];

	sockfd = socket(AF_INET, SOCK_STREAM, 0);
	if (sockfd < 0)
	{
		perror("[-]Error in socket");
		exit(1);
	}
	server_addr.sin_family = AF_INET;
	server_addr.sin_port = port;
	server_addr.sin_addr.s_addr = inet_addr(ip);

	e = bind(sockfd, (struct sockaddr *)&server_addr, sizeof(server_addr));
	if (e < 0)
	{
		perror("[-]Error in bind");
		exit(1);
	}
	if (listen(sockfd, 10) == 0)
	{
		printf("[+]Listening....\n");
	}
	else
	{
		perror("[-]Error in listening");
		exit(1);
	}

	addr_size = sizeof(new_addr);
	new_sock = accept(sockfd, (struct sockaddr *)&new_addr, &addr_size);

	char *qs;

	int valread = recv(new_sock, qs, 1024, 0);
	send(new_sock, a, sizeof(a), 0);

	char *filenames[10] = {"file_part1", "file_part2", "file_part3", "file_part4", "file_part5", "file_part6", "file_part7", "file_part8", "file_part9", "file_part10"};
	for (int i = 0; i < 10; ++i)
	{
		if (a[i] != -1)
		{

			FILE *fp;
			//char *filename = "randomTxt2.txt";
			fp = fopen(filenames[i], "r");
			if (fp == NULL)
			{
				perror("[-]Error in reading file.");
				exit(1);
			}
			send_file(fp, new_sock);
			printf("Chunk %d sent from server\n", i + 1);
		}
	}

	char waitmsgthanks[1024];
	while (1)
	{
		valread = recv(new_sock, waitmsgthanks, 1024, 0);
		if (valread <= 0)
			break;
	}
	printf("%s", waitmsgthanks);
	return 0;
}