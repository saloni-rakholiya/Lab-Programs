#include <iostream>
#include <bits/stdc++.h>

using namespace std;

// function to generate tokens
void strtok(string s, vector<string> &arr)
{
    stringstream ss(s);
    string string_piece;
    while (ss >> string_piece)
    {
        arr.push_back(string_piece);
    }
}

//computing throughput
class throughput_calc
{
    ofstream f;
    string input_file;
    map<int,vector<float>> times;
    float last_time;

public:
    throughput_calc(string input_file)
    {
        this->input_file = input_file;
        times[3] = vector<float>();
        times[5] = vector<float>();
        times[7] = vector<float>();
    }
    ~throughput_calc()
    {
        f.close();
    }

    void processPacketData(char event, float timestamp, int toNode,int sequence_number){
        if(sequence_number > 100) return;
        if(event == 'r' && toNode ==3 || toNode ==5 || toNode ==7){
                times[toNode].push_back(timestamp);
        }
    }

    void printValues(){
        float average = 0;
        float standard_deviation = 0;
        float difference;
        f.open("node3_data");
        for(int i=1;i<100;i++){
            difference = times[3][i]-times[3][i-1];
            average += difference/100;
            standard_deviation += difference*difference/100;
            f<<i<<" "<<difference<<"\n";
        }
        cout<<"Average for 3 : "<< average << "\n";
        cout<<"Standard deviation for 3 :"<< sqrt(abs(standard_deviation - average*average))<<"\n";
        f.close();
        standard_deviation = 0;
        average = 0;
        f.open("node5_data");
        for(int i=1;i<100;i++){
            difference = times[5][i]-times[5][i-1]; 
            average += difference/100;
            standard_deviation += difference*difference/100;
            f<<i<<" "<<difference<<"\n";
        }
        cout<<"Average for 5 : "<< average << "\n";
        cout<<"Standard deviation for 5 : "<< sqrt(abs(standard_deviation - average*average))<<"\n";
        f.close();
        average =0;
        standard_deviation = 0;
        f.open("node7_data");
        for(int i=1;i<100;i++){
            difference = times[7][i]-times[7][i-1];
            average += difference/100;
            standard_deviation += difference*difference/100; 
            f<<i<<" "<<difference<<"\n";
        }
        cout<<"Average for 7 : "<< average << "\n";
        cout<<"Standard deviation for 7 : "<< sqrt(abs(standard_deviation - average*average))<<"\n";
        f.close();
    }
};


int main(int argc, char **argv)
{
    //params and args
    char event;
    float timestamp;
    int fromNode, toNode;
    string packetType;
    float srcAddr, toAddr;
    int packetId;
    int packetSize;
    int seqId;
    string temp;
    //read input files
    ifstream f("mytopology.tr");
    throughput_calc tp("mytopology");

    while(getline(f, temp))
    {
        vector<string> string_parts;
        strtok(temp, string_parts);
        if(string_parts.size()<12) continue;
        event = string_parts[0][0];
        timestamp = stof(string_parts[1]);
        fromNode = stoi(string_parts[2]);
        toNode = stoi(string_parts[3]);
        packetType = string_parts[4];
        packetSize = stoi(string_parts[5]);
        srcAddr = stof(string_parts[8]);
        toAddr = stof(string_parts[9]);
        seqId = stoi(string_parts[10]);
        packetId = stoi(string_parts[11]);

        tp.processPacketData(event,timestamp,toNode,seqId);
    }
    tp.printValues();
}