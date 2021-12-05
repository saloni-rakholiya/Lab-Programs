import sys
import matplotlib.pyplot as plt 


def main():
    x=[]
    y=[]
    [inf] = sys.argv[1:3]
    [inf] = [str(i ) for i in [inf]]
    for line in open(inf):
        listWords = line.split(" ")
        s=listWords[1]
        listWords[1]=s[:-2]
        listWords[0]=float(listWords[0])
        listWords[1]=float(listWords[1])
        #print(listWords)
        x.append(listWords[0])
        y.append(listWords[1])
    plt.plot(x,y,color='green',marker='o', markerfacecolor='blue', markersize=6)    
    plt.xlabel('x - axis')
    plt.ylabel('y - axis')
    plt.title(inf[:-4])
    plt.show()

main()