local text = string.match(io.popen("wpctl get-volume @DEFAULT_SINK@"):read("*a"), "%[MUTED%]")
print(not (text == nil))
