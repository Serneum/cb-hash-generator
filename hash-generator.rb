# require the openssl library if running in a local irb or rails console session
require "openssl"
require 'optparse'

# Compute signature in Ruby
def compute_signature(timestamp, payload, secret)
  timestamped_payload = "#{timestamp}.#{payload}"
  OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha256"), secret,
                          timestamped_payload)
end

class Parser
  def self.parse(args)
    options = {}

    opts = OptionParser.new do |parser|
      parser.on('-h HEADER', '--header HEADER', "The complete header, including the timestamp and sha256 value.") do |header|
        header_format = /t=(\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z),sha256=(.*)/
        matches = header.match(header_format)
        options[:timestamp] = matches[1]
        options[:expected_hash] = matches[2]
      end

      parser.on('-f PAYLOAD_FILE', '--file PAYLOAD_FILE', "The name of the file containing the JSON payload.") do |file|
        options[:payload] = File.read(file)
      end

      parser.on('-s SECRET', '--secret SECRET') do |secret|
        options[:secret] = secret
      end
    end

    opts.parse(args)

    options
  end
end

options = Parser.parse(ARGV)

computed_hash = compute_signature(options[:timestamp], options[:payload], options[:secret]) # => output should match hash from header

puts "Expected Hash:\n\t#{options[:expected_hash]}"
puts "Computed Hash:\n\t#{computed_hash}"
