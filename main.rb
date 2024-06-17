require_relative 'parser'

parser = Parser.new('{"foo": true, "bar": [{"a": "foo"}, {"b": [2, 5]}, 2, 3]}')
p parser.parse
