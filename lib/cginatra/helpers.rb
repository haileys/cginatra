require "erb"

module CGInatra
  module Helpers
    def request
      CGInatra.request
    end

    def response
      CGInatra.response
    end

    def params
      request.params
    end

    def h(str)
      Rack::Utils.escape_html(str)
    end

    def erb(str, binding = TOPLEVEL_BINDING)
      response.write ERB.new(str).result(binding)
    end
  end
end
