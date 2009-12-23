if @player
  pdf.text "Gletscherspalter: Termine von #{@player.name}", :size => 22, :style => :bold
else
  pdf.text "Spielplan der Gletscherpalter", :size => 22, :style => :bold 
end

pdf.move_down(25)

if @events.empty?
  pdf.text "Bisher wurden keine Termine gebucht."
else
  events_table_entries = @events.map do |event|
    [
      event.name,
      l(event.date, :format => :default),
      event.locality,
      event.result
    ]
  end

  cell_options = { :font_size => 11, :font_style => :bold }

  pdf.table(events_table_entries, :border_style => :grid,
    :row_colors => ["cfddff", "f0f0f0"],
    :headers => [ Prawn::Table::Cell.new(cell_options.merge(:text => "Anlass")), 
                  Prawn::Table::Cell.new(cell_options.merge(:text => "Zeit")), 
                  Prawn::Table::Cell.new(cell_options.merge(:text => "Ort")), 
                  Prawn::Table::Cell.new(cell_options.merge(:text => "Resultat"))
                ], 
    :header_text_color => "FFFFFF",
    :header_color => "051659",
    :align => { 3 => :center }
  )
  pdf.move_down(20)
  
  pdf.text "Anzahl Spiele: #{events.games.size}", :size => 14, :style => :bold
end
