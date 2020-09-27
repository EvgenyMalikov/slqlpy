from random import choice


def generate_couple_set(first_list: list, second_list: list, number_: int) -> set:
    return {(choice(first_list), choice(second_list)) for _ in range(number_)}

