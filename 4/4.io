file := File clone openForReading("4.txt")
input := file readLines

turns := input first split(",") map(asNumber)

Board := Object clone
Board init := method(
    lines ::= list()
)
Board appendLine := method(line,
    lines append(line)
)
Board println := method(
    lines foreach(line, line map(number) println)
    "" println
)
Board markNumber := method(markedNumber,
    lines foreach(line,
        line foreach(numObj,
            if(numObj number == markedNumber, numObj marked = true)
        )
    )
)
Board won := method(
    anyLine := lines detect(map(marked) reduce(and))

    if(anyLine, return true)

    for(i, 0, lines first size - 1,
        column := lines map(at(i))
        anyRow := column map(marked) reduce(and)

        if(anyRow, return true)
    )
)

boards := list()
index := -1
input rest foreach(line,
    if(line == "") then(
        boards append(Board clone)
        index = index + 1
    ) else(
        currentBoard := boards at(index)

        currentBoard appendLine(line split select(!= "") map(elem,
            obj := Object clone do(marked := false)
            obj number := elem asNumber

            obj
        ))
    )
)

scores := list()
turns foreach(num,
    boards foreach(markNumber(num))

    wonBoards := boards select(won)
    wonBoards foreach(wonBoard,
        boards remove(wonBoard)

        unmarkedScore := wonBoard lines flatten select(marked not) map(number) reduce(+, 0)

        scores append(num * unmarkedScore)
    )
)


(scores first) println
(scores last)  println