file := File clone openForReading("3.txt")
input := file readLines

Sequence charAt := method(i,
    exSlice(i, i + 1)
)

numericList := input map(num,
    result := list()
    for(i, 0, num size - 1,
        numAt := num charAt(i) asNumber
        result append(numAt)
    )
    result
)
numLen := numericList at(0) size

occuranceList := list()
numLen repeat(
    occuranceList append(
        Object clone do(zero := 0; one := 0)
    )
)

occuranceList = numericList reduce(acc, lst,
    for(i, 0, lst size - 1,
        numAt := lst at(i)
        slotName := if(numAt == 0, "zero", "one")

        statsAt := acc at(i)
        statsAt setSlot(slotName, statsAt getSlot(slotName) + 1)
    )

    acc,
    occuranceList
)

gamma := occuranceList map(value,
    if(value zero > value one, "0", "1")
) join fromBase(2)
epsilon := occuranceList map(value,
    if(value zero < value one, "0", "1")
) join fromBase(2)
(gamma * epsilon) println