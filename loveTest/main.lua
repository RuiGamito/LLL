

windowWidth = love.graphics.getWidth()
windowHeigth = love.graphics.getHeight()

circleRadius = 10
initialPosX = windowWidth/2
initialPosY = windowHeigth/2
circleSpeed = {
  x = 200,
  y = 200

}
circleMaxSpeedValue = 1000
circleBounceSpeedIncreasePercentage = {
  x = 0.1,
  y = 0.1
}

rectangleWidth = 100
rectangleHeigth = 20
rectangleSpeed = 500



-- Game Cycle
function love.load()
  circlePosX = initialPosX
  circlePosY = initialPosY
  rectanglePosX = windowWidth/2
  rectanglePosY = windowHeigth - rectangleHeigth/2
end

function love.update(dt)
  handleInput(dt)
  moveCircle(dt)
  handleCollisionBallAndRectangle()
end


function love.draw()
  love.graphics.print("Hello World", 400, 300)
  love.graphics.print("Speed X: " .. circleSpeed.x, 400, 400)
  love.graphics.print("Speed Y: " .. circleSpeed.y, 400, 450)
  love.graphics.print("[Speed] Y: " .. math.abs(circleSpeed.y), 400, 500)

  love.graphics.setColor(255, 255, 255)
  love.graphics.circle("fill", circlePosX, circlePosY, circleRadius)

  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle("fill", rectanglePosX, rectanglePosY, rectangleWidth, rectangleHeigth)
end





-- Keyboard Handling
function handleInput(dt)
  if love.keyboard.isDown("up") then
    rectanglePosY = rectanglePosY - rectangleSpeed * dt
    if rectanglePosY < 0 then
      rectanglePosY = 0
    end
  elseif love.keyboard.isDown("down") then
    rectanglePosY = rectanglePosY + rectangleSpeed * dt
    if rectanglePosY + rectangleHeigth > windowHeigth then
      rectanglePosY = windowHeigth - rectangleHeigth
    end
  elseif love.keyboard.isDown("right") then
    rectanglePosX = rectanglePosX + rectangleSpeed * dt
    if rectanglePosX + rectangleWidth > windowWidth then
      rectanglePosX = windowWidth - rectangleWidth
    end
  elseif love.keyboard.isDown("left") then
    rectanglePosX = rectanglePosX - rectangleSpeed * dt
    if rectanglePosX < 0 then
      rectanglePosX = 0
    end
  end
end

function moveCircle(dt)
  if circlePosX + circleRadius > windowWidth then
    circlePosX = windowWidth - circleRadius
    circleSpeed.x = -circleSpeed.x
    if circleSpeed.x > circleMaxSpeedValue then
      circleSpeed.x = circleMaxSpeedValue
    end
  end
  if circlePosX - circleRadius < 0 then
    circlePosX = circleRadius
    circleSpeed.x = -circleSpeed.x
  end
  if circlePosY + circleRadius > windowHeigth then
    circlePosY = windowHeigth - circleRadius
    circleSpeed.y = -circleSpeed.y
  end
  if circlePosY - circleRadius < 0 then
    circlePosY = circleRadius
    circleSpeed.y = -circleSpeed.y
  end

  limitCircleSpeed()

  circlePosX = circlePosX + circleSpeed.x * dt
  circlePosY = circlePosY + circleSpeed.y * dt

end

function limitCircleSpeed()
  if math.abs(circleSpeed.x) > circleMaxSpeedValue and circleSpeed.x > 0 then
    circleSpeed.x = circleMaxSpeedValue
  elseif math.abs(circleSpeed.x) > circleMaxSpeedValue and circleSpeed.x < 0 then
    circleSpeed.x = -circleMaxSpeedValue
  end
  if math.abs(circleSpeed.y) > circleMaxSpeedValue and circleSpeed.y > 0 then
    circleSpeed.y = circleMaxSpeedValue
  elseif math.abs(circleSpeed.y) > circleMaxSpeedValue and circleSpeed.y < 0 then
    circleSpeed.y = -circleMaxSpeedValue
  end
end

function handleCollisionBallAndRectangle()
  if circlePosY + circleRadius > rectanglePosY and circlePosX > rectanglePosX and circlePosX < rectanglePosX + rectangleWidth and circleSpeed.y > 0 then
    circleSpeed.y = -(circleSpeed.y * (1 + circleBounceSpeedIncreasePercentage.y))
  end
end
