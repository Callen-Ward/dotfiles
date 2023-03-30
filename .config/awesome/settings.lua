local settings = {
    terminalcmd = 'kitty -e ',
    editorcmd   = 'neovide --multigrid',
    launchercmd = 'dmenu_run -nb "#12131d" -sf "#12131d" -sb "#c8d3f5" -nf "#c8d3f5"',
    browsercmd  = 'librewolf',
    mixercmd    = 'alsamixer',
    modkey      = 'Mod4',
    autostart   = {
        "picom"
    }
}

return settings
