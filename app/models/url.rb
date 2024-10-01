# frozen_string_literal: true

class Url < ApplicationRecord
  validate :valid_url

  def original_url
    if long_url.start_with?("http://", "https://")
      long_url
    else
      "http://#{long_url}"
    end
  end

  def valid_url
    if long_url.blank?
      errors.add(:long_url, :blank)
    elsif !long_url.match?(URI::DEFAULT_PARSER.make_regexp)
      errors.add(:long_url, :invalid)
    end
  end
end
