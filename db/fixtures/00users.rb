User.seed(:login) do |u|
  u.id = 1
  u.lastname = "Odermat"
  u.firstname = "Mark"
  u.login = "mark.odermatt"
  u.email = "mark_odermatt@bluewin.ch"
  u.is_admin = true
  u.hashed_password = User.encrypted_password('secret', "aykso278sdfeiyxiu")
  u.salt = "aykso278sdfeiyxiu"
end

User.seed(:login) do |u|
  u.id = 2
  u.lastname = "Buesser"
  u.firstname = "Patrick"
  u.login = "patrick.buesser"
  u.email = "p.buesser@luetze.ch"
  u.is_admin = true
  u.hashed_password = User.encrypted_password('secret', "yloi4645aelyl")
  u.salt = "yloi4645aelyl"
end

User.seed(:login) do |u|
  u.id = 3
  u.lastname = "Franze"
  u.firstname = "Marcel"
  u.login = "marcel.franze"
  u.email = "marcel.franze@greenmail.ch"
  u.is_admin = true
  u.hashed_password = User.encrypted_password('secret', "yko894ajoilkakjyxz")
  u.salt = "yko894ajoilkakjyxz"
end

User.seed(:login) do |u|
  u.id = 4
  u.lastname = "Maechler"
  u.firstname = "Roman"
  u.login = "roman.maechler"
  u.email = "r.maechler@rkb.ch"
  u.hashed_password = User.encrypted_password('secret', "yueoiyxe45wilyo")
  u.salt = "yueoiyxe45wilyo"
end

User.seed(:login) do |u|
  u.id = 5
  u.lastname = "Maechler"
  u.firstname = "Pascal"
  u.login = "pascal.maechler"
  u.hashed_password = User.encrypted_password('secret', "oilalo4wyla4kl")
  u.salt = "oilalo4wyla4kl"
end

User.seed(:login) do |u|
  u.id = 6
  u.lastname = "Janser"
  u.firstname = "Michael"
  u.login = "michael.janser"
  u.email = "m_janser@gmx.ch"
  u.hashed_password = User.encrypted_password('secret', "5as85d5g")
  u.salt = "5as85d5g"
end