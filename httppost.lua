HTTPHOST = "192.168.1.130"
HTTPPORT = 80
CLIENTID = "ESP8266-" ..  node.chipid()
MICROSECS = 950000000
--MICROSECS = 95

id=0
sda=5 -- ESP8266 GPIO14
scl=6 -- ESP8266 GPIO12
-- # Adafruit Huzzah GPIO #16 = NodeMCU #0 -> RESET
print "Getting Temperature"
Temperature = dofile("tmp102.lua").read(id, sda, scl)
if (Temperature < 85 ) then
  print ("Temperature: "..Temperature)
  print "Getting MAC Address"
  Mac = wifi.sta.getmac()
  Url=("GET /checkin/" .. Mac .. "/temperature/" .. Temperature .. "/ HTTP/1.1\r\n"
      .. "Host: " .. HTTPHOST .."\r\n"
      .. "Accept: */*\r\n\r\n")
  print "Connecting to HTTP. Please wait..."

  conn=net.createConnection(net.TCP, 0)
  conn:on("receive", function(conn, payload) print(payload) end )
  conn:on("connection", function(c)
      conn:send(Url) 
      end)
  conn:connect(HTTPPORT,HTTPHOST)
                        t=nil
                        Temperature=nil
                        tmp102 = nil
                        package.loaded["tmp102"]=nil
  conn:on("disconnection", function(conn)
                        print("Got disconnection...")
                        print ("Deep sleep...")
                        node.dsleep(MICROSECS);
     end)
end
