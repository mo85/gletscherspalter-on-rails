games_table_entries = @events.map do |event|
  [
    event.name,
    l(event.date, :format => :default),
    event.locality,
  ]
end

cell_options = { :font_size => 11, :font_style => :bold }

pdf.table(games_table_entries, :border_style => :grid,
  :row_colors => ["cfddff", "f0f0f0"],
  :headers => [ Prawn::Table::Cell.new(cell_options.merge(:text => "Anlass")),
                Prawn::Table::Cell.new(cell_options.merge(:text => "Zeit")),
                Prawn::Table::Cell.new(cell_options.merge(:text => "Ort"))
              ], 
  :header_text_color => "FFFFFF",
  :header_color => "051659"
)