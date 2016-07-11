cal
===

This Ruby script can replace the UNIX `cal` tool. I basically wanted it to highlight the current date, and to show week days and weekends in a separate color.

It follows some of the `cal` command line options, mostly for specifying month and year. It's not a complete replacement, as I haven't needed all that the original `cal` does.

Usage:

`cal` Show current month, highlight current day in red

`cal -m 7` Show calendar for July

`cal -y 2017` Show calendars for all months of the year 2017

`cal -f calendar_file` Reads calendar_file for dates to highlight

Calendar file example:
`July 10th, 2016:
	Do laundry
	Call mom`

Every line ending in a colon is passed to `Date.parse`, and if successfully parsed, highlighted in yellow on the calendar.

Note: This version currently does not show months side by side, like the original `cal` does. Instead, they're listed one after the other.
