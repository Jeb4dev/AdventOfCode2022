# Unready solution for Advent of Cyber 2022

Item <- function(id, worry_level) {
  # attributes
  self.id <- id
  self.worry_level <- worry_level
  structure(class = "Item", list(
    # methods
    get_id = function() self.id,
    get_worry_level = function() self.worry_level,
    set_worry_level = function(worry_level) self.worry_level <<- worry_level,
    divide_worry_level = function() self.worry_level <<- round(self.worry_level / 3, 0)
  ))
}

Monkey <- function(id = 0, items, multiply = 1, increase = 0, test = NULL, on_true = NULL, on_false = NULL) {
  # attributes
  self.id <- id
  self.items <- items
  self.item <- NULL
  self.multiply <- multiply
  self.increase <- increase
  self.test <- test
  self.on_true <- on_true
  self.on_false <- on_false
  print("Created new Monkey")

  structure(class = "Monkey", list(
    # methods
    get_id = function() self.id,
    get_multiply = function() returnself.multiply,

    inspect = function() {
      print(length(self.items))
      self.item <- tail(self.items, 1)
      print(length(self.items))
      item <- self.item
      print(item$get_id())
      worry_level <- item.get_worry_level
      worry_level <- worry_level + self.increase
      worry_level <- worry_level * self.multiply
      item.set_worry_level()
    },

    test_item = function() {
      if (self.item %% self.test == 0) {
        target <- get_monkey_by_id(self.on_true)
        target.add_item(self.item)
      } else {
        target <- get_monkey_by_id(self.on_false)
        target.add_item(self.item)
      }
      self.item <- NULL
    },

    add_item = function(item) {
      self.items <- append(self.items, item, 1)
    },
    get_items = function () {
      self.items
      return(length(self.items))
    }
  ))

}

get_monkey_by_id <- function(id) {
  if (id == 0) return(a)
  if (id == 1) return(b)
  if (id == 2) return(c)
  if (id == 3) return(d)
  if (id == 4) return(e)
}

items = list()

item = Item(1, 2)
item2 = Item(2, 8)

items <- append(items, item)
items <- append(items, item2)

item$get_id()
items[1]$get_id()

print(" ")

monkis = list()

monki <- Monkey(1, list())
# monki2 <- Monkey(2, list())
# monki3 <- Monkey(3, list())

monkis <- append(monkis, monki)
# monkis <- append(monkis, monki2)
# monkis <- append(monkis, monki3)

aa <- monkis[[5]](Item(66, 16))
aa <- monkis[[5]](Item(88, 112))
# monkis[[11]](Item(6, 8))
# monkis[[17]](Item(8, 32))

monkis[[6]]()
