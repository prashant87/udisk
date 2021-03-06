json = require('json')
dump = require('dump')
wifi = require('wifi')

function lcd.print(str)
    return lcd.write('MSG', str)
end
lcd.write('IMG', 'P:/lua/img/love.bin')
lcd.write('BATT', 0)
lcd.write('WIFI', 0)
print(dump.table(sys.info()))
if (apds.read('distance') > 200) then
    lcd.print('Connecting\nWiFi\n...')
    sys.delay(1000)
    if (not wifi.start_sta('XWX', 'xwxlovexy')) then
        print('Connect to AP and log in to http://192.168.1.1 and configure router information')
        lcd.print('Connect to AP and log in to http://192.168.1.1 and configure router information')
        wifi.start_ap('udisk', '')
    else
        sys.delay(1000)
        lcd.write('WIFI', 1)
        print(dump.table(net.info()))
        web.file('/lua/udisk.lua', 'http://xwx.emake.run/udisk/lua/udisk.lua')
        dofile('/lua/udisk.lua')
    end
end

local last_1s = os.time()
local sys_stats = sys.stats(10)
function delay(ms)
    for i = 0, ms / 10, 1 do
        if (os.difftime (os.time(), last_1s) >= 1) then
            sys_info = sys.info()
            lcd.write('STATE', os.date("%H:%M:%S"))
            print(string.format('RAM left: %dB', tonumber(sys_info.total_heap)))
            print(string.format('CPU load: %d%%', 100 - sys_stats.IDLE0.load))
            print(string.format('Distance: %d', apds.read('distance')))
            last_1s = os.time()
        end
        sys_stats = sys.stats(10)
    end
end

lcd.print('')
while (1) do
    for i = 0, 2, 1 do
        if (i == 0) then
            lcd.write('IMG', 'P:/lua/img/love.bin')
        elseif(i == 1) then
            lcd.write('IMG', 'P:/lua/img/love1.bin')
        elseif(i == 2) then
            lcd.write('IMG', 'P:/lua/img/love2.bin')
        end
        
        for x = 0, 255, 1 do
            led.write(x, 0, 0)
            delay(10)
        end
        for x = 0, 255, 1 do
            led.write(255 - x, 0, 0)
            delay(10)
        end
        for x = 0, 255, 1 do
            led.write(0, x, 0)
            delay(10)
        end
        for x = 0, 255, 1 do
            led.write(0, 255 - x, 0)
            delay(10)
        end
        for x = 0, 255, 1 do
            led.write(0, 0, x)
            delay(10)
        end
        for x = 0, 255, 1 do
            led.write(0, 0, 255 - x)
            delay(10)
        end
        for x = 0, 255, 1 do
            led.write(x, x, x)
            delay(10)
        end
        for x = 0, 255, 1 do
            led.write(255 - x, 255 - x, 255 - x)
            delay(10)
        end
    end
end

