require 'benchmark/ips'

def slow(&block)
  block.call
end

def slow2(&block)
  yield
end

def slow3(&block)

end

def slow4
  Proc.new.call
end

def fast
  yield
end

def fast_with_guard
  yield if block_given?
end


Benchmark.ips do |x|
  x.report('block.call') { slow { 1 + 1 } }
  x.report('block + yield') { slow2 { 1 + 1 } }
  x.report('block argument') { slow3 { 1 + 1 } }
  x.report('Proc.new.call') { slow4 { 1 + 1 } }
  x.report('yield') { fast { 1 + 1 } }
  x.report('yield + block_given?') { fast_with_guard { 1 + 1 } }
  x.compare!
end
