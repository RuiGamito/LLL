
hud = {

	init = function(self)
		INITIAL_TIME = 0
		SESSION_TIME = 0
		CURRENT_SCORE = 0
		CURRENT_TIME = 0
		SCORE_ACTIVE = false
		TIMER_ACTIVE = false
		TIMER_OVER = false
		HUD_MESSAGE = ""

		DISPLAY_WIDTH = love.graphics.getWidth()
		HUD_HEIGHT = 0
	end,

	reset = function(self)
		INITIAL_TIME = love.timer.getTime()
		CURRENT_SCORE = 0
		TIMER_OVER = false
	end,

	draw = function(self)
		love.graphics.push()

		-- Print the points
		if SCORE_ACTIVE then
    	love.graphics.print("Score: " .. CURRENT_SCORE, 10, 10)
    end

    -- Print the timer
    if TIMER_ACTIVE and not TIMER_OVER then
    	CURRENT_TIME = SESSION_TIME - (love.timer.getTime() - INITIAL_TIME)
    	love.graphics.print("Timer: " .. string.format("%.0f", CURRENT_TIME), DISPLAY_WIDTH-100, 10)
    elseif TIMER_OVER then
    	love.graphics.setColor(255, 0, 0)
    	love.graphics.print("Timer: 0", DISPLAY_WIDTH-100, 10)
    	love.graphics.setColor(255, 255, 255)
    end

    if TIMER_ACTIVE and CURRENT_TIME <= 0 and not TIMER_OVER then
			TIMER_OVER = true
    end

		-- Print the HUD message, if any
		if HUD_MESSAGE ~= "" and HUD_MESSAGE ~= nil then
			love.graphics.print(HUD_MESSAGE, DISPLAY_WIDTH/2 - 50, 10)
		end

		-- Draw hud separator
    love.graphics.line(0,HUD_HEIGHT, DISPLAY_WIDTH, HUD_HEIGHT)

		love.graphics.pop()
	end,

	increase_score = function(self, ammount)
		CURRENT_SCORE = CURRENT_SCORE + ammount
	end,

	get_score = function(self)
		return CURRENT_SCORE
	end,

	set_start_time = function(self)
		INITIAL_TIME = love.timer.getTime()
		TIMER_OVER = false
	end,

	set_session_time = function(self, time)
		SESSION_TIME = time
	end,

	toggle_score = function(self, bool)
		SCORE_ACTIVE = bool
	end,

	toggle_timer = function(self, bool)
		TIMER_ACTIVE = bool
	end,

	set_hud_height = function(self, height)
		HUD_HEIGHT = height
	end,

	timer_over = function(self)
		return TIMER_OVER
	end,

	message = function(self, message)
		HUD_MESSAGE = message
	end


}
