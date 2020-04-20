term.clear()
term.setCursorPos(1,1)
print("Starting server OS on output monitor: monitor_1")
while true do
    shell.run("monitor monitor_1 server.lua")
    print("Terminated: Allowing time to kill")
    sleep(10)
    print("Restarting server.lua")
end
