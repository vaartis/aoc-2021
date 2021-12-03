file := File clone openForReading("2.txt")
input := file readLines

clampMin := method(min, value,
    if(value < min, min, value)
)

reducer := method(acc, val,
    dirAndNum := val split
    dir := dirAndNum at(0)
    num := dirAndNum at(1) asNumber

    if(dir == "forward") then(
        acc horizontal = acc horizontal + num
    ) elseif(dir == "down") then(
        acc vertical = acc vertical + num
    ) elseif(dir == "up") then(
        acc vertical = clampMin(0, acc vertical - num)
    )

    acc
)
resultPosition := input reduce(
    acc, val, reducer(acc, val),
    Object clone do(
        horizontal := 0
        vertical := 0
    )
)

resultPosition do(
    (horizontal * vertical) println
)