from fastapi import FastAPI
import psycopg2
import os

app = FastAPI()

@app.get("/")
def hello():
    conn = psycopg2.connect(
        dbname="magalu",
        user=os.getenv("username"),
        password=os.getenv("password"),
        host="host.docker.internal"
    )

    cur = conn.cursor()
    cur.execute("SELECT 'Hello Magalu Cloud';")
    result = cur.fetchone()

    return {"message": result[0]}