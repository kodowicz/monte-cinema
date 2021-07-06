# frozen_string_literal: true

module SpecHelpers
  module Response
    def response_json
      JSON.parse(response.body)
    end

    def show_response_error
      open_html_file(response.stream.each.first)
    end

    private

    def open_html_file(source)
      path = "tmp/tmp_html.html"
      File.open(path, "w") { |f| f.write(source) }
      system("open #{path}")
    end
  end
end
