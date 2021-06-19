----Made by Jonathas Ribeiro--------
----@jonathasribeiroreal-----
instrument {
    name = 'Dynamic RSI',
    icon = 'indicators:RSI',
    overlay = false
}

input_group {
    "RSI",
    colorRsi = input {default = "#00FF0A", type= input.color},
    widthRsi = input {default = 1, type= input.line_width}
}

input_group {
    "Bollinger Bands Banda Superior",
    colorUpperBand = input {default = "#00FF0A", type= input.color},
    widthUpperBand = input {default = 1, type= input.line_width}
}

input_group {
    "Bollinger Bands Banda Inferior",
    colorLowerBand = input {default = "red", type= input.color},
    widthLowerBand = input {default = 1, type= input.line_width},
}

input_group {
    "Média Movel",
    colorMA = input {default = "#FF00FF", type= input.color},
    widthMA = input {default = 1, type= input.line_width},
}

RSIPeriod = input(14, "RSI Period")
BBPeriod = input(14, "Bollinger Bands Period")
MAPeriod = input(14, "MA Period")
Multi = input(1.3185, "BB Multiplier")
src = rsi(close, RSIPeriod)

----Bollinger Bands-------
basis = sma(src, BBPeriod)
dev = Multi * stdev(src, BBPeriod)
upper = basis + dev
lower = basis - dev
middle = sma(src, MAPeriod)

p1 = plot(upper, "high band",colorUpperBand, widthUpperBand)
p2 = plot(lower, "Low band", colorLowerBand, widthLowerBand)
p3 = plot(middle, "Moving Average", colorMA, widthMA)
p4 = plot(rsi(close, RSIPeriod), "RSI", colorRsi, widthRsi)
