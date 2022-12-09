---
title: Day 6 - Advent of Code 2022
date: 06/12/2022
author: Jeb
h1: Advent of Code 2022 - Day 6
href: https://adventofcode.com/2022/day/6

HeaderLink:

- {text: Previous day, link: /day_05.html}
- {text: Next day, link: /day_07.html}

FooterLink:

- {text: Previous day, link: /day_05.html}
- {text: Next day, link: /day_07.html}

---

## Challenge

### --- Day 5: Tuning Trouble ---

The preparations are finally complete; you and the Elves leave camp on foot and begin to make your way toward the
<span style="color:#ffff66;">star</span> fruit grove.

As you move through the dense undergrowth, one of the Elves gives you a handheld **device**. He says that it has
many fancy features, but the most important one to set up right now is the **communication system**.

However, because he's heard you have **significant experience dealing with signal-based systems**, he convinced the
other Elves that it would be okay to give you their one malfunctioning device - surely you'll have no problem fixing it.

As if inspired by comedic timing, the device emits a few colorful sparks.

To be able to communicate with the Elves, the device needs to **lock on to their signal**. The signal is a series of
seemingly-random characters that the device receives one at a time.

To fix the communication system, you need to add a subroutine to the device that detects a **start-of-packet marker**
in the datastream. In the protocol being used by the Elves, the start of a packet is indicated by a sequence of
**four characters that are all different**.

The device will send your subroutine a datastream buffer (your puzzle input); your subroutine needs to identify the
first position where the four most recently received characters were all different. Specifically, it needs to report the
number of characters from the beginning of the buffer to the end of the first such four-character marker.

For example, suppose you receive the following datastream buffer:

`mjqjpqmgbljsphdztnvjfqwrcgsmlb`

After the first three characters (`mjq`) have been received, there haven't been enough characters received yet to find
the marker. The first time a marker could occur is after the fourth character is received, making the most recent four
characters `mjqj`. Because `j` is repeated, this isn't a marker.

The first time a marker appears is after the **seventh** character arrives. Once it does, the last four characters
received are `jpqm`, which are all different. In this case, your subroutine should report the value `7`, because the
first start-of-packet marker is complete after 7 characters have been processed.

Here are a few more examples:

- `bvwbjplbgvbhsrlpgdmjqwftvncz`: first marker after character **5**
- `nppdvjthqldpwncqszvftbrmjlhg`: first marker after character **6**
- `nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg`: first marker after character **10**
- `zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw`: first marker after character **11**

**How many characters need to be processed before the first start-of-packet marker is detected?**

#### Your puzzle answer was 1912.

### --- Part Two ---

#### Your puzzle answer was 2122.

Your device's communication system is correctly detecting packets, but still isn't working. It looks like it also needs
to look for **messages**.

A **start-of-message marker** is just like a start-of-packet marker, except it consists of **14 distinct characters**
rather than 4.

Here are the first positions of start-of-message markers for all of the above examples:

- `mjqjpqmgbljsphdztnvjfqwrcgsmlb`: first marker after character **19**
- `bvwbjplbgvbhsrlpgdmjqwftvncz`: first marker after character **23**
- `nppdvjthqldpwncqszvftbrmjlhg`: first marker after character **23**
- `nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg`: first marker after character **29**
- `zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw`: first marker after character **26**

**How many characters need to be processed before the first start-of-message marker is detected?**

---

## Solution

This solution is written in `C`.

````C
// Solution for Advent of Code 2022 day 6.
#include <stdio.h>
#include <string.h>

// Checks for duplicates in array
int duplicate(const char *history, int size) {
    int i;
    int j;
    for (i = 0; i < size; i++) {
        if (!history[0]) return 0;
        for (j = 0; j < size; j++) {
            if (history[i] == history[j] && i != j) {
                return 0;
            }
        }
    }
    printf("%s was the right signal at index: ", history);
    return 1;
}

// Update array, move each element one to "left", add new ch element to last index
void update(char *history, char ch, int size) {
    int i;
    for (i = 0; i < size; i++) {
        history[i] = history[i+1];
    }
    history[size-1] = ch;
}

int main() {
    int size;
    size = 4; // Change size to 14 for part 2
    FILE *ptr;
    int index;
    char ch;
    char history[size];

    // Opening file in reading mode
    ptr = fopen("path_to/input.txt", "r");

    if (NULL == ptr) {
        printf("file can't be opened \n");
    }

    index = 0;

    // Printing what is written in file
    // character by character using loop.
    do {
        ch = fgetc(ptr);


        if (duplicate(history, size)) {
            printf("%d \n", index);
            return 0;
        }

        update(history, ch, size);
        index += 1;

        // Checking if character is not EOF.
        // If it is EOF stop eading.
    } while (ch != EOF);

    // Closing the file
    fclose(ptr);
    return 0;
}
````

I also tried to code it in `Assembly` but didn't find the solution. At least I learned bits of asm syntax and 
understand it better.

````asm
; Non working solution for Advent of Code 2022 day 6.
; All it does is read the input file and print the content of it.

;Compiling and running
;nasm -f elf64 -g -F DWARF main.asm
;ld -e start -o main main.o
;./main

SYS_READ    equ 0
O_RDONLY    equ 0
SYS_OPEN    equ 2
SYS_CLOSE   equ 3
STDOUT      equ 1

section .data
    filename db "input.txt", 0

section .bss
    text resb 4096

section .text
    global _start

_start:
    ; open file
    mov rax, SYS_OPEN
    mov rdi, filename
    mov rsi, O_RDONLY
    mov rdx, 0
    syscall

    ; read file
    push rax
    mov rdi, rax
    mov rax, SYS_READ
    mov rsi, text
    mov rdx, 4096 ; file is 4096 char long
    syscall

    ; close file
    mov rax, SYS_CLOSE
    pop rdi
    syscall

    ; print text
    mov rax, 4
    mov rbx, STDOUT
    mov rcx, text
    int 0x80

    int 1
````

