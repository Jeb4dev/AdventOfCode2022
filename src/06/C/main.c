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