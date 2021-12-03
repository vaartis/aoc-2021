file := File clone openForReading("2.txt")
input := file readLines

reducer := method(acc, val,
    dirAndNum := val split
    dir := dirAndNum at(0)
    num := dirAndNum at(1) asNumber

    if(dir == "forward") then(
        acc horizontal = acc horizontal + num
        acc vertical = acc vertical + (num * acc aim)
    ) elseif(dir == "down") then(
        acc aim = acc aim + num
    ) elseif(dir == "up") then(
        acc aim = acc aim - num
    )

    acc
)
resultPosition := input reduce(
    acc, val, reducer(acc, val),
    Object clone do(
        horizontal := 0
        vertical := 0
        aim := 0
    )
)

resultPosition do(
    (horizontal * vertical) println
)