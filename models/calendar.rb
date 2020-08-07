require 'date'

class Calendar
  attr_reader :date, :header

  def initialize(first_week_day = 'Su')
    raise ArgumentError, 'expected one of Su, Mo, etc' unless abbr_week_days.include?(first_week_day)

    @date = Date.today
    @header = week_days(first_week_day)
  end

  def execute
    puts output
  end

  private

  def abbr_week_days
    @abbr_week_days ||= Date::ABBR_DAYNAMES.map{ |week_day| week_day[0..1] }
  end

  def week_days(first_week_day)
    return abbr_week_days if first_week_day == 'Su'

    index_of_day = abbr_week_days.index(first_week_day)
    abbr_week_days[index_of_day..-1] + abbr_week_days[0...index_of_day]
  end

  def start_point(date)
    header.index(
      date.strftime("%a")[0..1]
    )
  end

  def beginning_of_month
    Date.new(date.year, date.month)
  end

  def last_day
    Date.new(date.year, date.month, -1).mday
  end

  def fill_calendar
    calendar = Hash.new{ |cal, key| cal[key] = Array.new(7) {''} }
    week = 0
    index = start_point(beginning_of_month)

    (1..last_day).each do |day|
      if index == 7
        week += 1
        index = 0
      end
      calendar[week][index] = day
      index += 1
    end

    calendar
  end

  def format(day)
    "%2d" % day.to_i
  end

  def format_calendar
    fill_calendar.values.map do |row|
      row.map { |day| format(day) }.join(" ").gsub(/\s0/, " "*2) << "\n"
    end.inject(:+)
  end

  def format_title
    date.strftime("%B %Y").center(format_header.size)
  end

  def format_header
    header.join(' ')
  end

  def output
    [format_title, format_header, format_calendar].join("\n")
  end
end
