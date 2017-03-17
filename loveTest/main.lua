

windowWidth = love.graphics.getWidth()
windowHeigth = love.graphics.getHeight()

circleRadius = 10
initialPosX = windowWidth/2
initialPosY = windowHeigth/2
circleSpeed = 300




function love.load()
  posX = initialPosX
  posY = initialPosY
end

function love.update(dt)
  handleInput(dt)
end


function love.draw()
  love.graphics.print("Hello World", 400, 300)
  love.graphics.circle("fill", posX, posY, circleRadius)
end





-- Keyboard Handling
function handleInput(dt)
  if love.keyboard.isDown("up") then
    posY = posY - circleSpeed * dt
    if posY - circleRadius < 0 then
      posY = circleRadius
    end
  elseif love.keyboard.isDown("down") then
    posY = posY + circleSpeed * dt
    if posY + circleRadius > windowHeigth then
      posY = windowHeigth - circleRadius
    end
  elseif love.keyboard.isDown("right") then
    posX = posX + circleSpeed * dt
    if posX + circleRadius > windowWidth then
      posX = windowWidth - circleRadius
    end
  elseif love.keyboard.isDown("left") then
    posX = posX - circleSpeed * dt
    if posX - circleRadius < 0 then
      posX = circleRadius
    end
  end
end
