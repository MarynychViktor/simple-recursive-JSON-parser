class Token
  NUMBER = 'number'
  STRING = 'string'
  ARRAY = 'array'
  OBJECT = 'object'
  LEFT_BRACKET = 'left bracket'
  RIGHT_BRACKET = 'right bracket'
  LEFT_SQUARE_BRACKET = 'left square bracket'
  RIGHT_SQUARE_BRACKET = 'right square bracket'
  COLON = 'colon'
  COMMA = 'comma'
  BOOL = 'bool'

  attr_reader :kind, :value

  def initialize(kind, value)
    @kind = kind
    @value = value
  end
end
