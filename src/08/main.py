with open("input.txt", "r") as data:
    lines = []
    for row in data.readlines():
        lines.append(row)

    l = len(lines)

    visible = l*2

    for number, row in enumerate(lines[1:l-1]):
        visible += 2  # Sides
        for i in range(1, l-1):
            up = lines[number][i]
            down = lines[number+2][i]
            left = lines[number+1][i - 1]
            right = lines[number+1][i + 1]
            c = lines[number+1][i]
            print(f"{up} {down} {left} {right} : {c}")
            if c > up and c > down and c > left and c > right:
                visible += 1
                print("+1")

data.close()
print(visible)
