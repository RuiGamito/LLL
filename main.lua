

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



-- Game Cycle Functions

function love.draw()
    --love.graphics.print(text, 400, 300)
	love.graphics.print(text_over, 100, 100)

	love.graphics.setColor(0, 0, 255)
    love.graphics.rectangle("fill", pos_x, pos_y, bsize_x, bsize_y)

    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", block_pos_x, block_pos_y, bsize_x, bsize_y)

    if CheckCollision(pos_x, pos_y, bsize_x, bsize_y, block_pos_x, block_pos_y, bsize_x, bsize_y) then
    	text_over = "OUCH!!!!!!!!"
    	block_pos_x = love.math.random(0, window_w - bsize_x)
    	block_pos_y = love.math.random(0, window_h - bsize_y)
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


-- Movement Functions

function goDown()
	if pos_y + bsize_y < window_h then
		pos_y = pos_y + 10
	end
end

function goUp()

	if pos_y > 0 then
		pos_y = pos_y - 10
	end
end

function goLeft()

	if pos_x > 0 then
		pos_x = pos_x - 10
	end
end

function goRight()
	if pos_x + bsize_x < window_w then
		pos_x = pos_x + 10
	end
end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

