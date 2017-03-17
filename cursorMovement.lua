-- Cursor Movement 

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

