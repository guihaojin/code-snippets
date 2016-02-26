# Scheme interpreter in Ruby

def parse(program)
  read_from_tokens(tokenize(program))
end

def tokenize(chars)
  chars.gsub("(", " ( ").gsub(")", " ) ").split
end

def read_from_tokens(tokens)
  if tokens.empty?
    raise "no token"
  end
  token = tokens.shift
  if token == "("
    list = []
    while tokens.first != ")" do
      list << read_from_tokens(tokens)
    end
    tokens.shift
    list
  elsif token == ")"
    raise "unexpected )"
  else
    atom(token)
  end
end

def atom(token)
  if /^[-+]?\d+$/ =~ token
    token.to_i
  elsif /^[-+]?\d+\.\d+$/ =~ token
    token.to_f
  else
    token.to_sym
  end
end

def standard_env
  env = {}
  operators = [:+, :-, :*, :/, :>, :<, :>=, :<=, :==]
  operators.each do |operator|
    env[operator] = lambda { |x, y| x.send(operator, y) }
  end
  env.update({
    cons: lambda { |x, y| [x] + y },
    car: lambda { |x| x[0] },
    cdr: lambda { |x| x[1..-1] },
    append: lambda { |x, y| x + y }
    })
  env
end

def eval(x, env = standard_env)
  return env[x] if x.is_a? Symbol
  return x if !x.is_a? Array
  case x[0]
  when :quote
    x[1..-1]
  when :if
    _, condition, a, b = x
    eval(eval(condition, env) ? a : b)
  when :define
    env[x[1]] = eval(x[2], env)
  else
    evals = x.map { |e| eval(e, env) }
    evals[0].call(*evals[1..-1])
  end
end

program = "(+ (* 3 2) 1))"

puts eval(parse(program))
