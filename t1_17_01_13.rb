require 'date'

def today
	%w{Sunday Monday Tuesday Wednesday Thursday Friday Saturday}[Date.today.wday]
end

class A
	def to_modify
		puts "print from not modified method"
	end
end

def modify(klass=nil, method=nil, &b)
	return p 'Code is not provided' unless block_given?
	return p 'Please provide your class and method\'s name' unless klass && method
	return p 'Class is not correct' unless klass.kind_of? Class
	return p 'Method is not defined' unless klass.method_defined? method
	klass.send :define_method, method, &b
end

p today
A.new.to_modify
modify(A, :to_modify){puts "print from modified method"}
A.new.to_modify

