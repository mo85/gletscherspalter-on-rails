User.seed(:login) do |u|
  u.id = 1
  u.lastname = "Odermat"
  u.firstname = "Mark"
  u.login = "mark.odermatt"
  u.email = "mark_odermatt@bluewin.ch"
  u.is_admin = true
  u.hashed_password = "34242cde00981d1beb333d1c99c069e2ce865d56"
  u.salt = "aykso278sdfeiyxiu"
end

User.seed(:login) do |u|
  u.id = 2
  u.lastname = "Buesser"
  u.firstname = "Patrick"
  u.login = "patrick.buesser"
  u.email = "p.buesser@luetze.ch"
  u.is_admin = true
  u.hashed_password = "34242cde00981d1beb333d1c99c069e2ce865d56"
  u.salt = "yloi4645aelyl"
end

User.seed(:login) do |u|
  u.id = 3
  u.lastname = "Franze"
  u.firstname = "Marcel"
  u.login = "marcel.franze"
  u.email = "marcel.franze@greenmail.ch"
  u.is_admin = true
  u.hashed_password = "34242cde00981d1beb333d1c99c069e2ce865d56"
  u.salt = "yko894ajoilkakjyxz"
end

User.seed(:login) do |u|
  u.id = 4
  u.lastname = "Maechler"
  u.firstname = "Roman"
  u.login = "roman.maechler"
  u.email = "r.maechler@rkb.ch"
  u.hashed_password = "34242cde00981d1beb333d1c99c069e2ce865d56"
  u.salt = "yueoiyxe45wilyo"
end

User.seed(:login) do |u|
  u.id = 5
  u.lastname = "Maechler"
  u.firstname = "Pascal"
  u.login = "pascal.maechler"
  u.hashed_password = "34242cde00981d1beb333d1c99c069e2ce865d56"
  u.salt = "oilalo4wyla4kl"
end

User.seed(:login) do |u|
  u.id = 6
  u.lastname = "Janser"
  u.firstname = "Michael"
  u.login = "michael.janser"
  u.email = "m_janser@gmx.ch"
  u.hashed_password = "34242cde00981d1beb333d1c99c069e2ce865d56"
  u.salt = "5as85d5g"
end