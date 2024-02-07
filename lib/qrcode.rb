require_relative "qrcode/version"
require 'uri'
require 'net/http'
require 'json'

module QRCode
  @base_url = "https://api.qrserver.com/v1/"

  def self.qr_create(url, width = 100, height = 100)
    uri = URI("#{@base_url}create-qr-code/?data=#{url}&size=#{width.to_s}x#{height.to_s}")

    begin
        res = Net::HTTP.get_response(uri)
    rescue
        return "Failed to connect with API endpoint."
    end

    return res.body if res.is_a?(Net::HTTPSuccess)
  end

  def self.qr_read(url)
    uri = URI("#{@base_url}read-qr-code/?fileurl=#{url}")

    begin
        res = Net::HTTP.get_response(uri)
    rescue
        return "Failed to connect with API endpoint."
    end

    parsed_json = JSON.parse(res.body)[0]["symbol"][0];

    if ! parsed_json['error'].nil?
        return "Error: " + parsed_json['error'].to_s
    end

    return parsed_json['data'].to_s if res.is_a?(Net::HTTPSuccess)
  end
end
