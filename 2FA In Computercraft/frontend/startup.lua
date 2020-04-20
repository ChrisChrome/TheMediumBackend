os.pullEvent = os.pullEventRaw
serverURL    = "serverhost"
port         = "serverport"
id           = "2faid"
doorSide     = "redstoneside"

function printCenter( mon, text )
    local x, y = mon.getSize()
    mon.setCursorPos( x/2 - (#text / 2) + 1, y/2)
    mon.write(text)
end
local function centerText(text)
    local x,y = term.getSize()
    local x2,y2 = term.getCursorPos()
    term.setCursorPos(math.ceil((x / 2) - (text:len() / 2)), y2)
    write(text)
end
term.clear()
term.setCursorPos(1,1)
centerText("THIS AREA IS OFF LIMITS")
term.setCursorPos(1,2)
centerText("UNAUTHORISED ENTRANCE WILL RESULT IN PERMANENT BAN")
term.setCursorPos(1,3)
centerText("AUTHORISED: "..id)
term.setCursorPos(1,4)
print("Enter Code> ")
term.setCursorPos(12,4)
--end setup stuff
input = read(string.char(7))
response = http.get("http://"..serverURL..":"..port.."/check?id="..id.."&code="..input)
if response == nil then
    term.setBackgroundColor(colors.orange)
    term.clear()
    printCenter(term, "COULD NOT CONNECT TO AUTH SERVER | PLEASE REPORT")
    sleep(5)
    os.reboot()
end
resstr = response.readLine(1)
if resstr == "True" then
    res = true
else
    res = false
end
if res == true then
    term.setBackgroundColor(colors.green)
    rs.setOutput(doorSide, true)
    term.clear()
    printCenter(term, "PASSWORD ACCEPTED")
    sleep(5)
    os.reboot()
else
    term.setBackgroundColor(colors.red)
    term.clear()
    printCenter(term, "PASSWORD DENIED")
    sleep(5)
    os.reboot()
end
