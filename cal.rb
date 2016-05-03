#!/usr/bin/env ruby

require 'colorize'
require 'date'

COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

def days_in_month(month, year = Time.now.year)
	return 29 if month == 2 && Date.gregorian_leap?(year)
	COMMON_YEAR_DAYS_IN_MONTH[month]
end


today = Date.today
title = today.strftime("%B %Y")
title_buffer = ' ' * ((20 - title.length) / 2)
days = (1..days_in_month(today.month))
first_day_of_month = Date.new(today.year, today.month, 1)
wday = first_day_of_month.wday
wday = 7 if wday == 0
offset = wday - 1

puts title_buffer + title
puts 'Mo Tu We Th Fr Sa Su'

print '   ' * offset

days.each do |day|
	print ' ' if day < 10
	if day == today.mday
		print day.to_s.colorize(:red)
	else
		print day.to_s.colorize(:white)
	end
	print ' '
	print "\n" if (day + offset) % 7 == 0
end
puts
