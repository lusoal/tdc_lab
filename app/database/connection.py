from sqlalchemy import *
from sqlalchemy.orm import *
from sqlalchemy.pool import NullPool


def connection(user, password, host, database):
    #connection db
    try:
        print ("mysql://"+user+":"+password+"@"+host+"/"+database)
        engine = create_engine("mysql://"+user+":"+password+"@"+host+"/"+database, poolclass=NullPool, connect_args={'connect_timeout': 3})
        #creating session
        Session = sessionmaker()
        Session.configure(bind=engine)
        session = Session()
        return session
    except Exception as e:
        print (e)
        return False