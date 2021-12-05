from typing import List
from create_db import readFile, config, read_csv
import psycopg2

def connect():
    conn = None
    try: 
        arguments = config()
        conn = psycopg2.connect(**arguments)
        return conn
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
        return None

def close(conn: connect()):
    if conn is not None:
        conn.close() 

def execute(commands: List[str]):
    conn = connect()
    if conn is not None:
        cur = conn.cursor()
        for command in commands:
            cur.execute(command)
        cur.close()
        conn.commit()
        close(conn)

def create_table(filename = 'create_table.txt'):
    command = readFile(filename)
    if command is not None:
        print(command)
        execute([command])
        print(f'Table created successfully')
    else:
        raise Exception('Incorrect Syntax')

def insert_tuples(tuples: List[tuple], table_name: str = 'seats'):
    if tuples is not None:
        listStr = ''
        n = len(tuples[0])
        listStr = "%s,"*(n - 1) + "%s"
        command = f'insert into {table_name} values (' + listStr + ');'
        
        conn = connect()
        print(conn)
        cur = conn.cursor()
        cur.executemany(command, tuples)
        cur.close()
        conn.commit()
        close(conn)
    
        print(f'{len(tuples)} Record(s) Inserted Successfully\n')


def populate(filename: str = 'insert_rows.csv', table_name: str = 'seats'):
    tuples = read_csv(filename)
    insert_tuples(tuples, table_name)

def insert(row: tuple, table_name: str = 'seats'):
    if row is not None:
        insert_tuples([row], table_name)

def drop_table(table_name: str = 'seats'):
    execute([f'drop table if exists {table_name};'])
    print('Table Dropped Successfully')

def update(name: str, new_dest: str, table_name: str = 'seats'):
    execute([f'''
            update {table_name}
            set dest = '{new_dest}' 
            where name = '{name}';
            '''])
    print('Update Done Successfully\n')

def fetch(name: str, table_name: str = 'seats'):
    conn = connect()
    if conn is not None:
        cur = conn.cursor()
        cur.execute(f"select * from {table_name} where name = '{name}';")
        print(f'Number of satisfying records is {cur.rowcount}')
        row = cur.fetchone()
        while row is not None:
            print(row)
            row = cur.fetchone()
        cur.close()
        close(conn)
    print('')

def fetchall(table_name: str = 'seats'):
    conn = connect()
    if conn is not None:
        cur = conn.cursor()
        cur.execute(f"select * from {table_name};")
        print(f'Number of satisfying records is {cur.rowcount}')
        row = cur.fetchone()
        while row is not None:
            print(row)
            row = cur.fetchone()
        cur.close()
        close(conn)
    print('')

def deleteRow(seatNo: int, table_name: str = 'seats'):
    execute([f'''
              delete from {table_name}
              where seat_no = {seatNo};
              '''])
    print('Delete is Successful\n')

if __name__ == '__main__':
    
    print('Creating Table and Populating it')
    drop_table()
    create_table()
    populate()
    print('Initial Table')
    fetchall()
    
    print('Inserting two new records')
    insert((11, 'Zeba', 'abu dhabi', 'UAE'))
    insert((21, 'Zeba', 'dubai', 'UAE'))
    fetchall()
    
    print('Updating Dest for Zeba, and removing Passenger with seatNo : 10')
    update('Zeba', 'miami')
    deleteRow(10)
    fetchall()

    print('Fetching all trip details for Zeba')
    fetch('Zeba')
    drop_table()