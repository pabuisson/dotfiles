#!/usr/bin/env ruby

# <xbar.title>Warning when bluetooth is turned off</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.author>Pierre-Adrien Buisson</xbar.author>
# <xbar.author.github>pabuisson</xbar.author.github>
# <xbar.desc>Show colorful emojis when BT is turned off</xbar.desc>
# <xbar.image></xbar.image>
# <xbar.dependencies>ruby</xbar.dependencies>

status = `/usr/local/bin/blueutil -p`.chomp

if status == '1'
  puts '‧'
  puts '---'
  puts 'Bluetooth is enabled'
else
  # Make it "blink"
  case rand(2)
  when 0 then puts '🟥 BT OFF 🟥|dropdown=false'
  when 1 then puts '🟨 BT OFF 🟨|dropdown=false'
  end
end
