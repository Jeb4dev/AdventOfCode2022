---
title: Day 2 - Advent of Code 2022
date: 02/12/2022
author: Jeb
h1: Advent of Code 2022 - Day 2
href: https://adventofcode.com/2022/day/2

HeaderLink:

- {text: Previous day, link: /day_01.html}
- {text: Next day, link: /day_03.html}

FooterLink:

- {text: Previous day, link: /day_01.html}
- {text: Next day, link: /day_03.html}

---

## Challenge

### --- Day 2: Rock Paper Scissors ---

The Elves begin to set up camp on the beach. To decide whose tent gets to be closest to the snack storage, a giant Rock
Paper Scissors tournament is already in progress.

Rock Paper Scissors is a game between two players. Each game contains many rounds; in each round, the players each
simultaneously choose one of Rock, Paper, or Scissors using a hand shape. Then, a winner for that round is selected:
Rock defeats Scissors, Scissors defeats Paper, and Paper defeats Rock. If both players choose the same shape, the round
instead ends in a draw.

Appreciative of your help [yesterday](day_01.md), one Elf gives you an <b>encrypted strategy guide</b> (your puzzle
input) that they
say
will be sure to help you win. "The first column is what your opponent is going to play: `A` for Rock, `B` for Paper,
and `C`
for Scissors. The second column--" Suddenly, the Elf is called away to help with someone's tent.

The second column, you reason, must be what you should play in response: `X` for Rock, `Y` for Paper, and `Z` for
Scissors.
Winning every time would be suspicious, so the responses must have been carefully chosen.

The winner of the whole tournament is the player with the highest score. Your <b>total score</b> is the sum of your
scores for
each round. The score for a single round is the score for the <b>shape you selected</b> (1 for Rock, 2 for Paper, and 3
for
Scissors) plus the score for the <b>outcome of the round</b> (0 if you lost, 3 if the round was a draw, and 6 if you
won).

Since you can't be sure if the Elf is trying to help you or trick you, you should calculate the score you would get if
you were to follow the strategy guide.

For example, suppose you were given the following strategy guide:

````
A Y
B X
C Z
````

This strategy guide predicts and recommends the following:

- In the first round, your opponent will choose Rock (`A`), and you should choose Paper (`Y`). This ends in a win for
  you
  with a score of <b>8</b> (2 because you chose Paper + 6 because you won).
- In the second round, your opponent will choose Paper (`B`), and you should choose Rock (`X`). This ends in a loss for
  you
  with a score of 1 (1 + 0).
- The third round is a draw with both players choosing Scissors, giving you a score of 3 + 3 = <b>6</b>.

In this example, if you were to follow the strategy guide, you would get a total score of <b>`15`</b> (8 + 1 + 6).

<b>What would your total score be if everything goes exactly according to your strategy guide?</b>

#### Your puzzle answer was 13809.

### --- Part Two ---

The Elf finishes helping with the tent and sneaks back over to you. "Anyway, the second column says how the round needs
to end: X means you need to lose, `Y` means you need to end the round in a draw, and Z means you need to win. Good luck!"

The total score is still calculated in the same way, but now you need to figure out what shape to choose so the round
ends as indicated. The example above now goes like this:

- In the first round, your opponent will choose Rock (`A`), and you need the round to end in a draw (`Y`), so you also
  choose Rock. This gives you a score of 1 + 3 = <b>4</b>.
- In the second round, your opponent will choose Paper (`B`), and you choose Rock, so you lose (`X`) with a 
  score of 1 + 0 = 1.
- In the third round, you will defeat your opponent's Scissors with Rock for a score of 1 + 6 = <b>7</b>.

Now that you're correctly decrypting the ultra top secret strategy guide, you would get a total score of <b>`12`</b>.

Following the Elf's instructions for the second column, <b>what would your total score be if everything goes exactly
according to your strategy guide</b>?

#### Your puzzle answer was 12316.

---

## Solution

````python
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

````

