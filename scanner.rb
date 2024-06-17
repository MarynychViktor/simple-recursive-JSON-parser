require_relative 'token'

class Scanner
  def initialize(json_string)
    @json_string = json_string
    @current = 0
    @tokens = []
  end

  def scan
    while !end?
      if curr == '"'
        move
        value = ''
        while curr != '"'
          value += curr
          move
        end
        @tokens << Token.new(Token::STRING, value)
      elsif ('0'..'9').cover?(curr)
        value = curr
        move

        while ('0'..'9').cover?(curr) || curr == '.'
          value += curr
          move
        end
        @tokens << Token.new(Token::NUMBER, value)
        next
      elsif curr == '['
        @tokens << Token.new(Token::LEFT_SQUARE_BRACKET, '[')
      elsif curr == ']'
        @tokens << Token.new(Token::RIGHT_SQUARE_BRACKET, ']')
      elsif curr == '{'
        @tokens << Token.new(Token::LEFT_BRACKET, '{')
      elsif curr == '}'
        @tokens << Token.new(Token::RIGHT_BRACKET, '}')
      elsif curr == ':'
        @tokens << Token.new(Token::COLON, ':')
      elsif curr == ','
        @tokens << Token.new(Token::COMMA, ',')
      elsif curr == 't'
        value = 't' + 3.times.map { move }.join('')
        raise ArgumentError if value != 'true'
        @tokens << Token.new(Token::BOOL, true)
      elsif curr == 'f'
        value = 'f' + 4.times.map { move }.join('')
        raise ArgumentError if value != 'false'
        @tokens << Token.new(Token::BOOL, false)
      elsif curr == ' '
        # Ignore whitespaces
      else
        raise "Unexpected token #{curr}"
      end
      move
    end

    @tokens
  end

  private

  def curr
    return if end?

    @json_string[@current]
  end

  def move
    return if end?

    @current += 1
    @json_string[@current]
  end


  def end?
    @json_string.length <=  @current
  end
end
