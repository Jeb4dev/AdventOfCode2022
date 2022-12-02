"""
Solution for Advent of Code 2022 day 2.
"""


def calculate_score(_elf_choose, _my_choose):
    matrix = {
        "AX": 1+3, "BX": 1+0, "CX": 1+6,
        "AY": 2+6, "BY": 2+3, "CY": 2+0,
        "AZ": 3+0, "BZ": 3+6, "CZ": 3+3,
    }

    return matrix[_elf_choose+_my_choose]


# Part One
with open("../input.txt", "r") as file:
    # Part One
    score = 0

    for line in file.readlines():
        elf_choose = line[0]
        my_choose = line[2]

        score += calculate_score(elf_choose, my_choose)

    print(f"Answer to part one: {score}")
    file.close()

# Part Two
with open("../input.txt", "r") as file:
    score = 0

    choose_dict = {
        "A X": "Z", "B X": "X", "C X": "Y",
        "A Y": "X", "B Y": "Y", "C Y": "Z",
        "A Z": "Y", "B Z": "Z", "C Z": "X"
    }

    for line in file.readlines():
        elf_choose = line[0]
        my_choose = choose_dict[line[:-1]]  # Search right choose from dict, ignore new line character

        score += calculate_score(elf_choose, my_choose)

    print(f"Answer to part two: {score}")
    file.close()
