---
title: Day 5 - Advent of Code 2022
date: 05/12/2022
author: Jeb
h1: Advent of Code 2022 - Day 5
href: https://adventofcode.com/2022/day/5

HeaderLink:

- {text: Previous day, link: /day_04.html}
- {text: Next day, link: /day_06.html}

FooterLink:

- {text: Previous day, link: /day_04.html}
- {text: Next day, link: /day_06.html}

---

## Challenge

### --- Day 5: Supply Stacks ---

The expedition can depart as soon as the final supplies have been unloaded from the ships. Supplies are stored in stacks
of marked **crates**, but because the needed supplies are buried under many other crates, the crates need to be
rearranged.

The ship has a **giant cargo crane** capable of moving crates between stacks. To ensure none of the crates get crushed
or fall over, the crane operator will rearrange them in a series of carefully-planned steps. After the crates are
rearranged, the desired crates will be at the top of each stack.

The Elves don't want to interrupt the crane operator during this delicate procedure, but they forgot to ask her
**which** crate will end up where, and they want to be ready to unload them as soon as possible, so they can embark.

They do, however, have a drawing of the starting stacks of crates **and** the rearrangement procedure
(your puzzle input). or example:

```
    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
```

In this example, there are three stacks of crates. Stack 1 contains two crates: crate `Z` is on the bottom, and crate
`N` is on top. Stack 2 contains three crates; from bottom to top, they are crates `M`, `C`, and `D`. Finally, stack 3
contains a single crate, `P`.

Then, the rearrangement procedure is given. In each step of the procedure, a quantity of crates is moved from one stack
to a different stack. In the first step of the above rearrangement procedure, one crate is moved from stack 2 to stack
1, resulting in this configuration:

```
[D]        
[N] [C]    
[Z] [M] [P]
 1   2   3
```

In the second step, three crates are moved from stack 1 to stack 3. Crates are moved **one at a time**, so the first
crate to be moved (D) ends up below the second and third crates:

```
        [Z]
        [N]
    [C] [D]
    [M] [P]
 1   2   3
```

Then, both crates are moved from stack 2 to stack 1. Again, because crates are moved **one at a
time**, crate `C` ends up below crate `M`:

```
        [Z]
        [N]
[M]     [D]
[C]     [P]
 1   2   3
```

Finally, one crate is moved from stack 1 to stack 2:

```
        [Z]
        [N]
        [D]
[C] [M] [P]
 1   2   3
```

The Elves just need to know **which crate will end up on top of each stack**; in this example, 
the top crates are `C` in stack 1, M in stack 2, and `Z` in stack 3, so you should combine these 
together and give the Elves the message **`CMZ`**.

**After the rearrangement procedure completes, what crate ends up on top of each stack?**

#### Your puzzle answer was TGWSMRBPN.

### --- Part Two ---

As you watch the crane operator expertly rearrange the crates, you notice the process isn't following your prediction.

Some mud was covering the writing on the side of the crane, and you quickly wipe it away. The crane isn't a CrateMover 
9000 - it's a **CrateMover 9001**.

The CrateMover 9001 is notable for many new and exciting features: air conditioning, leather seats, an extra cup holder,
and the ability to **pick up and move multiple crates at once**.

Again considering the example above, the crates begin in the same configuration:

`    
    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3
` 

Moving a single crate from stack 2 to stack 1 behaves the same as before:

`
[D]        
[N] [C]    
[Z] [M] [P]
 1   2   3
` 

However, the action of moving three crates from stack 1 to stack 3 means that those three moved crates 
**stay in the same order**, resulting in this new configuration:

`        
        [D]
        [N]
    [C] [Z]
    [M] [P]
 1   2   3
`

Next, as both crates are moved from stack 2 to stack 1, they **retain their order** as well:

`        
        [D]
        [N]
[C]     [Z]
[M]     [P]
 1   2   3
`

Finally, a single crate is still moved from stack 1 to stack 2, but now it's crate C that gets moved:

`        
        [D]
        [N]
        [Z]
[M] [C] [P]
 1   2   3
`

