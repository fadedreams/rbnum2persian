# frozen_string_literal: true

require_relative "rbnum2persian/version"

module Rbnum2persian
  ARABIC_NUMBERS = ['١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩', '٠']
  PERSIAN_NUMBERS = ['۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹', '۰']
  ENGLISH_NUMBERS = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']

  def self.to_english_digits(value)
    return value if value.empty? || value.match?(/^[0-9]+$/)

    value.gsub(/[#{ARABIC_NUMBERS.join}#{PERSIAN_NUMBERS.join}]/) do |match|
      ENGLISH_NUMBERS[ARABIC_NUMBERS.index(match)] || ENGLISH_NUMBERS[PERSIAN_NUMBERS.index(match)]
    end
  end

  def self.num2persian(input, level = 0, is_ordinal = false)
    return '' if input.to_s.empty?

    num = input.is_a?(String) ? to_english_digits(input).to_i : input.to_i
    raise 'Error: number is out of range' if num > 999_999_999_999_999

    return 'صفر' if num.zero? && level.zero?
    return '' if num.zero?

    result = ''
    yekan = %w[یک دو سه چهار پنج شش هفت هشت نه]
    dahgan = %w[بیست سی چهل پنجاه شصت هفتاد هشتاد نود]
    sadgan = %w[یکصد دویست سیصد چهارصد پانصد ششصد هفتصد هشتصد نهصد]
    dah = %w[ده یازده دوازده سیزده چهارده پانزده شانزده هفده هیجده نوزده]

    result += ' و ' if level.positive?
    tmp1 = level + 1

    if num < 10
      result += yekan[num - 1]
    elsif num < 20
      result += dah[num - 10]
    elsif num < 100
      result += "#{dahgan[(num / 10) - 2]}#{num2persian(num % 10, tmp1)}"
    elsif num < 1000
      result += "#{sadgan[(num / 100) - 1]}#{num2persian(num % 100, tmp1)}"
    elsif num < 1_000_000
      result += "#{num2persian(num / 1000, level)} هزار#{num2persian(num % 1000, tmp1)}"
    elsif num < 1_000_000_000
      result += "#{num2persian(num / 1_000_000, level)} میلیون#{num2persian(num % 1_000_000, tmp1)}"
    elsif num < 1_000_000_000_000
      result += "#{num2persian(num / 1_000_000_000, level)} میلیارد#{num2persian(num % 1_000_000_000, tmp1)}"
    elsif num < 1_000_000_000_000_000
      result += "#{num2persian(num / 1_000_000_000_000, level)} تریلیارد#{num2persian(num % 1_000_000_000_000, tmp1)}"
    end

    result = add_ordinal_suffix(result) if is_ordinal

    result
  end

  def self.add_ordinal_suffix(number)
    return '', 'PersianTools: addOrdinalSuffix - The input must be string' if number.empty?

    if number.end_with?('ی')
      "#{number} اُم"
    elsif number.end_with?('سه')
      "#{number[0..-3]}سوم"
    else
      "#{number}م"
    end
  rescue StandardError => e
    "Error: #{e.message}"
  end
end
