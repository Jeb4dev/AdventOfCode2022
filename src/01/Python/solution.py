from requests import request

URL = "https://adventofcode.com/2022/day/1/input"


response = request("GET", URL, cookies={"session": "YOUR_SESSION_COOKIE"})  # Get the input data from website

data = response.text

lines = data.split("\n")  # Split data into list of lines

top_calories = ["ignored", 0, 0, 0]  # Just to make it more beginner friendly let's ignore index 0
current_calories = 0

for line in lines:
    if line.isnumeric():
        current_calories += int(line)
    else:
        if current_calories > top_calories[1]:  # If current elf is carrying more than current top carrier

            # Update max calories
            top_calories[3] = top_calories[2]
            top_calories[2] = top_calories[1]
            top_calories[1] = current_calories

        elif current_calories > top_calories[2]:
            top_calories[3] = top_calories[2]
            top_calories[2] = current_calories

        elif current_calories > top_calories[3]:
            top_calories[3] = current_calories

        current_calories = 0  # Reset current calories

print(f"Maximum Total Calories one Elf is Carrying is {top_calories[1]}")
print(f"Top 3 Elves are carrying { top_calories[1] + top_calories[2] + top_calories[3] }")

