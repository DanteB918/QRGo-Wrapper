# frozen_string_literal: true

require "test_helper"

class TestTestgem < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::QRCode::VERSION
  end

  def test_create_qr_returns_an_image
    qr = QRCode.qr_create("https://example.com", 100, 100)

    assert qr.include?("PNG")
  end

  def test_read_qr_fails_on_unreadable_qr
    read = QRCode.qr_read("https://dantebradshaw.com")

    assert read.include?('Error:' )
  end

  def test_read_qr_passes_on_readable_qr
    read = QRCode.qr_read("https://api.qrserver.com/v1/create-qr-code/?data=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2Fd%2Fd0%2FQR_code_for_mobile_English_Wikipedia.svg%2F220px-QR_code_for_mobile_English_Wikipedia.svg.png&size=220x220&margin=0")

    assert read == "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/220px-QR_code_for_mobile_English_Wikipedia.svg.png"
  end
end
