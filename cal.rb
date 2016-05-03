#!/usr/bin/env ruby

require 'colorize'
require 'date'

class Calendar
	COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

	def initialize(date_hash)
		@month = date_hash['m'] || Date.today.month
		@year = date_hash['y'] || Date.today.year
		@show_year = !!date_hash['y']
	end

	def days_in_month(month, year = Time.now.year)
		return 29 if month == 2 && Date.gregorian_leap?(year)
		COMMON_YEAR_DAYS_IN_MONTH[month]
	end

	def weekend?(month, day)
		date = Date.new(@year, month, day)
		date.saturday? || date.sunday?
	end

	def print_day(month, day)
		print ' ' if day < 10
		if Date.today == Date.new(@year, month, day)
			print day.to_s.colorize(:red)
		elsif weekend?(month, day)
			print day.to_s.colorize(:grey)
		else
			print day.to_s.colorize(:white)
		end
		print ' '
	end

	def print_month(month)
		target_date = Date.new(@year, month, 1)
		title = target_date.strftime("%B %Y")
		title_buffer = ' ' * ((20 - title.length) / 2)
		days = (1..days_in_month(month, @year))
		first_day_of_month = Date.new(@year, month, 1)
		wday = first_day_of_month.wday
		wday = 7 if wday == 0
		offset = wday - 1

		puts title_buffer + title.colorize(:white)
		puts 'Mo Tu We Th Fr Sa Su'.colorize(:white)

		print '   ' * offset

		days.each do |day|
			print_day(month, day)
			print "\n" if (day + offset) % 7 == 0
		end
		puts
	end

	def print_all
		if @show_year
			(1..12).each do |month|
				print_month(month)
				puts unless month == 12
			end
		else
			print_month(@month)
		end
	end
end

args = {}
for i in (0..ARGV.length - 1).step(2) do
	args[ARGV[i].gsub('-', '')] = ARGV[i+1].to_i
end
Calendar.new(args).print_all
