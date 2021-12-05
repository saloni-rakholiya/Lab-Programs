from configparser import ConfigParser
from csv import reader
import os

def config(filename: str = 'database.ini', section: str = 'postgresql'):
    #create a parser Object
    parser = ConfigParser()
    #read config file
    parser.read(filename)

    #get section
    db = {}
    if parser.has_section(section):
        params = parser.items(section)
        for param in params:
            db[param[0]] = param[1]
    else:
        raise Exception(f'Section {section} not found in the file {filename}')
    
    return db

def readFile(filepath: str):
    if os.path.isfile(filepath):
        file = open(filepath)
        command = file.read()
        file.close()
        return command
    else:
        return None

def read_csv(filename: str = 'insert_rows.csv'):
    tuples = []
    with open(filename, 'r') as file:
        csv_reader = reader(file)
        header = next(csv_reader)
        if header is not None:
            for row in csv_reader:
                row[0] = int(row[0])
                tuples.append(tuple(row))
    return tuples
