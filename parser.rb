require_relative 'scanner'
require_relative 'token'

class Parser
  def initialize(json_string)
    @json_string = json_string
    @tokens ||= Scanner.new(json_string).scan
    @current = 0
  end

  def parse
    parse_json
  end

  private

  def parse_json
    if token.kind == Token::LBRACKET
      move
      parse_object
    elsif token.kind == Token::LSBRACKET
      move
      parse_array
    elsif token.kind == Token::NUMBER
      token.value.to_i.tap { move }
    elsif token.kind == Token::STRING
      token.value.tap { move }
    elsif token.kind == Token::BOOL
      token.value.tap { move }
    end
  end

  def parse_object
    obj = {}
    properties = []
    properties << parse_property

    while token.kind == Token::COMMA
      consume(Token::COMMA)
      properties << parse_property
    end

    consume(Token::RBRACKET)
    properties.each {|prop| obj[prop[:key]] = prop[:value]}

    obj
  end

  def parse_property
    key = consume(Token::STRING).value
    consume(Token::COLON)
    value = parse_json
    {key:, value:}
  end

  def parse_array
    items = []
    items << parse_json

    while token.kind == Token::COMMA
      consume(Token::COMMA)
      items << parse_json
    end

    consume(Token::RSBRACKET)

    items
  end

  def consume(kind)
    if token.kind != kind
      raise "Unmatched kind expected #{kind} got #{token.inspect}"
    end

    token.tap { move }
  end

  def token
    @tokens[@current]
  end

  def move
    @current += 1
  end

  def end?
    @current >= @tokens.length
  end

  def tokens
    @tokens ||= Scanner.new(@json_string).scan
  end
end