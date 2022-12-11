from functools import reduce

PART_1 = False
debug = False

monkies = []

def reduce_worry():
    # Got to find this solution from reddit, no thinking power left after R
    # Source: https://github.com/Dullstar/Advent_Of_Code/blob/fa063a3692e5806ba4ff17cf23a62ede4ca10955/python/year2022/day11.py#L77
    return reduce(lambda x, y: x * y, [i for i in map(lambda n: n.test, monkies)])


class Item:
    def __init__(self, worry_level):
        self.worry_level: int = worry_level

    def update_worry_level(self, worry):
        self.worry_level = worry // 3 if PART_1 else worry % reduce_worry()
        if debug: print(f"Monkey gets bored with item. Worry level is divided by 3 to {self.worry_level}.")

    def get_worry(self):
        return self.worry_level


class Monkey:
    def __init__(self, id: int, items: list, multiply, increase: int, test: int, on_true: int, on_false: int):
        self.id = id
        self.items = items or []
        self.multiply = multiply or 1
        self.increase = increase or 0
        self.test = test
        self.on_true = on_true
        self.on_false = on_false

        self.monkey_business = 0
        self.item = None

    def get_id(self):
        return self.id

    def inspect(self):
        self.monkey_business += 1
        self.item = self.items.pop(0)
        worry_level = int(self.item.worry_level)
        if debug: print(f"\nMonkey inspects an item with a worry level of {worry_level}.")
        worry_level *= int(self.multiply) if str(self.multiply).isdigit() else worry_level
        if debug: print(
            f"Worry level is multiplied by {self.multiply if str(self.multiply).isdigit() else 'itself'} to {worry_level}.")
        worry_level += int(self.increase)
        if debug: print(f"Worry level increases by {self.increase} to {worry_level}.")
        self.item.update_worry_level(worry_level)

    def test_item(self):
        if self.item.worry_level % self.test == 0:
            if debug: print(f"Current worry level is divisible by {self.test}.")
            target: Monkey = monkies[self.on_true]
        else:
            target: Monkey = monkies[self.on_false]
            if debug: print(f"Current worry level is not divisible by {self.test}.")

        target.add_item(self.item)
        if debug: print(f"Item with worry level {self.item.worry_level} is thrown to monkey {target.get_id()}.")
        self.item = None

    def add_item(self, item):
        self.items.append(item)

    def monkey_handler(self):
        if debug: print(f"\nMonkey {self.get_id()}:")
        while len(self.items) > 0:
            self.inspect()
            self.test_item()

    def get_monkey_business(self):
        return self.monkey_business


with open("../input.txt", "r") as file:
    id = 0
    items = []
    multiply = 1
    increase = 0
    test = 0
    on_true = 0
    on_false = 0

    data = file.read().split("\n\n")

    for index, monkey in enumerate(data):
        id = monkey.split()[1][0]
        [items.append(Item(item)) for item in
         "".join(monkey.split("Starting items: ")[1].split("\n  Operation")[0]).split(", ")]
        # print([item.worry_level for item in items])
        if monkey.split("Operation: new = old ")[1][0] == "+":
            increase = monkey.split("Operation: new = old + ")[1].split("\n")[0]
            multiply = 1
        else:
            multiply = monkey.split("Operation: new = old * ")[1].split("\n")[0]
            increase = 0
        test = monkey.split("Test: divisible by ")[1].split("\n")[0]
        on_true = monkey.split("If true: throw to monkey ")[1].split("\n")[0]
        on_false = monkey.split("If false: throw to monkey ")[1].split("\n")[0]
        monkies.append(Monkey(id=int(id), items=items, multiply=multiply, increase=increase, test=int(test),
                              on_true=int(on_true), on_false=int(on_false)))
        if debug: print(f"Generated Monkey: id {id}, items {[item.get_worry() for item in items]}")
        items = []
    n = 20 if PART_1 else 10000
    for rnd in range(0, n):
        for monkey in monkies:
            monkey.monkey_handler()

    monkey_business = []
    for monkey in monkies:
        monkey_business.append(monkey.get_monkey_business())
        if debug:
            print(f"{[item.get_worry() for item in monkey.items]}")
            print(f"monkey business {monkey.get_id()} {monkey.get_monkey_business()}")
    monkey_business.sort(reverse=True)

    print(f"Part Part {'I' if PART_1 else 'II'} {monkey_business[0] * monkey_business[1]}")