In this example, the **CrateMover 9001** has put the crates in a totally different order: **`MCD`**.

Before the rearrangement process finishes, update your simulation so that the Elves know where they should stand to be 
ready to unload the final supplies. 
**After the rearrangement procedure completes, what crate ends up on top of each stack?**


#### Your puzzle answer was TZLTLWRNF.

---

## Solution

This solution is written in `visual basic`

````visualbasic
' Solution for Advent of Code 2022 day 5.
' I did not really like visual basic, this code is not beautiful, so go easy on me
Imports System.IO
Imports Microsoft.VisualBasic.FileIO

Module Program
    Sub Main(args As String())
        Dim reader as StreamReader = FileSystem.OpenTextFileReader("../../../input.txt")
        Dim row as String

        ' Use stack data structure for saving stack information
        Dim stacks = New ArrayList(10)
        Dim helpStacks = New ArrayList(10)
        For i = 0 To 9
            stacks.Add(New Stack)
            helpStacks.Add(New Stack)
        Next

        Dim initialized = False

        Do
            ' Read line
            row = reader.ReadLine()
            
            If Not initialized Then
                ' not initialized
                Dim index As Int16 = 0
                Dim stackNumber = 0
                For Each ch As Char in row
                    if (index - 1) Mod 4 = 0 Then
                        if Char.IsDigit(ch) Then
                            initialized = True
                            
                            ' Add help stacks to stacks
                            For i = 0 To stacks.Count-1
                                Dim helpStack As Stack = helpStacks.Item(i)
                                Dim stack As Stack = stacks.Item(i)
                                While helpStack.Count > 0
                                    stack.Push(helpStack.Peek())
                                    helpStack.Pop()
                                End While
                                stacks.Item(i) = stack
                                helpStacks.Item(i) = helpStacks
                            Next
                            
                            ' Print Stack structure
                            
                            ' For i = 0 To 9
                            '     Dim stack As Stack = stacks.Item(i)
                            '     While stack.Count > 0
                            '         Console.Write(stack.Pop())
                            '     End While
                            '     Console.WriteLine()
                            ' Next
                            
                            Exit For
                        End If
                        stackNumber += 1
                        if not ch = " " Then
                            Dim stack As Stack = helpStacks.Item(stackNumber)
                            stack.Push(ch)
                            helpStacks.Item(stackNumber) = stack
                        End If
                    End If
                    index += 1
                Next
            Else If not String.IsNullOrEmpty(row) Then
                ' Read Instructions
                row = row.Replace("move ", "")
                row = row.Replace(" from ", " ")
                row = row.Replace(" to ", " ")
                row = row.Replace("\n", "")
                Dim amount = 0
                Dim src = 0
                Dim dst = 0
                
                ' Put Instructions to variables
                Dim data = row.Split()
                For Each num in data
                    if not num = "" Then
                        if amount = 0 Then
                            amount = num
                        Else If src = 0 Then
                            src = num
                        Else 
                            dst = num
                        End If
                    End If
                Next
                
                ' !! Comment part 1 or 2 out to get proper answer !!
                
                ' Part 1 Beginning
                for i = 1 To amount
                    Dim srcStack = stacks.Item(src)
                    Dim dstStack = stacks.Item(dst)
                    if srcStack.Count Then
                        dstStack.Push(srcStack.Pop())
                    End If
                Next
                ' Part 1 End
                
                ' Part 2 Beginning
                Dim helpStack = new Stack
                for i = 1 To amount
                    Dim srcStack = stacks.Item(src)
                    if srcStack.Count Then
                        helpStack.Push(srcStack.Pop())
                    End If
                Next
                
                While helpStack.Count > 0
                    stacks.Item(dst).Push(helpStack.Pop())
                End While
                ' Part 2 End
                
            End If

        Loop Until row Is Nothing
        
        Console.Write("Answer: ")
        For i = 1 To stacks.Count-1
            Dim stack As Stack = stacks.Item(i)
            if stack.Count > 0 Then
                Console.Write(stack.Peek())
            End If
        Next
        
    End Sub
End Module
````

