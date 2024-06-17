class Token
  NUMBER = 'number'
  STRING = 'string'
  ARRAY = 'array'
  OBJECT = 'object'
  LBRACKET = 'left bracket'
  RBRACKET = 'right bracket'
  LSBRACKET = 'left square bracket'
  RSBRACKET = 'right square bracket'
  COLON = 'colon'
  COMMA = 'comma'
  BOOL = 'bool'

  attr_reader :kind, :value

  def initialize(kind, value)
    @kind = kind
    @value = value
  end
end
