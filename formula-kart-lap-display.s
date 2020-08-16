# A code made for Formula Kart Wii to display the lap count in the milliseconds timer with an offset from the negative initial amount
# See http://wiki.tockdom.com/wiki/Formula_Kart_Wii
# Uses JoshuaMK's millisecond timer modification address https://www.mkwii.com/showthread.php?tid=1448

.set REGION, 'P'
.if REGION == 'P'
  .set RACEDATA, 0x809bd728
.else
  .err # ports not done
.endif

# Load HUD pid and convert it to player array index
# racedata.main = 0x1c
# main.scenarios[0] = 0x4
# scenarios[0].settings = 0xb48
# settings.hudPlayerIds[0] = 0x1c
# total = 0xb84
lis r26, RACEDATA@ha
lwz r26, RACEDATA@l (r26)
lbz r26, 0xb84 (r26)
rlwinm r26, r26, 2, 0, 29 # multiply by 4

# Get raceinfo pointer - needs special porting
lis r28, 0x809C
lwz r28, -0x28d0 (r28)

# Get player from player array
lwz r28, 0xC (r28)
lwzx r28, r28, r26

# Get current lap of player, store to r28 to set timer
lbz r28, 0x25 (r28)
