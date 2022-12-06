package main

import (
    "fmt"
    "log"
    "os"
    "strconv"
    "strings"
)

type Move struct {
    amount int
    from   int
    to     int
}

func main() {
    input, err := os.ReadFile("input.txt")
    if err != nil {
        log.Fatalf("unable to read file: %v", err)
    }

    stackDef, moveDef, _ := strings.Cut(string(input), "\n\n")
    stackDefLines := strings.Split(stackDef, "\n")
    stackEnumeration := strings.Fields(stackDefLines[len(stackDefLines)-1])
    stackSize, _ := strconv.Atoi(stackEnumeration[len(stackEnumeration)-1])

    moves := parseMoves(strings.Split(moveDef, "\n"))
    solutionOne := partOne(parseStacks(stackDefLines, stackSize), moves)
    solutionTwo := partTwo(parseStacks(stackDefLines, stackSize), moves)

    fmt.Println("The solution for part one is: ", solutionOne)
    fmt.Println("The solution for part two is: ", solutionTwo)
}

func parseStacks(lines []string, size int) [][]string {
    var stacks = make([][]string, size)
    for i := 0; i < len(lines)-1; i++ {
        line := lines[i]
        pos := 0
        for j := 1; j < len(line); j += 4 {
            char := string(line[j])
            if char != " " {
                stacks[pos] = append([]string{char}, stacks[pos]...)
            }
            pos++
        }
    }
    return stacks
}

func parseMoves(lines []string) []Move {
    var moves []Move
    for _, line := range lines {
        parts := strings.Fields(
            strings.ReplaceAll(
                strings.ReplaceAll(
                    strings.ReplaceAll(line, "move ", ""),
                    "from ", ""),
                "to ", ""))
        amount, _ := strconv.Atoi(parts[0])
        from, _ := strconv.Atoi(parts[1])
        to, _ := strconv.Atoi(parts[2])
        moves = append(moves, Move{amount, from - 1, to - 1})
    }
    return moves
}

func partOne(stacks [][]string, moves []Move) string {
    for _, move := range moves {
        srcLen := len(stacks[move.from])
        toMove := make([]string, move.amount)
        copy(toMove, stacks[move.from][srcLen-move.amount:])
        for i := len(toMove) - 1; i >= 0; i-- {
            stacks[move.to] = append(stacks[move.to], toMove[i])
        }
        toLeave := make([]string, srcLen-move.amount)
        copy(toLeave, stacks[move.from][:srcLen-move.amount])
        stacks[move.from] = toLeave
    }

    var solution string
    for _, stack := range stacks {
        solution += stack[len(stack)-1]
    }
    return solution
}

func partTwo(stacks [][]string, moves []Move) string {
    for _, move := range moves {
        srcLen := len(stacks[move.from])
        toMove := make([]string, move.amount)
        copy(toMove, stacks[move.from][srcLen-move.amount:])
        stacks[move.to] = append(stacks[move.to], toMove...)
        toLeave := make([]string, srcLen-move.amount)
        copy(toLeave, stacks[move.from][:srcLen-move.amount])
        stacks[move.from] = toLeave
    }

    var solution string
    for _, stack := range stacks {
        solution += stack[len(stack)-1]
    }
    return solution
}
