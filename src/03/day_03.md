---
title: Day 3 - Advent of Code 2022
date: 03/12/2022
author: Jeb
h1: Advent of Code 2022 - Day 3
href: https://adventofcode.com/2022/day/3

HeaderLink:

- {text: Previous day, link: /day_02.html}
- {text: Next day, link: /day_04.html}

FooterLink:

- {text: Previous day, link: /day_02.html}
- {text: Next day, link: /day_04.html}

---

## Challenge

### --- Day 3: Rucksack Reorganization ---

One Elf has the important job of loading all the rucksacks with supplies for the jungle journey. Unfortunately, that
Elf didn't quite follow the packing instructions, and so a few items now need to be rearranged.

Each rucksack has two large **compartments**. All items of a given type are meant to go into exactly one of the two
compartments. The Elf that did the packing failed to follow this rule for exactly one item type per rucksack.

The Elves have made a list of all the items currently in each rucksack (your puzzle input), but they need your help
finding the errors. Every item type is identified by a single lowercase or uppercase letter (that is, a and A refer to
different types of items).

The list of items for each rucksack is given as characters all on a single line. A given rucksack always has the same
number of items in each of its two compartments, so the first half of the characters represent items in the first
compartment, while the second half of the characters represent items in the second compartment.

For example, suppose you have the following list of contents from six rucksacks:

```
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
```

- The first rucksack contains the items `vJrwpWtwJgWrhcsFMMfFFhFp`, which means its first compartment contains the
  items `vJrwpWtwJgWr`, while the second compartment contains the items hcsFMMfFFhFp. The only item type that appears in
  both compartments is lowercase p.
- The second rucksack's compartments contain `jqHRNqRjqzjGDLGL` and `rsFMfFZSrLrFZsSL`. The only item type that appears
  in both compartments is uppercase **L**.
- The third rucksack's compartments contain `PmmdzqPrV` and vPwwTWBwg; the only common item type is uppercase **P**.
- The fourth rucksack's compartments only share item type **v**.
- The fifth rucksack's compartments only share item type **t**.
- The sixth rucksack's compartments only share item type **s**.

To help prioritize item rearrangement, every item type can be converted to a **priority**:

- Lowercase item types a through z have priorities 1 through 26.
- Uppercase item types A through Z have priorities 27 through 52

In the above example, the priority of the item type that appears in both compartments of each rucksack is 16 (`p`),
38 (`L`), 42 (`P`), 22 (`v`), 20 (`t`), and 19 (`s`); the sum of these is **157**.

Find the item type that appears in both compartments of each rucksack. **What is the sum of the priorities of those item
types?**

#### Your puzzle answer was 7428.

### --- Part Two ---

As you finish identifying the misplaced items, the Elves come to you with another issue.

For safety, the Elves are divided into groups of three. Every Elf carries a badge that identifies their group. For
efficiency, within each group of three Elves, the badge is the **only item type carried by all three Elves**. That is,
if a
group's badge is item type B, then all three Elves will have item type `B` somewhere in their rucksack, and at most two
of
the Elves will be carrying any other item type.

The problem is that someone forgot to put this year's updated authenticity sticker on the badges. All the badges need
to be pulled out of the rucksacks so the new authenticity stickers can be attached.

Additionally, nobody wrote down which item type corresponds to each group's badges. The only way to tell which item type
is the right one is by finding the one item type that is **common between all three Elves** in each group.

Every set of three lines in your list corresponds to a single group, but each group can have a different badge item
type. So, in the above example, the first group's rucksacks are the first three lines:

```
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
```

And the second group's rucksacks are the next three lines:,

```
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
```

In the first group, the only item type that appears in all three rucksacks is lowercase `r`; this must be their badges.
In
the second group, their badge item type must be `Z`.

Priorities for these items must still be found to organize the sticker attachment efforts: here, they are 18 (`r`) for
the
first group and 52 (`Z`) for the second group. The sum of these is **70**.

Find the item type that corresponds to the badges of each three-Elf group. **What is the sum of the priorities of those
item types?**

#### Your puzzle answer was 2650.

---

## Solution
This solution is written in `golang`
````go
// Solution for Advent of Code 2022 day 3.
package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func getCommonCharacters(str1 string, str2 string) []string {
	var commons []string // List of common characters

	map1 := map[string]int{} // Initialize empty dictionary

	// Fill dict with characters of str1
	for i := 0; i < len(str1); i++ {
		map1[string(str1[i])] += 1
	}

	for i := 0; i < len(str2); i++ {
		_, ok := map1[string(str2[i])]

		if ok { // if key was found
			common := string(str2[i])         // common is the string in current index
			commons = append(commons, common) // add it into the list of common characters
		}
	}

	return commons
}

func main() {

	priorities := map[string]int{"a": 1, "b": 2, "c": 3, "d": 4, "e": 5, "f": 6, "g": 7, "h": 8, "i": 9, "j": 10,
		"k": 11, "l": 12, "m": 13, "n": 14, "o": 15, "p": 16, "q": 17, "r": 18, "s": 19, "t": 20, "u": 21, "v": 22,
		"w": 23, "x": 24, "y": 25, "z": 26, "A": 27, "B": 28, "C": 29, "D": 30, "E": 31, "F": 32, "G": 33, "H": 34,
		"I": 35, "J": 36, "K": 37, "L": 38, "M": 39, "N": 40, "O": 41, "P": 42, "Q": 43, "R": 44, "S": 45, "T": 46,
		"U": 47, "V": 48, "W": 49, "X": 50, "Y": 51, "Z": 52} // This is kinda stupid to hardcode but...

	totalPriorityPart1 := 0
	totalPriorityPart2 := 0

	rowGroup := map[string]string{"row1": "", "row2": ""} // storage for contents of previous rows

	f, _ := os.Open("input.txt") // Read file

	scanner := bufio.NewScanner(f)

	for scanner.Scan() { // loop input file row by row

		txt := scanner.Text() // txt of row

		middle := len(txt) / 2 // Middle index

		// Split string into two from the middle
		compartment1 := txt[:middle]
		compartment2 := txt[middle:]

		commons := getCommonCharacters(compartment1, compartment2)

		totalPriorityPart1 += priorities[commons[0]]

		// Part 2
		if rowGroup["row1"] == "" {
			rowGroup["row1"] = txt
		} else if rowGroup["row2"] == "" {
			rowGroup["row1"] = txt
		} else {
			lstCommons := getCommonCharacters(rowGroup["row1"], rowGroup["row2"]) // List of commons in row 1 and 2

			strCommons := strings.Join(lstCommons, "") // Convert list to string

			lstCommons = getCommonCharacters(strCommons, txt) // List of commons in row 3 and commons of row 1 and 2

			totalPriorityPart2 += priorities[lstCommons[0]] // Increment total amount of priority

			rowGroup["row1"], rowGroup["row2"] = "", "" // Empty row group storage
		}
	}

	fmt.Printf("Total Priority is %d \n", totalPriorityPart1)
	fmt.Printf("Total Priority of part 2 is %d", totalPriorityPart2)

}
````

