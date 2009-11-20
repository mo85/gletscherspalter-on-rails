if @player
  pdf.text "Gletscherspalter: Spielplan von #{@player.name}", :size => 22, :style => :bold
else
  pdf.text "Saisonplan der Gletscherpalter", :size => 22, :style => :bold 
end

games_table_entries = games.map do |game|
  [
    game.name,
    l(game.date, :format => :default),
    game.rink.name,
    game.result
  ]
end

pdf.move_down(25)

cell_options = { :font_size => 11, :font_style => :bold }

pdf.table(games_table_entries, :border_style => :grid,
  :row_colors => ["cfddff", "f0f0f0"],
  :headers => [ Prawn::Table::Cell.new(cell_options.merge(:text => "Spiel")), 
                Prawn::Table::Cell.new(cell_options.merge(:text => "Zeit")), 
                Prawn::Table::Cell.new(cell_options.merge(:text => "Ort")), 
                Prawn::Table::Cell.new(cell_options.merge(:text => "Resultat"))
              ], 
  :header_text_color => "FFFFFF",
  :header_color => "093ea8"
)
pdf.move_down(20)

pdf.text "Anzahl Spiele: #{games.size}", :size => 14, :style => :bold