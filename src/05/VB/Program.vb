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