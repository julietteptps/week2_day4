require 'rubygems'
require 'nokogiri'
require 'open-uri'

def crypto_scrapping(url) # Je créé une méthode "crypto_scrapping" avec comme paramètre la variable url


	page = Nokogiri::HTML(open(url)) # Je créé la variable page qui permet à nokogiri de scrapper mon url
	crypto_value = [] # Je créé un array crypto_value
	crypto_name = [] # Je créé un deuxième array crypto_name
	crypto_hash = {} # Je créé un hash crypto_hash

  #Je vais chercher les noms des cryptomonnaies avec la fonction xpath puis je les ajoute à mon tableau crypto_name
		page.xpath('//tr/td[@class = "no-wrap currency-name"]/a').each do |node|
			crypto_name << node.text
		end

    #Je fais pareil avec les valeurs des cryptomonnaies puis je les ajoute à mon tableau crypto_value
		page.xpath('//tr/td/a[@class = "price"]').each do |node|
			crypto_value << node.text
		end
		#crypto_hash = crypto_name.zip(crypto_value) # J'utilise la fonction .zip qui permet de faire suivre un nom et une valeur de cryptomonnaie à la suite
   #puts crypto_hash
   puts crypto_name + crypto_value

end


crypto_scrapping('https://coinmarketcap.com/all/views/all/') # J'affiche ma méthode avec l'url donné
