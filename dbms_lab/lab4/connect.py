#!/usr/bin/python
import psycopg2
from configparser import ConfigParser


def config(filename='db.ini', section='postgresql'):
    parser = ConfigParser()
    parser.read(filename)
    db = {}
    if parser.has_section(section):
        params = parser.items(section)
        for param in params:
            db[param[0]] = param[1]
    else:
        raise Exception('Section {0} not found in the {1} file'.format(section, filename))
    return db


def connect():
    conn = None
    try:
        params = config()
        print('Connecting to the PostgreSQL database...')
        conn = psycopg2.connect(**params)
        cur = conn.cursor()
        
	# execute a statement
        print('PostgreSQL database version:')
        cur.execute('SELECT version()')
        
        cur.close()
        conn.commit()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()

def insert(tablename,patient_id,patient_name, diagnosis, Contact_no, Date_of_admission):
    conn = None
    try:
        params = config()
        conn = psycopg2.connect(**params)
        cur = conn.cursor()
        
	# execute a statement
        print('Inserting values into '+tablename+':')
        cur.execute('insert into '+tablename+' values('+str(patient_id)+",'"+patient_name+"','"+diagnosis+"','" +Contact_no+ "','"+Date_of_admission+  "');")
        cur.close()
        conn.commit()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()

def findpatient(tablename, id):
    conn = None
    try:
        params = config()
        conn = psycopg2.connect(**params)
        cur = conn.cursor()
        
	# execute a statement
        print('Finding details of id '+str(id))
        cur.execute("SELECT * from "+tablename+" where patient_id="+str(id)+";")
        print(f'Number of satisfying records is {cur.rowcount}')
        row = cur.fetchone()
        while row is not None:
            print(row)
            row = cur.fetchone()
        cur.close()
        conn.commit()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()

    


def dropifexists(name):
    conn = None
    try:
        params = config()
        print('Connecting to the PostgreSQL database...')
        conn = psycopg2.connect(**params)
        cur = conn.cursor()
        
	# execute a statement
        print("Dropping if exists")
        comm='DROP TABLE IF EXISTS '+ name +';'
        cur.execute(comm)
        cur.close()
        conn.commit()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()

def createtable(table_name):
    conn = None
    try:
        params = config()
        conn = psycopg2.connect(**params)
        cur = conn.cursor()
        #patient_id,patient_name, diagnosis, Contact_no, Date_of_admission 
        print('Creating table '+table_name)
        comm='CREATE TABLE '+table_name+'(patient_id INT, patient_name VARCHAR(100), diagnosis VARCHAR(100), Contact_no VARCHAR(100), Date_of_admission DATE) ;'
        cur.execute(comm)
        
        cur.close()
        conn.commit()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()

def seetable(tablename):
    conn = None
    try:
        params = config()
        conn = psycopg2.connect(**params)
        cur = conn.cursor()
        
	# execute a statement
        print('Finding details of '+tablename)
        cur.execute("SELECT * from "+tablename)
        print('\nFULL TABLE: \n')
        row = cur.fetchone()
        while row is not None:
            print(row)
            row = cur.fetchone()
        cur.close()
        conn.commit()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()

if __name__ == '__main__':
    dropifexists('patientdets')
    createtable('patientdets')
    #patient_id,patient_name, diagnosis, Contact_no, Date_of_admission 
    insert('patientdets',5,'ramona','cough','0507797563','2021-07-12')
    insert('patientdets',6,'jyothi','jaundice','0507797563','2001-05-3')
    insert('patientdets',7,'zeba','teeth pain','0507797563','2001-05-12')
    insert('patientdets',8,'hiral','cancer','0507797563','2021-05-16')
    insert('patientdets',9,'pavitra','kidney problem','0507797563','2011-05-10')
    insert('patientdets',1,'sal','alzheimers','0507797563','2021-05-2')
    insert('patientdets',2,'hetvi','fever','0507797563','2001-05-23')
    insert('patientdets',3,'megh','cold','0507797563','2009-05-30')
    insert('patientdets',4,'hinal','covid','0507797563','2005-04-23')
    insert('patientdets',10,'ram','headache','0507797563','2002-05-19')

    
    seetable('patientdets')

    findpatient('patientdets',1)
    findpatient('patientdets',2)
