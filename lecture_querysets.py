from pprint import pprint
import sqlalchemy


CONNECT_ = 'postgres://mev:admin@localhost:5432/pagila'

engine = sqlalchemy.create_engine(CONNECT_)
connection = engine.connect()


def select_all_query():
    return connection.execute(
        """
        SELECT * FROM film;
        """
    ).fetchone()


def select_column_query():
    return connection.execute(
        """
        SELECT title, release_year FROM film;
        """
    ).fetchmany(5)


def select_name_surname_actors():
    return connection.execute(
        """
        SELECT first_name,last_name FROM actor;
        """
    ).fetchmany(10)


def select_rating():
    return connection.execute(
        """
        SELECT DISTINCT rating FROM film; 
        """
    ).fetchall()


def multiplication_payment():
    return connection.execute(
        """
        SELECT amount *70 FROM payment;
        """
    ).fetchmany(10)


def get_rental_time():
    return connection.execute(
        """
        SELECT rental_date - return_date FROM rental;
        """
    ).fetchmany(10)


def find_films_after():
    return connection.execute(
        """
        SELECT title, release_year FROM film
        WHERE release_year >= 2000;
        """
    ).fetchmany(5)


def find_active_staff():
    return connection.execute(
        """
        SELECT first_name, last_name, active FROM staff
        WHERE  active = True;
        """
    ).fetchall()


def find_joe():
    return connection.execute(
        """
        SELECT actor_id, first_name, last_name FROM actor
        WHERE first_name = 'JOE'
        """
    ).fetchall()


def find_who_dont_work_in_second_store():
    return connection.execute(
        """
        SELECT first_name, last_name FROM staff
        WHERE store_id != 2;
        """
    ).fetchall()


def find_active_staff_and_dont_work_in_first_store():
    return connection.execute(
        """
        SELECT first_name, last_name FROM staff
        WHERE active = true AND NOT store_id = 1;
        """
    ).fetchall()


def find_film_rental_rate_replacement_cost():
    return connection.execute(
        """
        SELECT title FROM film
        WHERE rental_rate <= 0.99 AND replacement_cost <= 9.99
        """
    ).fetchmany(10)


def find_text(text):
    return connection.execute(
        """
        SELECT actor_id, first_name, last_name FROM actor
        where   last_name LIKE %s ESCAPE ''
        """, (text,)
    ).fetchmany(10)


def sort_by_last_name_first_name():
    return connection.execute(
        """
        SELECT actor_id, first_name, last_name FROM actor
        WHERE last_name LIKE '%%LI%%'
        ORDER BY last_name, first_name
        """
    ).fetchmany(10)


if __name__ == '__main__':
    pprint(find_text('%%GEN%%'))


