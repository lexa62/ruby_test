#!/usr/bin/env ruby

OPERATIONS = {
  "add" => ->(a, b) { a + b },
  "sub" => ->(a, b) { a - b },
  "mul" => ->(a, b) { a * b },
  "div" => ->(a, b) do
    raise ArgumentError, "Cannot divide by zero" if b.zero?

    a / b
  end
}.freeze

def usage
  <<~TEXT
    Usage:
      ruby calculator.rb OPERATION NUMBER NUMBER

    Operations:
      add   Addition
      sub   Subtraction
      mul   Multiplication
      div   Division

    Examples:
      ruby calculator.rb add 2 3
      ruby calculator.rb div 10 4
  TEXT
end

if ARGV.include?("--help") || ARGV.include?("-h")
  puts usage
  exit 0
end

unless ARGV.length == 3
  warn usage
  exit 1
end

operation_name, left_raw, right_raw = ARGV

operation = OPERATIONS[operation_name]

unless operation
  warn "Unknown operation: #{operation_name}"
  warn usage
  exit 1
end

begin
  left = Float(left_raw)
  right = Float(right_raw)
  result = operation.call(left, right)
  puts result % 1 == 0 ? result.to_i : result
rescue ArgumentError => e
  warn e.message
  exit 1
end
