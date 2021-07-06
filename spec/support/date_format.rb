# frozen_string_literal: true

module SpecHelpers
  module DateFormat
    def date_format(date)
      date.strftime("%I:%M %p, %d.%m.%Y")
    end
  end
end
