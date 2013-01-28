incoming_data = <<EOF
But I must 1 explain to you 3444 how all http://www.ukr.net/news/politika.html this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great 444 explorer of the truth, the master-builder of 11134 human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know 0 how to pursue 334 pleasure rationally encounter consequences that are 111 extremely painful. Nor again 2 is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which 3444 toil and pain can procure him some great 234234 234 pleasure. http://www.teletrade.com.ua/novice/promo?utm_source=ukr&utm_medium=kak&utm_campaign=silki to take a trivial example, which of us ever undertakes laborious physical exercise, http://orakul.com/horoscope/astro/general/today/lion.html except to obtain 11 some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure 312 that has 777 no annoying consequences, or one who avoids a pain that produces no resultant pleasure?
EOF

def _words(str)
	str.split(' ').find_all{|w| !w.match(/^\w+$/).nil?}
end

#1
def longest_words(str)
	words = _words(str).sort{|a, b| a.size <=> b.size}
	words.find_all{|w| w.size == words.last.size}
end

#2
def url_replacer(str)
	str.gsub(/(http\:\/\/[^\/]+)(\/[^\/ ]+)*/, '\1')	
end


#3
def num_count(str)
	str.scan(/\d+/).sort{|a, b| a.size <=> b.size}.last
end

#4
def words_count(str)
	h = Hash.new(0)
	_words(str).each{|s| h.store(s, h[s]+1)}
	h
end

p longest_words(incoming_data)
p url_replacer(incoming_data)
p num_count(incoming_data)
p words_count(incoming_data)
