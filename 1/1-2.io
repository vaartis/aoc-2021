file := File clone openForReading("1.txt")
input := file readLines

reducer := method(acc, val,
    val = val asNumber

    acc window append(val)
    # Truncate the window if it's >3
    if(acc window size > 3, acc window removeAt(0))

    if(
        acc ? previous,
        do(
            if(acc window reduce(+) > acc previous, acc result = (acc result) + 1)
            acc previous = acc window reduce(+)
        ),
        do(
            if(acc window size == 3, acc previous := acc window reduce(+))
        )
    )

    acc
)

theResult := input reduce(
    acc, val, reducer(acc, val),
    Object clone do(
        result := 0
        window := list()
    )
) result

(theResult .. "\n") print
