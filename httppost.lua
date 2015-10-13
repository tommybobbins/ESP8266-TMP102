HTTPHOST = "192.168.1.130"
HTTPPORT = 80
CLIENTID = "ESP8266-" ..  node.chipid()
MICROSECS = 900000000

id=0
sda=5 -- ESP8266 GPIO14
scl=6 -- ESP8266 GPIO12
-- # Adafruit Huzzah GPIO #16 = NodeMCU #0 -> RESET

print "Connecting to HTTP. Please wait..."
conn=net.createConnection(net.TCP, 0) 
Mac = wifi.sta.getmac()
conn:on("receive", function(conn, payload) print(payload) end)
conn:connect(HTTPPORT,HTTPHOST) 
Temperature = dofile("tmp102.lua").read(id, sda, scl)
-- Temperature = 20.0
-- conn:send("POST /temperature/checkin/ HTTP/1.1\r\n") 
conn:send("POST /checkin/" .. Mac .. "/temperature/" .. Temperature .. "/ HTTP/1.1\r\n") 
conn:send("\r\n")
conn:on("sent",function(conn)
                      print("Closing connection")
                      conn:close()
                  end)
conn:on("disconnection", function(conn)
                      print("Got disconnection...")
                      print ("Deep sleep...")
                      node.dsleep(MICROSECS);
                      print ("Awake...")
  end)
