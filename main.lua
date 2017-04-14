
pos_x = 500
pos_y = 500
bsize_x = 50
bsize_y = 50

block_pos_x = 750
block_pos_y = 0

block_size_x = 100
block_size_y = 50

local blocks = {}
local num_blocks = 0

-- BLOCK = {XX, YY, WIDTH, HEIGHT, CRUSH_TRIGGER, STATUS}
-- STATUS = 0 -> No change
--          1 -> Crushing
--          2 -> Receding

function spawnBlock()
  return {800, 0, block_size_x, block_size_y, love.math.random(0,1000)+500, 0}
end


function love.load()
  local b1 = spawnBlock()
  table.insert(blocks, b1)
  num_blocks = 1
end


function love.update(dt)
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
          block[4] = block[4] + 80
        else
          -- otherwise change status to RECEDING, on the block
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
end

function love.draw()
  for _, block in ipairs(blocks) do
      love.graphics.setColor(255 - block[5]/4, 100, 0)
      love.graphics.rectangle("fill", block[1], block[2], block[3], block[4])
  end
  --love.graphics.setColor(0, 0, 255)
  --love.graphics.rectangle("fill", pos_x, pos_y, bsize_x, bsize_y)
  -- love.graphics.print("blocks " .. num_blocks, 10, 10)
end
