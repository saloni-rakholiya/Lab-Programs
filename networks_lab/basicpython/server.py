import socket

host = ''
port = 7777

def get_result_string(word: str) -> str:
    result = []
    for letter in word:
        if letter.isdigit():
            if letter == '9':
                result.append('0')
            else:
                result.append(chr(ord(letter)+1))
        elif letter.isalpha():
            if letter == 'z':
                result.append('a')
            elif letter == 'Z':
                result.append('A')
            else:
                result.append(chr(ord(letter)+1))
        else:
            result.append('.')
    return ''.join(result)

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR | socket.SO_REUSEPORT, 1)
    s.bind((host, port))
    s.listen()
    print('listening from', s.getsockname())
    conn, addr = s.accept()
    print('accepted from', addr)
    while True:
        word = conn.recv(1024).decode()
        print(f'R: {word}')
        if word == 'BYEBYE':
            print(f'S: {word}')
            conn.sendall(b'BYEBYE')
            break
        else:
            result = get_result_string(word)
            print(f'S: {result}')
            conn.sendall(result.encode())
