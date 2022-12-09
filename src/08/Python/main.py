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
