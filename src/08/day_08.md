---
title: Day 8 - Advent of Code 2022
date: 08/12/2022
author: Jeb
h1: Advent of Code 2022 - Day 8
href: https://adventofcode.com/2022/day/6

HeaderLink:

- {text: Previous day, link: /day_07.html}
- {text: Next day, link: /day_09.html}

FooterLink:

- {text: Previous day, link: /day_07.html}
- {text: Next day, link: /day_09.html}

---

## Challenge

### --- Day 8: Treetop Tree House ---

The expedition comes across a peculiar patch of tall trees all planted carefully in a grid. The Elves explain that a
previous expedition planted these trees as a reforestation effort. Now, they're curious if this would be a good location
for a **tree house**.

First, determine whether there is enough tree cover here to keep a tree house **hidden**. To do this, you need to count
the number of trees that are **visible from outside the grid** when looking directly along a row or column.

The Elves have already launched a **quadcopter** to generate a map with the height of each tree (your puzzle input). For
example:

````
30373
25512
65332
33549
35390
````

Each tree is represented as a single digit whose value is its height, where 0 is the shortest and 9 is the tallest.

A tree is **visible** if all the other trees between it and an edge of the grid are **shorter** than it. Only consider
trees
in the same row or column; that is, only look up, down, left, or right from any given tree.

All the trees around the edge of the grid are visible - since they are already on the edge, there are no trees to
block the view. In this example, that only leaves the **interior nine trees** to consider:

- The top-left `5` is **visible** from the left and top. (It isn't visible from the right or bottom since other trees of
  height `5` are in the way.)
- The top-middle `5` is **visible** from the top and right.
- The top-right `1` is not visible from any direction; for it to be visible, there would need to only be trees of height
  **0** between it and an edge.
- The left-middle `5` is **visible**, but only from the right.
- The center `3` is not visible from any direction; for it to be visible, there would need to be only trees of at most
  height `2` between it and an edge.
- The right-middle `3` is **visible** from the right.
- In the bottom row, the middle `5` is **visible**, but the `3` and `4` are not.

With 16 trees visible on the edge and another 5 visible in the interior, a total of **21** trees are visible in this
arrangement.

Consider your map; how many trees are visible from outside the grid?

#### Your puzzle answer was 1859.

### --- Part Two ---

Content with the amount of tree cover available, the Elves just need to know the best spot to build their tree house:
they would like to be able to see a lot of **trees**.

To measure the viewing distance from a given tree, look up, down, left, and right from that tree; stop if you reach an
edge or at the first tree that is the same height or taller than the tree under consideration. (If a tree is right on
the edge, at least one of its viewing distances will be zero.)

The Elves don't care about distant trees taller than those found by the rules above; the proposed tree house has large *
*eaves** to keep it dry, so they wouldn't be able to see higher than the tree house anyway.

In the example above, consider the middle `5` in the second row:

````
30373
25512 <- mid 5
65332
33549
35390
````

- Looking up, its view is not blocked; it can see `1` tree (of height `3`).
- Looking left, its view is blocked immediately; it can see only `1` tree (of height `5`, right next to it).
- Looking right, its view is not blocked; it can see `2` trees.
- Looking down, its view is blocked eventually; it can see `2` trees (one of height `3`, then the tree of height `5`
  that blocks its view).

A tree's **scenic score** is found by **multiplying together** its viewing distance in each of the four directions. For
this tree, this is `4` (found by multiplying `1 * 1 * 2 * 2`).

However, you can do even better: consider the tree of height `5` in the middle of the fourth row:

```
30373
25512
65332
33549 <- mid 5
35390
```

- Looking up, its view is blocked at `2` trees (by another tree with a height of `5`).
- Looking left, its view is not blocked; it can see `2` trees.
- Looking down, its view is also not blocked; it can see `1` tree.
- Looking right, its view is blocked at `2` trees (by a massive tree of height `9`).

This tree's scenic score is **`8`** (`2 * 2 * 1 * 2`); this is the ideal spot for the tree house.

