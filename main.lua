
require "cursorMovement"

pos_x = 100
pos_y = 200
bsize_x = 50
bsize_y = 50

block_pos_x = 500
block_pos_y = 500

window_w = love.graphics.getWidth()
window_h = love.graphics.getHeight()

text = "Press a cursor key"
text_over = ""
shape_collider = love.physics.newRectangleShape(pos_x, pos_y, bsize_x, bsize_y)

score = 0
session_time = 60 -- 60 seconds to get the highest score


-- Game Cycle Functions


function love.load()

  -- get the initial time of the session
  start_time = love.timer.getTime()


end

function love.draw()
    --love.graphics.print(text, 400, 300)
    love.graphics.print(text_over, 100, 100)

    -- Print the points
    love.graphics.print("Score: " .. score, 10, 10)

    -- Print the timer
    love.graphics.print("Timer: " .. string.format("%.0f",session_time - (love.timer.getTime() - start_time)), window_w-100, 10)


    love.graphics.setColor(0, 0, 255)
    love.graphics.rectangle("fill", pos_x, pos_y, bsize_x, bsize_y)

    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", block_pos_x, block_pos_y, bsize_x, bsize_y)

    if CheckCollision(pos_x, pos_y, bsize_x, bsize_y, block_pos_x, block_pos_y, bsize_x, bsize_y) then
    	text_over = "OUCH!!!!!!!!"
    	block_pos_x = love.math.random(0, window_w - bsize_x)
    	block_pos_y = love.math.random(0, window_h - bsize_y)

      -- If there's a collision with the white box, increase the score
      score = score + 1

    else
    	text_over = ""
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

