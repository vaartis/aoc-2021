file := File clone openForReading("3.txt")
input := file readLines

Sequence binaryAsDecimal := method(
    reversed := self reverse
    result := 0

    for(i, 0, reversed size - 1,
        numAt := reversed charAt(i) asNumber

        result = result + (numAt * (2 ** i))
    )

    result
)

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
) join binaryAsDecimal
epsilon := occuranceList map(value,
    if(value zero < value one, "0", "1")
) join binaryAsDecimal
(gamma * epsilon) println