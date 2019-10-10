require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_townhall_email(url) # Méthode qui récupère les adresses email de chaque mairie

  page = Nokogiri::HTML(open(url)) # Je créé la variable page qui permet à nokogiri de scrapper mon url
  emails_adress = ' '
  page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |node| # Je récupère l'adresse mail de la mairie d'Avernes avec la fonction .xpath
    return node.text
  end
end

def get_townhall_urls(url) # Méthode qui récupère les url de chaque mairie du Val d'Oise et qui applique la méthode get_townhall_email

  page = Nokogiri::HTML(open(url)) # Je créé la variable page qui permet à nokogiri de scrapper mon url
  hash = {} # Je créé un hash
    page.xpath('//p/a').each do |node| # Je récupère les email avec la fonction .xpath
        html = node["href"]
        html = "http://annuaire-des-mairies.com" + html[1..-1]
        hash[node.text]=get_townhall_email(html)
    end
    puts hash
end

get_townhall_urls('http://annuaire-des-mairies.com/val-d-oise.html')
