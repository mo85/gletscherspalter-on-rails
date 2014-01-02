Game.seed(:date, :opponent) do |s|
  s.date = Time.local(2009, "Oct",18, 8, 10)
  s.opponent = "Albula Devils"
  s.score = 11
  s.opponent_score = 6
  s.location_id = 8
  s.season_id = 2
end

Game.seed(:date, :opponent) do |s|
  s.date = Time.local(2009, "Oct", 25, 8,30)
  s.opponent = "Uusrutscher"
  s.score = 2
  s.opponent_score = 6
  s.location_id = 3
  s.season_id = 2
end

Game.seed(:date, :opponent) do |s| 
  s.date = Time.local(2009, "Nov", 8, 8,15)
  s.opponent = "Dukla VBZ"
  s.location_id = 2
  s.season_id = 2
end

Game.seed(:date, :opponent) do |s| 
  s.date = Time.local(2009, "Nov", 14, 9,45)
  s.opponent = "Bone Crashers"
  s.location_id = 6
  s.season_id = 2
end

Game.seed(:date, :opponent) do |s| 
  s.date = Time.local(2009, "Nov", 21, 9, 45)
  s.opponent = "Albula Devils"
  s.location_id = 6
  s.season_id = 2
end

Game.seed(:date, :opponent) do |s| 
  s.date = Time.local(2009, "Nov", 26, 21, 30)
  s.opponent = "Bone Crashers"
  s.location_id = 8
  s.season_id = 2
end

Game.seed(:date, :opponent) do |s| 
  s.date = Time.local(2009, "Nov", 28, 21, 15)
  s.opponent = "Sagmählfäger"
  s.location_id = 2
  s.season_id = 2
end

Game.seed(:date, :opponent) do |s| 
  s.date = Time.local(2009, "Nov", 29, 8)
  s.opponent = "Sagmählfäger"
  s.location_id = 1
  s.season_id = 2
end

