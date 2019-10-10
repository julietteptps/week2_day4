require 'rubygems'
require 'nokogiri'
require 'open-uri'

def crypto_scrapping(url) # Je créé une méthode "crypto_scrapping" avec comme paramètre la variable url

	page = Nokogiri::HTML(open(url)) # Je créé la variable page qui permet à nokogiri de scrapper mon url

  # Je vais chercher les noms des cryptomonnaies avec la fonction xpath puis je les ajoute à mon tableau crypto_name
  crypto_name = []
  page.xpath('//tr/td[@class = "no-wrap currency-name"]/a').each do |node|
		crypto_name << node.text
	end

  # Je fais pareil avec les valeurs des cryptomonnaies puis je les ajoute à mon tableau crypto_value
  crypto_value = []
  page.xpath('//tr/td/a[@class = "price"]').each do |node|
		crypto_value << node.text
	end

  # J'associe les deux tableaux (la première valeur du tableau de nom avec la première valeur du tableau de prix, la deuxième et ainsi de suite)
  crypto_linked = crypto_name.zip(crypto_value)

  # crypto_linked = [
  #   ["Bitcoin", "9000"],
  #   ["Ethereum", "300"],
  #   ...
  # ]

  return crypto_linked
end

arr_crypto = crypto_scrapping('https://coinmarketcap.com/all/views/all/')

# Pour chaque crypto ...
arr_crypto.each do |crypto|
  # Je calcul et affiche les valeurs
  name = crypto[0]
  price = crypto[1]
  puts "#{name} - #{price}"
end
