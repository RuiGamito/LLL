require "hud"

pos_x = 100
pos_y = 200
bsize_x = 50
bsize_y = 50

block_pos_x = 500
block_pos_y = 500

window_w = love.graphics.getWidth()
window_h = love.graphics.getHeight()

hud_height = 30

shape_collider = love.physics.newRectangleShape(pos_x, pos_y, bsize_x, bsize_y)


-- Game states

STATE_MENU      = 1
STATE_PLAY      = 2
STATE_GAME_OVER = 3

-- Game Cycle Functions

function love.load()

  -- initialize HUD
  hud:init()
  hud:set_hud_height(hud_height)

  changeToState(STATE_MENU)
end

function love.draw()
  hud:draw()

  if GAME_STATE == STATE_PLAY then
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
end

function love.update()
  if hud:timer_over() and GAME_STATE ~= STATE_GAME_OVER then
    changeToState(STATE_GAME_OVER)
  end

  if GAME_STATE == STATE_MENU then
    if love.keyboard.isDown( "space" ) then
      changeToState(STATE_PLAY)
    end
  elseif GAME_STATE == STATE_PLAY then
    if love.keyboard.isDown( "down" ) then
      goDown()
    elseif love.keyboard.isDown( "up" ) then
   		goUp()
    elseif love.keyboard.isDown( "left" ) then
   		goLeft()
    elseif love.keyboard.isDown( "right" ) then
   		goRight()
    end
  elseif GAME_STATE == STATE_GAME_OVER then
    if love.keyboard.isDown( "space" ) then
      changeToState(STATE_PLAY)
    end
	end

	shape_collider = love.physics.newRectangleShape(pos_x, pos_y, bsize_x, bsize_y)

end

function gameStart()
  -- initialize hud stuff
  hud:set_session_time(10)
  hud:toggle_score(true)
  hud:toggle_timer(true)
end

function changeToState(state)

  if state == STATE_MENU then
    hud:message("Press 'space' to start")
  elseif state == STATE_PLAY then
    hud:message("")
    hud:reset()
    gameStart()
  elseif state == STATE_GAME_OVER then
    print("Set game over message")
    hud:message("GAME OVER!! Press 'space' to replay")
  end

  GAME_STATE = state
end

-- Cursor Movement

function goDown()
  if pos_y + bsize_y < window_h then
    pos_y = pos_y + 10
  end
end

function goUp()
  if pos_y > HUD_HEIGHT then
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

-- Collision detection

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end
