----Made by Jonathas Ribeiro--------
----@jonathasribeiroreal-----
instrument {
    name = 'TS Value Chart',
    icon = 'indicators:BelkhayateTiming',
    overlay = false
}

function prev(s,i)
    y=abs(round(i))
    return s[y]
end

length = input(5, "Numero de Velas")
extTop = input(12, "Extreme Level Top")
extBot = input(-12, "Extreme Level Bottom")
sigTop = input(8, "Significant Level Top")
sigBot = input(-8, "Significant Level Bottom")
fairTop = input(4, "Fair Value Top")
fairBot = input(-4, "Fair Value Bottom")

varp = round(length/5)
h_f = length > 7

vara= h_f and highest(high,varp)-lowest(low,varp) or 0
varr1 = h_f and iff(vara==0 and varp==1,abs(close-prev(close,-varp)),vara) or 0
varb=h_f and prev(highest(high,varp),-varp+1)-prev(lowest(low,varp),-varp) or 0
varr2 = h_f and iff(varb==0 and varp==1,abs( prev(close,-varp)-prev(close,-varp*2) ),varb) or 0
varc=h_f and prev(highest(high,varp),-varp*2)-prev(lowest(low,varp),-varp*2) or 0
varr3 = h_f and iff(varc == 0 and varp==1,abs(prev(close,-varp*2)-prev(close,-varp*3)),varc) or 0
vard = h_f and prev(highest(high,varp),-varp*3)-prev(lowest(low,varp),-varp*3) or 0
varr4 = h_f and iff(vard == 0 and varp==1,abs(prev(close,-varp*3)-prev(close,-varp*4)),vard) or 0
vare = h_f and prev(highest(high,varp),-varp*4)-prev(lowest(low,varp),-varp*4) or 0
varr5 = h_f and iff(vare == 0 and varp==1,abs(prev(close,-varp*4)-prev(close,-varp*5)),vare) or 0
cdelta = abs(close - prev(close,-1))
var0 = (not h_f) and iff((cdelta > (high-low)) or (high==low),cdelta,(high-low)) or 0
lrange=h_f and ((varr1+varr2+varr3+varr4+varr5)/5)*.2 or sma(var0,5)*.2

mba = sma( (high+low)/2,length)
vopen = (open- mba)/lrange
vhigh = (high-mba)/lrange
vlow = (low-mba)/lrange 
vclose = (close-mba)/lrange 

colorr = open > close and "red" or "green"

plot_candle {
    open = vopen,
    high = vhigh,
    low = vlow,
    close = vclose,
    candle_color = colorr
}

hline(extTop,"","red")
hline(extBot,"","green") 
hline(sigTop,"","red")
hline(sigBot,"","green")
hline(fairTop,"","red")
hline(fairBot,"","green")