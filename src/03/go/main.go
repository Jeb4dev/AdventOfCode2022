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
