#include <arpa/inet.h>
#include <iostream>
#include <netdb.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <string>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>
using namespace std;

void HANDLE_SEND_RECV_ERRORS(int st) {
  if ((st) == -1) {
    perror("Error in send()/recv()");
    exit(254);
  } else if ((st) == 0) {
    perror("Connection is closed because send/recv returned 0");
    exit(255);
  }
}

void die_with_error(const char *errorMessage) {
  perror(errorMessage);
  exit(1);
}

int recv_int(int sock) {
  int res = -1;
  int recv_msg_size;

  recv_msg_size = recv(sock, &res, sizeof(res), 0);
  HANDLE_SEND_RECV_ERRORS(recv_msg_size);
  return res;
}

void send_str(int sock, char msg_buf[30]) {
  int len = send(sock, msg_buf, strlen(msg_buf), 0);
  HANDLE_SEND_RECV_ERRORS(len);
  if (len != strlen(msg_buf))
    die_with_error("Couldn't send() fully");
}

void send_int(int sock, int payload) {
  int len = send(sock, &payload, sizeof(payload), 0);
  HANDLE_SEND_RECV_ERRORS(len);
  if (len != sizeof(payload))
    die_with_error("Couldn't send() fully");
}

void recv_str(int sock, char buf[30]) {
  int recv_msg_size;

  recv_msg_size = recv(sock, buf, 30, 0);
  HANDLE_SEND_RECV_ERRORS(recv_msg_size);
  buf[recv_msg_size] = '\0';
}

void handle(int sock, int q_no) {
  if (q_no < 0 || q_no > 5)
    return;

  if (q_no == 1) {
    int partno;
    printf("Enter the part number= ");
    scanf("%d", &partno);

    send_int(sock, partno);
    char partname[30];
    recv_str(sock, partname);

    printf("%s\n\n", partname);
  } else if (q_no == 2) {
    int partno;
    printf("Enter the part number= ");
    scanf("%d", &partno);

    send_int(sock, partno);
    int qty = recv_int(sock);

    printf("part quantity= %d\n\n", qty);
  } else if (q_no == 3) {
    int custid, partno, qty;

    printf("Enter user id= ");
    scanf("%d", &custid);

    printf("Enter the part number= ");
    scanf("%d", &partno);

    printf("Enter part's quantity= ");
    scanf("%d", &qty);

    send_int(sock, custid);
    send_int(sock, partno);
    send_int(sock, qty);

    char status[30];
    recv_str(sock, status);

    printf("Current status= %s\n\n", status);
  } else if (q_no == 4) {
    int partno;
    printf("Enter the part number= ");
    scanf("%d", &partno);

    send_int(sock, partno);
    int num = recv_int(sock);

    printf("%d subparts of given part= \n", num);

    char response[30];
    for (int i = 0; i < num; ++i) {
      recv_str(sock, response);
      printf("%s, ", response);
    }
    printf("\n\n");
  } else if (q_no == 5) {
    char partname[30];

    printf("Enter the part name= ");
    scanf("%s", partname);

    send_str(sock, partname);
    int partno = recv_int(sock);

    if (partno == -1)
      printf("Does not exist\n\n");
    else
      printf("Part number= %d\n\n", partno);
  }
}

int main() {
  int sock;
  unsigned short server_port;
  server_port = 8080;

  struct addrinfo myaddr, *res;
  memset(&myaddr, 0, sizeof(myaddr));
  myaddr.ai_family = AF_UNSPEC;
  myaddr.ai_socktype = SOCK_STREAM;

  int status =
      getaddrinfo("127.0.0.1", to_string(server_port).c_str(), &myaddr, &res);
  if (status == -1)
    die_with_error("getaddrinfo() failed");

  if ((sock = socket(res->ai_family, res->ai_socktype, res->ai_protocol)) < 0)
    die_with_error("socket() failed");

  if (connect(sock, res->ai_addr, res->ai_addrlen) < 0)
    die_with_error("connect() failed");

  freeaddrinfo(res);

  int q_no = 0;
  while (q_no != -5) {
    printf("MENU\n");
    printf("=========================================\n");
    printf("1. Get part name from number\n2. Get quantity of avaliable parts\n3. place an order for a part\n4. Get the list of subparts\n5. search for a part\nEnter query to send: \n");

    scanf("%d", &q_no);
    send_int(sock, q_no);
    handle(sock, q_no);
  }

  close(sock);
  exit(0);
}