'''
Usage: python get_args.py <low> <high> <size>
'''

import random
import sys

def getArguments(low: int, high: int):
    data = [x for x in range(low, high + 1)]
    random.shuffle(data)
    return data

def run():
    [low, high] = [int(x) for x in sys.argv[1:]]
    args = getArguments(low, high)
    line = ''
    for arg in args:
        line += f'{arg}' + ' '
    line = line[:-1]
    print(line)
    with open('args.txt', 'w') as file:
        file.write(line)
    
run()