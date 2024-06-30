-- This is an example script.
-- This script uses our custom dango.lua framework, this code will be compiled to Java, to run in Dango.

local dango = require("dango")

local WindowManager = {}

WindowManager.windows = {}

function WindowManager.addWindow(title, x, y, width, height)
    local window = {
        title = title,
        position = { x = x, y = y },
        size = { width = width, height = height },
        minimized = false,
        focused = false,
        visible = true,
        content = {}
    }
    table.insert(WindowManager.windows, window)

    dango.emit("window_added", window)
end


function WindowManager.listWindows()
    for i, window in ipairs(WindowManager.windows) do
        print(string.format("Window %d: %s (%d, %d) - %dx%d", i, window.title, window.position.x, window.position.y, window.size.width, window.size.height))
    end
end

function WindowManager.resizeWindow(index, width, height)
    local window = WindowManager.windows[index]
    if window then
        window.size.width = width
        window.size.height = height
        dango.emit("window_resized", window)
    end
end

function WindowManager.minimizeWindow(index)
    local window = WindowManager.windows[index]
    if window then
        window.minimized = true
        window.visible = false
        dango.emit("window_minimized", window)
    end
end

WindowManager.addWindow("Terminal", 100, 50, 800, 600)
WindowManager.addWindow("Browser", 200, 100, 1000, 700)
WindowManager.addWindow("Text Editor", 150, 80, 600, 500)

return WindowManager
