local ws = assert(http.websocket("ws://turtlewebsocks.ddns.net:8880"))

ws.send("SYN")

_G.CLIENT_ID, failure = ws.receive()

warn("Connected as client " .. _G.CLIENT_ID)

if failure then
    error("Error receiving Client ID!")
    exit()
end

while true do
    sleep(0.1)
    data, failure = ws.receive()

    serializedJSON = textutils.unserializeJSON(data)
    
    -- if serializedJSON then
    --     readableTable = textutils.serialize(serializedJSON)
    -- else
    --     readableTable = data
    -- end

    -- print(readableTable)

    if serializedJSON["message"] == "forward" then
        turtle.forward()
    elseif serializedJSON["message"] == "backward" then
        turtle.back()
    elseif serializedJSON["message"] == "left" then
        turtle.turnLeft()
    elseif serializedJSON["message"] == "right" then
        turtle.turnRight()
    elseif serializedJSON["message"] == "exit" then
        exit()
    elseif serializedJSON["message"] == "shutdown" then
        os.shutdown()
    elseif serializedJSON["message"] == "suckdown" then
        turtle.suckDown()
    elseif serializedJSON["message"] == "suckup" then
        turtle.suckUp()
    elseif serializedJSON["message"] == "suck" then
        turtle.suck()
    elseif serializedJSON["message"] == "attack" then
        turtle.attack()
    elseif serializedJSON["message"] == "attackup" then
        turtle.attackUp()
    elseif serializedJSON["message"] == "attackdown" then
        turtle.attackDown()
    elseif serializedJSON["message"] == "getfuel" then
        local fuel = turtle.getFuelLevel()
        ws.send(string.format('{"ClientID": "%s", "message": "%s"}', "EXE", tostring(fuel)))
    elseif serializedJSON["message"] == "setname" then
        os.setComputerLabel(serializedJSON["args"][0])
    end
end

ws.send("Hello, world!")
