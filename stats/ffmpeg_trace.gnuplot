datafile = "sar.dat"
set datafile commentschar ""
set title "Processor Utilization"
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set datafile separator ";"
set terminal pngcairo size 800,500
set output 'sar.png'
set xlabel "Time"
set ylabel "% Utilization"
set xtics rotate
set key below
set grid
plot for [i=5:8:1] \
    datafile using 3:(sum [col=i:8] column(col)) \
    title columnheader(i) \
    with lines
