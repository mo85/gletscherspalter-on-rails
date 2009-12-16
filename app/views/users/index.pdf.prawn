pdf.text "Mitgliederliste der Gletscherspalter", :size => 22, :style => :bold

pdf.move_down(25)

if @users.empty?
  pdf.text "Momentan sind keine Mitglieder registriert."
else
  users = @users.collect do |u|
    [ u.name,
      u.address,
      u.location,
      u.phone, 
      u.mobile,
      u.email,
    ]
  end

  cell_options = { :font_size => 11, :font_style => :bold }

  pdf.table(users, :border_style => :grid,
     :row_colors => ["FFFFFF", "DDDDDD"],
     :headers => [
       Prawn::Table::Cell.new(cell_options.merge(:text => "Name")),
       Prawn::Table::Cell.new(cell_options.merge(:text => "Adresse")),
       Prawn::Table::Cell.new(cell_options.merge(:text => "Ort")),
       Prawn::Table::Cell.new(cell_options.merge(:text => "Telefon")),
       Prawn::Table::Cell.new(cell_options.merge(:text => "Mobile")),
       Prawn::Table::Cell.new(cell_options.merge(:text => "Email"))
     ]
  )
  
  pdf.move_down(25)
  
  pdf.text "Total #{@users.size} Mitglieder #{active_players_count}", :size => 14, :style => :bold
end