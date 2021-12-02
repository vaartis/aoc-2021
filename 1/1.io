file := File clone openForReading("1.txt")
input := file readLines

reducer := method(acc, val,
    val = val asNumber

    if(
        acc ? previous,
        do(
            if(val > acc previous, acc result = (acc result) + 1)
            acc previous = val
        ),
        do(
            acc previous := val
        )
    )

    acc
)

theResult := input reduce(
    acc, val, reducer(acc, val),
    Object clone do(
        result := 0
    )
) result

(theResult .. "\n") print
