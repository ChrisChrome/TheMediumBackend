os.pullEvent = os.pullEventRaw
--Get modem side
local sides = { "top", "bottom", "left", "right", "front", "back" }
for i = 1, #sides do
    if peripheral.isPresent(sides[i]) then
        if peripheral.getType(sides[i]) == "modem" then
            rednet.open(sides[i])
        end
    end
end

function bundledColor(value, action)

end

function sendData(data, action)
    rednet.broadcast(data, action)
    --print("Debug sent: "..data.." action: "..action)
    --sleep(4)
end
function printHeaders()
    term.clear()
    term.setCursorPos(1,1)
    print("SPCQ Control System")
    print("Created by Chris Chrome")
end
function promptNumber()
    cx, cy = term.getCursorPos()
    print("Please type a number: ")
    term.setCursorPos(22, cy)
end
--Main menu options
printHeaders()
print("1 : Screen Control")
print("2 : Light Control")
print("3 : Make an announcement")
print("4 : Teleport a player to the stage")
print("5 : Teleport a player to the camera position")
print("6 : Developer Access")
promptNumber()
while true do
    input = read()
    if input == "1" then
        --Screen menu
        printHeaders()
        print("1 : Set URL of all screens")
        print("2 : Focus URL on center screen")
        print("3 : Blank all screens")
        promptNumber()
        input = read()
        if input == "1" then
            --Set URL of all
            printHeaders()
            print("Please enter a URL: ")
            x,y = term.getCursorPos()
            term.setCursorPos(x, y)
            input = read()
            sendData(input, "setURL")
            print("Set URL!")
            sleep(2)
            os.reboot()
        elseif input == "2" then
            --Focus URL
            printHeaders()
            print("Please enter a URL: ")
            x,y = term.getCursorPos()
            term.setCursorPos(x, y)
            input = read()
            sendData(input, "focus")
            print("Focused URL!")
            sleep(1)
            os.reboot()
        elseif input == "3" then
            --Blank screens
            printHeaders()
            sendData("", "blankScreens")
            print("Blanking all screens!")
            sleep(1)
            os.reboot()
        end
    elseif input == "2" then
        --Light controls
        printHeaders()
        print("1 : Stage Floor Lights")
        print("2 : Ceiling Lights")
        promptNumber()
        light = read()
        if light == "1" then
            light = "lightBlue"
        elseif light == "2" then
            light = "yellow"
        else
            print("Error: Please select a valid number!")
            sleep(1)
            os.reboot()
        end
        printHeaders()
        print("1 : Turn On")
        print("2 : Turn Off")
        promptNumber()
        value = read()
        if value == "1" then
            sendData('{"color": "'..light..'", "value": true}' ,"setBundled")
            printHeaders()
            print("Turning light on!")
            sleep(1)
            os.reboot()
        elseif value == "2" then
            sendData('{"color": "'..light..'", "value": false}' ,"setBundled")
            printHeaders()
            print("Turning light off!")
            sleep(1)
            os.reboot()
        else
            printHeaders()
            print("Error: Please enter a valid option")
            sleep(2)
            os.reboot()
        end
    elseif input == "3" then
        --Send Announcement
        title = ""
        subtitle = ""
        printHeaders()
        print("Please enter the title text: ")
        x,y = term.getCursorPos()
        term.setCursorPos(x, y)
        title = read()
        print("Set title: "..title)
        sleep(1)
        printHeaders()
        print("[OPTIONAL]")
        print("Please enter the subtitle text: ")
        x,y = term.getCursorPos()
        term.setCursorPos(x, y)
        subtitle = read()
        print("Set subtitle: "..subtitle)
        sleep(1)
        sendData('{"title": "'..title..'", "subtitle": "'..subtitle..'"}', "announcement")
        printHeaders()
        print("Sending announcement!")
        sleep(2)
        os.reboot()
    elseif input == "4" then
        --Welcome Teleport
        username = ""
        printHeaders()
        print("Please enter the full username of the player you would like to teleport")
        print("Username: ")
        x,y = term.getCursorPos()
        term.setCursorPos(x, y)
        username = read()
        sendData(username, "welcome")
        print("Attempting to teleport: "..username)
        sleep(3)
        os.reboot()
    elseif input == "5" then
        --Camera Teleport
        username = ""
        printHeaders()
        print("Please enter the full username of the player you would like to teleport")
        print("Username: ")
        x,y = term.getCursorPos()
        term.setCursorPos(x, y)
        username = read()
        sendData(username, "camera")
        print("Attempting to teleport: "..username)
        sleep(3)
        os.reboot()
    elseif input == "6" then
        printHeaders()
        print("Developer Access")
        print("Please enter your password")
        print("> ")
        x,y = term.getCursorPos()
        term.setCursorPos(x, y)
        input = read(string.char(7))
        response = http.get("http://thearcanebrony.net:6969/check?id=serverRoom&code="..input)
        res = response.readLine(1)
        if res == "True" then
            term.clear()
            term.setCursorPos(1,1)
            print("Developer Console")
            error()
        else
            print("Password Incorrect")
            sleep(1)
            os.reboot()
        end
    else
        printHeaders()
        print("Error: Please enter a valid option")
        sleep(2)
        os.reboot()
    end
end
