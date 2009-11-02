Game.seed(:date, :opponent) do |s|
  s.date = Time.parse("2009/10/18 - 08:10")
  s.opponent = "Albula Devils"
  s.score = 11
  s.opponent_score = 6
  s.rink_id = 8
  s.season_id = 1
end

Game.seed(:date, :opponent) do |s|
  s.date = Time.parse("2009/10/25 - 08:30")
  s.opponent = "Uusrutscher"
  s.score = 2
  s.opponent_score = 6
  s.rink_id = 3
  s.season_id = 1
end

Game.seed(:date, :opponent) do |s| 
  s.date = Time.parse("2009/11/08 - 08:15")
  s.opponent = "Dukla VBZ"
  s.rink_id = 2
  s.season_id = 1
end

Game.seed(:date, :opponent) do |s| 
  s.date = Time.parse("2009/11/14 - 09:45")
  s.opponent = "Bone Crashers"
  s.rink_id = 6
  s.season_id = 1
end

Game.seed(:date, :opponent) do |s| 
  s.date = Time.parse("2009/11/21 - 09:45")
  s.opponent = "Albula Devils"
  s.rink_id = 6
  s.season_id = 1
end

Game.seed(:date, :opponent) do |s| 
  s.date = Time.parse("2009/11/26 - 21:30")
  s.opponent = "Bone Crashers"
  s.rink_id = 8
  s.season_id = 1
end

Game.seed(:date, :opponent) do |s| 
  s.date = Time.parse("2009/11/28 - 21:15")
  s.opponent = "Sagmählfäger"
  s.rink_id = 2
  s.season_id = 1
end

Game.seed(:date, :opponent) do |s| 
  s.date = Time.parse("2009/11/29 - 08:00")
  s.opponent = "Sagmählfäger"
  s.rink_id = 1
  s.season_id = 1
end

