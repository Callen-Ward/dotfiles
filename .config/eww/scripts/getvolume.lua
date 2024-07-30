local volume_decimal = string.match(io.popen("wpctl get-volume @DEFAULT_SINK@"):read("*a"), "^Volume: ([%d%.]*)")
print(tonumber(volume_decimal) * 100)