Consider each tree on your map. **What is the highest scenic score possible for any tree**?

#### Your puzzle answer was 332640.

---

## Solution

This solution is written in `python`.

````python
# Solution for Advent of Code 2022 day 8.
def get_columns_highest(_rows, _column):
    """
    Searches the height of the highest tree in given list of rows at given column
    :param _rows: range of rows of interest
    :type _rows: range
    :param _column: column of interest
    :type _column: int
    :return: Height of the highest tree in given range
    :rtype: int
    """
    highest = 0
    for _row in _rows:
        _tree = int(lines[_row][_column])
        if _tree > highest:
            highest = _tree
    return highest

def get_rows_highest(_row, _columns):
    """
    Searches the height of the highest tree in given list of columns at given row
    :param _row: row of interest
    :type _row: int
    :param _columns: range of columns of interest
    :type _columns: range
    :return: Height of the highest tree in given range
    :rtype: int
    """
    highest = 0
    for _column in _columns:
        _tree = int(lines[_row][_column])
        if _tree > highest:
            highest = _tree
    return highest

def viewing_distance_column(_rows, _column, max_height):
    """
    Calculates the view distance from tree.
    <p>e.g. How many trees in given direction of column are smaller than max_height.</p>
    :param _rows: range of rows of interest
    :type _rows: range
    :param _column: column of interest
    :type _column: int
    :param max_height: The height of current tree
    :type max_height: int
    :return: View distance for given direction
    :rtype: int
    """
    _viewing_distance = 0
    for _row in _rows:
        _viewing_distance += 1
        _tree = int(lines[_row][_column])
        if _tree >= max_height:
            return _viewing_distance
    return _viewing_distance

def viewing_distance_row(_row, _columns, max_height):
    """
    Calculates the view distance from tree.
    <p>e.g. How many trees in given direction of column are smaller than max_height.</p>
    :param _row: row of interest
    :type _row: int
    :param _columns: range of columns of interest
    :type _columns: range
    :param max_height: The height of current tree
    :type max_height: int
    :return: View distance for given direction
    :rtype: int
    """
    _viewing_distance = 0
    for _column in _columns:
        _viewing_distance+=1
        _tree = int(lines[_row][_column])
        if _tree >= max_height:
            return _viewing_distance
    return _viewing_distance


lines = []
top_viewing_distance = 0

# Read input file
with open("../input.txt", "r") as data:

    # Add each row to list of rows
    for row in data.readlines():
        lines.append(row)

    # Amount of columns and rows
    columns = len(lines[0])-1
    rows = len(lines)

    visible = columns * 2 # Top and Bottom rows

    # Loop through each tree that is not at the edge
    for row in range(1, rows - 1):
        visible += 2  # Both Sides
        for column in range(1, columns - 1):

            tree = int(lines[row][column]) # Current tree height

            # Get the highest tree in each direction
            top_up = get_columns_highest(range(0,row), column)
            top_btn = get_columns_highest(range(row+1, rows), column)
            top_left = get_rows_highest(row, range(0, column))
            top_right = get_rows_highest(row, range(column+1, columns))

            # If three height is lower that highest tree in any direction it is visible
            if tree > top_up or tree > top_btn or tree > top_left or tree > top_right:
                visible += 1


            # Part II

            # Get viewing distances for each direction
            wd_up = viewing_distance_column(range(row-1, -1, -1), column, tree)
            wd_btn = viewing_distance_column(range(row + 1, rows), column, tree)
            wd_left = viewing_distance_row(row, range(column-1, -1, -1), tree)
            wd_right = viewing_distance_row(row, range(column + 1, columns), tree)

            # Calculate viewing distance
            viewing_distance = wd_up * wd_btn * wd_right *wd_left

            # Update if new highest
            if viewing_distance > top_viewing_distance:
                top_viewing_distance = viewing_distance

    # Printing the results
    print(f"Part I {visible}")
    print(f"Part II {top_viewing_distance}")

````

