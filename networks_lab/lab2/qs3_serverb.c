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

int main()
{
  char *ip = "127.0.0.1";
  int port = 8080;
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
  printf("[+]Server socket created successfully.\n");

  server_addr.sin_family = AF_INET;
  server_addr.sin_port = port;
  server_addr.sin_addr.s_addr = inet_addr(ip);

  e = bind(sockfd, (struct sockaddr *)&server_addr, sizeof(server_addr));
  if (e < 0)
  {
    perror("[-]Error in bind");
    exit(1);
  }
  printf("[+]Binding successfull.\n");

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

  int a[10];
  char *filenames[10] = {"file_part1", "file_part2", "file_part3", "file_part4", "file_part5", "file_part6", "file_part7", "file_part8", "file_part9", "file_part10"};

  int valread = recv(new_sock, a, sizeof(a), 0);
  printf("Chunks to send from server B(-1)\n");
  for (int i = 0; i < 10; ++i)
    printf("%d", a[i]);
  printf("\n");
  for (int i = 0; i < 10; ++i)
  {
    if (a[i] == -1)
    {

      FILE *fp;
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
  valread = recv(new_sock, waitmsgthanks, 1024, 0);
  printf("%s", waitmsgthanks);
  return 0;
}
