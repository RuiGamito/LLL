
highscores = {

  init = function(self)
    scores = {}
    HIGHSCORES_FILENAME = ".highscores"
    -- check if the file exists, create it if not
    if love.filesystem.exists(HIGHSCORES_FILENAME) then
      for line in love.filesystem.lines(".highscores") do
        table.insert(scores, tonumber(line))
      end
    end
  end,

  insert_highscore = function(self, score)
    table.insert(scores, score)
    table.sort(scores)
    print(table.concat(scores,"\n"))
    love.filesystem.write(HIGHSCORES_FILENAME, table.concat(scores,"\n"))
  end,

  get_highscores = function(self)
    return scores
  end

}
