-- BLOCK = {XX, YY, WIDTH, HEIGHT, CRUSH_TRIGGER, STATUS}
-- STATUS = 0 -> No change
--          1 -> Crushing
--          2 -> Receding

TILE_SIZE = 50
BLOCK_WIDTH = 200
PLAYER_SAFE = 0
PLAYER_CRUSHED = 1

function spawnBlock()
  return {800, 0, BLOCK_WIDTH, TILE_SIZE, love.math.random(0,1000)+500, 0}
end

function drawPlayer()
  love.graphics.setColor(100, 100, 255)
  love.graphics.rectangle("fill", player[1], player[2], player[3], player[4])
  --love.graphics.print("STATUS:" .. PLAYER_STATUS, 10, 10)
end

function drawPoints()
  love.graphics.setColor(255, 0, 0)
  love.graphics.print("Crushes avoided: " .. PLAYER_POINTS, 10, 100)
end

function checkPlayerCrush(block)
  if block[1] < player[1]+player[3] and
     block[1] + block[3] > player[1] and
     block[2] + block[4] > player[2] then
       return PLAYER_CRUSHED
  else
       return PLAYER_SAFE
  end
end

function resetGame()
  -- create the block table
  blocks = {}
  table.insert(blocks, spawnBlock())
  num_blocks = 1

  -- Add the player
  player = {300, 550, TILE_SIZE, TILE_SIZE}
  PLAYER_STATUS = PLAYER_SAFE

  -- Add PLAYER_POINTS
  PLAYER_POINTS = 0
end

function love.load()
  resetGame()
end


function love.update(dt)

  if PLAYER_STATUS == PLAYER_CRUSHED then
    if love.keyboard.isDown("space")  then
      resetGame()
    else
      return
    end
  end

  -- evaluate if head block is completely out of the screen (to the left)
  -- and if it is, remove it
  local first = blocks[1]
  if first[1]+first[3] < 0 then
    table.remove(blocks,1)
    num_blocks = num_blocks - 1
  end

  -- evaluate if tail block is completely on the screen (on the right)
  -- and if it is, spawn a new one
  local last = blocks[num_blocks]
  if last[1]+last[3] < 800 then
    table.insert(blocks,spawnBlock())
    num_blocks = num_blocks + 1
  end

  -- decrease the x pos of the blocks, that is, make them move to the left
  -- also, decrease block crush_trigger , and if <= 0, CRUSH!!!
  for _, block in ipairs(blocks) do
      block[1] = block[1] - 1.5

      local STATUS = block[6]
      local LENGTH = block[4]

      -- if crush_trigger is over and status is 0
      if block[5] <= 0 and STATUS == 0 then
        -- change the status to CRUSHING on the block
        block[6] = 1
      elseif STATUS == 1 then -- if the block is crushing
        -- keep crushing if the block didn't hit the bottom
        if LENGTH < 800 then
          block[4] = block[4] + 200
          PLAYER_STATUS = checkPlayerCrush(block)
        else
          -- otherwise change status to RECEDING, on the block
          -- and a point ;)
          PLAYER_POINTS = PLAYER_POINTS + 1
          block[6] = 2
        end
      elseif STATUS == 2 then -- if the block is receding
        if LENGTH > 50 then
          block[4] = block[4] - 50
        else
          -- change status to NO CHANGE on the block
          block[6] = 0
          -- reset the crush trigger
          block[5] = love.math.random(0,1000)+500
        end
      else -- simply decrease the CRUSH_TRIGGER
        block[5] = block[5] - 4
      end
  end -- for

  -- create some keyboard events to control the player
  if love.keyboard.isDown("right") then
    if player[1]+10 > 750 then
      player[1] = 750
    else
      player[1] = player[1] + 10
    end
  elseif love.keyboard.isDown("left") then
    if player[1]-10 < 0 then
      player[1] = 0
    else
      player[1] = player[1] - 10
    end
  end
end

function love.draw()
  for _, block in ipairs(blocks) do
      love.graphics.setColor(255 - block[5]/4, 100, 0)
      love.graphics.rectangle("fill", block[1], block[2], block[3], block[4])
  end

  drawPlayer()
  drawPoints()
end
