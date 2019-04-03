from sqlalchemy import *
from sqlalchemy.orm import *

def connection(user, password, host, database):
    #connection db
    try:
        print ("mysql://"+user+":"+password+"@"+host+"/"+database)
        engine = create_engine("mysql://"+user+":"+password+"@"+host+"/"+database)
        #creating session
        Session = sessionmaker()
        Session.configure(bind=engine)
        session = Session()
        return session
    except Exception as e:
        print (e)
        return False