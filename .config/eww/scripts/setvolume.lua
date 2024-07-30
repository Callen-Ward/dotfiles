if arg[1] == "up" then
    io.popen("wpctl set-volume @DEFAULT_SINK@ 2%+ -l 1.0")
else
    io.popen("wpctl set-volume @DEFAULT_SINK@ 2%-")
end
