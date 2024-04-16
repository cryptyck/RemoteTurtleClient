local ws = assert(http.websocket("ws://turtlewebsocks.ddns.net:8880"))

ws.send("SYN")

_G.CLIENT_ID, failure = ws.receive()

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
    end
end

ws.send("Hello, world!")
