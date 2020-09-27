import psycopg2

# conn = psycopg2.connect('dbname=netology_db user=postgres host=localhost port=5432')
# cur = conn.cursor()
# cur.execute("INSERT INTO student (name, birth) VALUES (%s, %s)",
#             ("Петр Джавоскриптов", "1989-01-01"))
# conn.rollback()   # не применять изменения
# cur.execute('SELECT * FROM student')
# print(cur.fetchall())


def add_course(name):
    with conn.cursor() as curr:
        curr.execute('INSERT INTO course  (name) VALUES (%s) RETURNING id', (name, ))
        return curr.fetchall()


with psycopg2.connect('dbname=netology_db user=postgres host=localhost port=5432') as conn:
    # with conn.cursor() as cur:
    #     # cur.execute('SELECT * FROM student')
    #     cur.execute('SELECT * FROM student LIMIT 1')
    #     print(cur.fetchall())
    # with conn.cursor() as cur:
    #     cur.execute("""CREATE TABLE IF NOT EXISTS course (
    #     id serial PRIMARY KEY,
    #     name varchar(100))""")
    #     cur.execute("""CREATE TABLE IF NOT EXISTS student_course(
    #     id serial PRIMARY KEY,
    #     student_id integer REFERENCES student(id),
    #     course_id integer REFERENCES course(id))
    #     """)
    # returning_id = add_course('Программированиие на java script')
    # print(returning_id)
    # with conn.cursor() as cur:
    #     cur.execute('INSERT INTO student_course (course_id, student_id) VALUES (2, 1)')
    # with conn.cursor() as cur:
    #     cur.execute('SELECT student.id, student.name, student_course.course_id FROM student JOIN student_course on'
    #                 ' student_id = student_course.student_id')
    #     print(cur.fetchall())
    with conn.cursor() as cur:
        cur.execute('SELECT student.id, student.name, course.name FROM student JOIN student_course ON '
                    'student_id = student_course.student_id JOIN course ON course.id = student_course.course_id')
        for item in cur.fetchall():
            print(item)

