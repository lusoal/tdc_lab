from connection import connection

def select_from_database(user, password, host, database):
    session = connection(user, password, host, database)
    query = "SHOW DATABASES"
    if session:
        try:
            result_proxy = session.execute(query)
            result = result_proxy.fetchall()
            print (result)
            return result
        except Exception as e:
            print (e)
            return False