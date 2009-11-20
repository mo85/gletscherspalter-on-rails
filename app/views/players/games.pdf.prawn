pdf.text "Gletscherspalter: Spielplan von #{@player.name}", :size => 22, :style => :bold

games = @player.games.map do |game|
  [
    game.name,
    l(game.date, :format => :default),
    game.rink.name,
    game.result
  ]
end

pdf.move_down(25)

pdf.table games, :border_style => :grid,
  :row_colors => ["FFFFFF", "DDDDDD"],
  :headers => ["Spiel", "Zeit", "Ort", "Resultat"]
  
  
pdf.move_down(20)

pdf.text "Anzahl Spiele: #{games.size}", :size => 14, :style => :bold