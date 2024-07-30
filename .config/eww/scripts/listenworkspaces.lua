local socket_path = os.getenv("XDG_RUNTIME_DIR") ..
    "/hypr/" .. os.getenv("HYPRLAND_INSTANCE_SIGNATURE") .. "/.socket2.sock"

local socket = require("posix.sys.socket")
local fd = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM, 0)

socket.connect(fd, { family = socket.AF_UNIX, path = socket_path })

local active_workspace = string.match(io.popen("hyprctl activeworkspace"):read("*a"), "^workspace ID (%d*) .*$")
local workspaces = {
    { id = "1", empty = true, },
    { id = "2", empty = true, },
    { id = "3", empty = true, },
    { id = "4", empty = true, },
    { id = "5", empty = true, },
    { id = "6", empty = true, },
    { id = "7", empty = true, },
    { id = "8", empty = true, },
    { id = "9", empty = true, },
}

local function render()
    local yuck = ""

    for _, workspace in pairs(workspaces) do
        local class = workspace.id == active_workspace and ":class 'active'" or ""
        local icon = workspace.empty and "''" or "''"

        yuck = yuck ..
            "(button " .. class .. " :onclick 'hyprctl dispatch workspace " .. workspace.id .. "' " .. icon .. ")"
    end

    print("(box :class 'workspaces' " .. yuck .. ") ")
end

local function update_active(active_id)
    active_workspace = active_id
end

local function update_empty()
    local handle = io.popen("hyprctl workspaces")
    local text = handle:read("*a")
    handle:close()

    local section_id = nil

    for line in string.gmatch(text, "[^\r\n]+") do
        local id = string.match(line, "^workspace ID (.*) %(.*%) on monitor .*:$")
        if id ~= nil then section_id = id end

        local windows = string.match(line, "^%s*windows: (.)$")
        if windows ~= nil and tonumber(section_id) > 0 then
            workspaces[tonumber(section_id)].empty = tonumber(windows) == 0
            section_id = nil
        end
    end
end

update_empty()
render()
while true do
    local text = socket.recv(fd, 4096)

    for line in string.gmatch(text, "[^\r\n]+") do
        local active_id = string.match(line, "^workspacev2>>(%d*).*$")
        if active_id ~= nil then
            update_active(active_id)
            render()
        end

        if string.match(line, "^openwindow>>") or string.match(line, "^closewindow>>") or string.match(line, "^movewindow>>") then
            update_empty()
            render()
        end
    end
end
