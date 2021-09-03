import numpy as np

letters = np.array([chr(ord('a') + i ) for i in range(26)])

size = input("Enter size in MB: ")
n = int(size) * (1024 ** 2)

txt = np.random.choice(letters, n)

with open('randomTxt2.txt', 'w+') as file:
    file.write(' '.join(txt))