require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_townhall_email(url) # Méthode qui récupère les adresses email de chaque mairie
  page = Nokogiri::HTML(open(url)) # Je créé la variable page qui permet à nokogiri de scrapper mon url
  page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |node| # Je récupère l'adresse mail de la mairie d'Avernes avec la fonction .xpath
    return node.text
  end
end

def get_townhall_urls(url) # Méthode qui récupère les url de chaque mairie du Val d'Oise et qui applique la méthode get_townhall_email

  page = Nokogiri::HTML(open(url)) # Je créé la variable page qui permet à nokogiri de scrapper mon url
  townUrls = {} # Objet qui contiendra mes urls

  # Je récupère les balises a de la page
  page.xpath('//p/a').each do |a|
    href = a["href"] # Je récupère le lien dans la balise a
    href = href[1..-1] # J'enlève le ./ au début de l'url (lien relatif)
    link = "http://annuaire-des-mairies.com" + href # Je créé la variable link qui correspond à l'url de la ville
    email = get_townhall_email(link) # Je créé la variable email qui correspond à l'email de la ville
    townUrls[a.text] = email # J'ajoute une nouvelle valeur dans townUrls (clé : ville; valeur : email)
  end
  return townUrls
end

urls = get_townhall_urls('http://annuaire-des-mairies.com/val-d-oise.html') # J'affiche ma méthode avec l'url donné

urls.each_pair {|key, value|
  puts "#{key} - #{value}"
}
