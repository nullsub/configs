#!/usr/bin/gnuplot
reset
set terminal png size 1024,768


set xdata time
set timefmt "%d/%m/%Y %H:%M:%S"
set format x "%H:%M"
set xlabel "time"

set ylabel "Temperature in °C"
set yrange [0:110]

set title "cpuburn temperature"
set key reverse Left outside
set grid

set style data linespoints

plot "sensors.txt" using 1:3 title "temp1", \
"" using 1:4 title "temp2", \
"" using 1:5 title "PhyId 0", \
"" using 1:6 title "Core 0", \
"" using 1:7 title "Core 1"
