
import network

wlan = network.WLAN(network.STA_IF)
wlan.active(True)
wlan.config(dhcp_hostname='esp32cam')
wlan.connect('I am King!','cobatanyayanglain')
#wlan.connect()

import webcam
webcam.run()
