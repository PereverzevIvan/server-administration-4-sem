import psycopg2

db_config = {
    "host": "db",
    "database": "mydb",
    "user": "manager",
    "password": "12345678",
}


def get_data():
    """Retrieve data from the vendors table"""
    try:
        with psycopg2.connect(**db_config) as conn:
            with conn.cursor() as cur:
                cur.execute("SELECT * FROM students")
                rows = cur.fetchall()

                print("The number of rows: ", cur.rowcount)
                for row in rows:
                    print(row)

    except (Exception, psycopg2.DatabaseError) as error:
        print(error)


if __name__ == "__main__":
    get_data()
