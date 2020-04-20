logMonitor = peripheral.wrap("monitor_1")
term.clear()
term.setCursorPos(1,1)
term.setTextColor(colors.purple)
print("SEAPonytCon Server Starting Up")
print("Made by @Chris Chrome#9158 | "..string.char(169).." Chris Chrome 2020")
print("Licensed under Creative Commons Attribution-ShareAlike 4.0 International License")
term.setTextColor(colors.white)
os.loadAPI("output")
os.loadAPI("json")
output.setside("front")
d1 = peripheral.wrap("webdisplays_4")
d2 = peripheral.wrap("webdisplays_5")
d3 = peripheral.wrap("webdisplays_6")
d4 = peripheral.wrap("webdisplays_7")
d5 = peripheral.wrap("webdisplays_8")

function cameraTP (username)
    print("CameraTP: "..username)
    commands.teleport(username..' 698 28 -466 0 20')
end
function welcomeToStage (username)
    print("WelcomeToStage: "..username)
    commands.teleport(username .. " 698 21 -443 180 0")
    commands.execute(username .. " ~ ~ ~ particle cloud ~ ~ ~ 1 2 1 0 10000")
end
function announce(title, subtitle)
    print("Announce: "..title..","..subtitle)
    commands.playsound("block.note.chime master @a ~ ~ ~ 100 1")
    sleep(.1)
    commands.playsound("block.note.chime master @a ~ ~ ~ 100 1.5")
    sleep(.1)
    commands.playsound("block.note.chime master @a ~ ~ ~ 100 2")
    sleep(.1)
    commands.title('@a subtitle {"text":"'..subtitle..'"}')
    commands.title('@a title {"text":"'..title..'"}')
end

function blackout()
    print("Blackout")
    d1.setURL("about:blank")
    sleep(.5)
    d1.runJS('document.body.style.backgroundColor = "black";')
    d2.setURL("about:blank")
    sleep(.5)
    d2.runJS('document.body.style.backgroundColor = "black";')
    d3.setURL("about:blank")
    sleep(.5)
    d3.runJS('document.body.style.backgroundColor = "black";')
    d4.setURL("about:blank")
    sleep(.5)
    d4.runJS('document.body.style.backgroundColor = "black";')
    d5.setURL("about:blank")
    sleep(.5)
    d5.runJS('document.body.style.backgroundColor = "black";')
end

function url (url)
    print("Set URL: "..url)
    d1.setURL(url)
    d2.setURL(url)
    d3.setURL(url)
    d4.setURL(url)
    d5.setURL(url)
end

function click (x, y)
    print("Click: "..x..","..y)
    d1.click(x, y)
    d2.click(x, y)
    d3.click(x, y)
    d4.click(x, y)
    d5.click(x, y)
end

--Initialize all displays
--d1.setResolution(1920,1080)
--d2.setResolution(1920,1080)
--d3.setResolution(1920,1080)
--d4.setResolution(1920,1080)
--d5.setResolution(1920,1080)

--Initialize RedNet
rednet.open("top")
term.setTextColor(colors.lightBlue)
print("Opening Rednet: top")
term.setTextColor(colors.green)
print("Successfully Started Server!")
term.setTextColor(colors.white)
while true do
    term.setTextColor(colors.orange)
    print("Waiting For Data")
    term.setTextColor(colors.lightBlue)
    sender, data, action = rednet.receive()
    print("Recieved Data: "..sender..","..data..","..action)
    if action == "setURL" then
        print("Action: setURL")
        url(data)
    elseif action == "welcome" then
        print("Action: welcome")
        welcomeToStage(data)
    elseif action == "blankScreens" then
        print("Action: blankScreens")
        blackout()
    elseif action == "focus" then
        print("Action: focus")
        blackout()
        d3.setURL(data)
    elseif action == "announcement" then
        print("Action: announcement")
        data1 = json.decode(data)
        announce(data1.title, data1.subtitle)
    elseif action == "camera" then
        print("Action: camera")
        cameraTP(data)
    elseif action == "setBundled" then
        print("Action: setBundled")
        data = json.decode(data)
        output.set(data.color, data.value)
    elseif action == "panic" then
        print("Action: panic")
        url("about:blank")
        commands.tp("@a 698 21 -451")
        os.shutdown()
    end
end
