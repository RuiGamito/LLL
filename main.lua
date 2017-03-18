
require "cursorMovement"
require "hud"

pos_x = 100
pos_y = 200
bsize_x = 50
bsize_y = 50

block_pos_x = 500
block_pos_y = 500

window_w = love.graphics.getWidth()
window_h = love.graphics.getHeight()

shape_collider = love.physics.newRectangleShape(pos_x, pos_y, bsize_x, bsize_y)

-- Game Cycle Functions


function love.load()

  -- initialize hud stuff
  hud:init()
  hud:toggle_score(true)
  hud:toggle_timer(true)
  hud:set_session_time(60)
  hud:set_start_time()

end

function love.draw()

    hud:draw()

    love.graphics.setColor(0, 0, 255)
    love.graphics.rectangle("fill", pos_x, pos_y, bsize_x, bsize_y)

    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", block_pos_x, block_pos_y, bsize_x, bsize_y)

    if CheckCollision(pos_x, pos_y, bsize_x, bsize_y, block_pos_x, block_pos_y, bsize_x, bsize_y) then
    	block_pos_x = love.math.random(0, window_w - bsize_x)
    	block_pos_y = love.math.random(30, window_h - bsize_y)

      -- If there's a collision with the white box, increase the score
      hud:increase_score(1)
    end
end

function love.update()

	if love.keyboard.isDown( "down" ) then
   		text = "The DOWN key is held down!"
   		goDown()
    elseif love.keyboard.isDown( "up" ) then
   		text = "The UP key is held down!"
   		goUp()
    elseif love.keyboard.isDown( "left" ) then
   		text = "The LEFT key is held down!"
   		goLeft()
    elseif love.keyboard.isDown( "right" ) then
   		text = "The RIGHT key is held down!"
   		goRight()
    else
    	text = "waiting for a press ;)"
	end

	shape_collider = love.physics.newRectangleShape(pos_x, pos_y, bsize_x, bsize_y)

end



function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

