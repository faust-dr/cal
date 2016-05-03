#!/usr/bin/env ruby

require 'colorize'
require 'date'

class Calendar
	COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

	def initialize(month)
		@month = month
		@year = Date.today.year
	end

	def days_in_month(month, year = Time.now.year)
		return 29 if month == 2 && Date.gregorian_leap?(year)
		COMMON_YEAR_DAYS_IN_MONTH[month]
	end

	def weekend?(day)
		date = Date.new(@year, @month, day)
		date.saturday? || date.sunday?
	end

	def print_day(day)
		print ' ' if day < 10
		if Date.today == Date.new(@year, @month, day)
			print day.to_s.colorize(:red)
		elsif weekend?(day)
			print day.to_s.colorize(:grey)
		else
			print day.to_s.colorize(:white)
		end
		print ' '
	end

	def print_month
		target_date = Date.new(@year, @month, 1)
		title = target_date.strftime("%B %Y")
		title_buffer = ' ' * ((20 - title.length) / 2)
		days = (1..days_in_month(@month))
		first_day_of_month = Date.new(@year, @month, 1)
		wday = first_day_of_month.wday
		wday = 7 if wday == 0
		offset = wday - 1

		puts title_buffer + title
		puts 'Mo Tu We Th Fr Sa Su'

		print '   ' * offset

		days.each do |day|
			print_day(day)
			print "\n" if (day + offset) % 7 == 0
		end
		puts
	end
end

if ARGV.length > 0
	month = ARGV[1].to_i
	Calendar.new(month).print_month
else
	Calendar.new(Date.today.month).print_month
end
