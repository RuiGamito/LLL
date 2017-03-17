

windowWidth = love.graphics.getWidth()
windowHeigth = love.graphics.getHeight()

circleRadius = 10
initialPosX = windowWidth/2
initialPosY = windowHeigth/2
circleSpeed = 300

rectangleWidth = 100
rectangleHeigth = 20
rectangleSpeed = 500



-- Game Cycle
function love.load()
  circlePosX = initialPosX
  circlePosY = initialPosY
  rectanglePosX = rectangleWidth/2
  rectanglePosY = windowHeigth/2
end

function love.update(dt)
  handleInput(dt)
  moveRectangle(dt)
end


function love.draw()
  love.graphics.print("Hello World", 400, 300)

  love.graphics.setColor(255, 255, 255)
  love.graphics.circle("fill", circlePosX, circlePosY, circleRadius)

  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle("fill", rectanglePosX, rectanglePosY, rectangleWidth, rectangleHeigth)
end





-- Keyboard Handling
function handleInput(dt)
  if love.keyboard.isDown("up") then
    circlePosY = circlePosY - circleSpeed * dt
    if circlePosY - circleRadius < 0 then
      circlePosY = circleRadius
    end
  elseif love.keyboard.isDown("down") then
    circlePosY = circlePosY + circleSpeed * dt
    if circlePosY + circleRadius > windowHeigth then
      circlePosY = windowHeigth - circleRadius
    end
  elseif love.keyboard.isDown("right") then
    circlePosX = circlePosX + circleSpeed * dt
    if circlePosX + circleRadius > windowWidth then
      circlePosX = windowWidth - circleRadius
    end
  elseif love.keyboard.isDown("left") then
    circlePosX = circlePosX - circleSpeed * dt
    if circlePosX - circleRadius < 0 then
      circlePosX = circleRadius
    end
  end
end

function moveRectangle(dt)
  if rectanglePosX > windowWidth + rectangleWidth/2 then
    rectanglePosX = -rectangleWidth/2
  else
    rectanglePosX = rectanglePosX + rectangleSpeed * dt
  end
end
