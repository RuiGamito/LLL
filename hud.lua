
hud = {

	init = function(self)
		INITIAL_TIME = 0
		SESSION_TIME = 0
		CURRENT_SCORE = 0
		CURRENT_TIME = 0
		SCORE_ACTIVE = false
		TIMER_ACTIVE = false
	end,

	draw = function(self)
		love.graphics.push()

		-- Print the points
		if SCORE_ACTIVE then
    		love.graphics.print("Score: " .. CURRENT_SCORE, 10, 10)
    	end
    	
    	-- Print the timer
    	if TIMER_ACTIVE then
    		love.graphics.print("Timer: " .. string.format("%.0f",SESSION_TIME - (love.timer.getTime() - INITIAL_TIME)), love.graphics.getWidth()-100, 10)
    	end

		love.graphics.pop()
	end,

	increase_score = function(self, ammount)

		CURRENT_SCORE = CURRENT_SCORE + ammount

	end,

	set_start_time = function(self)
		INITIAL_TIME = love.timer.getTime()
	end,

	set_session_time = function(self, time)
		SESSION_TIME = time
	end,

	toggle_score = function(self, bool)
		SCORE_ACTIVE = bool
	end,

	toggle_timer = function(self, bool)
		TIMER_ACTIVE = bool
	end	
} 

