require "cginatra/helpers"
require "rack"

module CGInatra
  def self.rack_env
    @rack_env ||= ENV.to_h.merge(
      "rack.input" => $stdin,
    )
  end

  def self.request
    @request ||= Rack::Request.new(rack_env)
  end

  def self.response
    @response ||= Rack::Response.new([], 200, "Content-Type" => "text/html")
  end

  def self.commit_headers!
    return if @headers_sent
    @headers_sent = true

    response.headers.merge(
      "Status" => response.status.to_s
    ).each_pair do |name, value_lines|
      value_lines.split(/\n+/).each do |value|
        print "#{name}: #{value}\r\n"
      end
    end

    print "\r\n"
  end

  def self.output_response
    commit_headers!
    print response.body.join
  end

  def self.handle_exception(exception)
    commit_headers!
    puts "<h1 style='background-color:#ffaaaa; padding:8px;'>#{Rack::Utils.escape_html(exception.class.to_s)}</h1>"
    puts "<em>#{Rack::Utils.escape_html(exception.message.to_s)}</em>"
    puts "<pre>#{Rack::Utils.escape_html(exception.backtrace.join("\n"))}</pre>"
    exit! false
  end
end

$stdout.sync = true

# extend the CGInatra helpers into the main object
extend CGInatra::Helpers

# install exception handler
at_exit do
  if $!
    CGInatra.handle_exception($!)
  else
    CGInatra.output_response
  end
end
