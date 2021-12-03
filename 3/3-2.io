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

mostPopularInPosition := method(theList, i, forLifeSupport,
     result := theList reduce(acc, lst,
        numAt := lst at(i)
        slotName := if(numAt == 0, "zero", "one")

        acc setSlot(slotName, acc getSlot(slotName) + 1)

        acc,
        Object clone do(zero := 0; one := 0)
    )

    if(forLifeSupport) then(
        if(result zero == result one) then(
            return 1
        ) elseif(result zero > result one) then(
            return 0
        ) else(
          return 1
        )
    ) else(
        if(result zero == result one) then(
            return 0
        ) elseif(result zero > result one) then(
            return 1
        ) else(
          return 0
        )
    )
)

lifeSupport := numericList clone
for(i, 0, numLen - 1,
    mostPopular := mostPopularInPosition(lifeSupport, i, true)

    lifeSupport selectInPlace(elem, elem at(i) == mostPopular)
    if(lifeSupport size == 1, break)
)
lifeSupport = lifeSupport at(0) join fromBase(2)

co2Scrubbing := numericList clone
for(i, 0, numLen - 1,
    mostPopular := mostPopularInPosition(co2Scrubbing, i, false)

    co2Scrubbing selectInPlace(elem, elem at(i) == mostPopular)
    if(co2Scrubbing size == 1, break)
)
co2Scrubbing = co2Scrubbing at(0) join fromBase(2)

(lifeSupport * co2Scrubbing) println
