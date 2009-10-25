# KEK Küsnacht
Address.seed(:street, :city, :zip) do |s|
  s.id = 1
  s.street = "Johannisburgstrasse"
  s.number = "11"
  s.city = "Küsnacht ZH"
  s.zip = 8700
  s.location_id = 1
end

# Wetzikon
Address.seed(:street, :city, :zip) do |s|
  s.id = 2
  s.street = "Rapperswilerstrasse"
  s.number = "63"
  s.city = "Wetzikon"
  s.zip = 8620
  s.location_id = 2
end

# Herti Zug
Address.seed(:street, :city, :zip) do |s|
  s.id = 3
  s.street = "General-Guisan-Strasse"
  s.number = "2"
  s.city = "Zug"
  s.zip = 6300
  s.location_id = 3
end

# Dolder
Address.seed(:street, :city, :zip) do |s|
  s.id = 4
  s.street = "Adlisbergstrasse"
  s.number = "36"
  s.city = "Zürich"
  s.zip = 8044
  s.location_id = 4
end

# Heuried
Address.seed(:street, :city, :zip) do |s|
  s.id = 5
  s.street = "Wasserschöpfi"
  s.number = "71"
  s.city = "Zürich"
  s.zip = 8055
  s.location_id = 5
end

# Effretikon
Address.seed(:street, :city, :zip) do |s|
  s.id = 6
  s.street = "Sportplatzstrasse"
  s.number = "4"
  s.city = "Effretikon"
  s.zip = 8307
  s.location_id = 6
end

# Dübendorf
Address.seed(:street, :city, :zip) do |s|
  s.id = 8
  s.street = "Hermikonstrasse"
  s.number = "68"
  s.city = "Dübendorf"
  s.zip = 8600
  s.location_id = 9
end

# Bäretswil
Address.seed(:street, :city, :zip) do |s|
  s.id = 9
  s.street = "Schürlistrasse"
  s.city = "Bäretswil"
  s.zip = 8344
  s.location_id = 8
end

# Stall Stube Maur
Address.seed(:street, :city, :zip) do |s|
  s.id = 7
  s.street = "Rellikonstrasse"
  s.number = "128"
  s.city = "Maur"
  s.zip = 8124
  s.location_id = 7
end