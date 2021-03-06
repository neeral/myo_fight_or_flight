scriptId = 'edu.stanford.myo.templerun'
scriptTitle = "Temple Run 2 Script"
scriptDetailsUrl = ""

--locked = true
myo.setLockingPolicy("none")
appTitle = ""

function onForegroundWindowChange(app, title)
    myo.debug("onForegroundWindowChange: " .. app .. ", " .. title)
	appTitle = title
    return true
end

function activeAppName()
	return appTitle
end

function onPeriodic()
    roll = myo.getRoll()
    pitch = myo.getPitch()
--    myo.debug("onPeriodic: roll = " .. roll .. " ,  pitch = " .. pitch)
    if (roll > 0.8) then
        myo.debug("tilt right")
	myo.keyboard("x", "down")
    elseif (roll < 0.4) then
        myo.debug("tilt left")
	myo.keyboard("z", "down")
    else
        myo.keyboard("z", "up")
	myo.keyboard("x", "up")
    end

    if (pitch > 0.5) then
	myo.debug("Jump")
	myo.keyboard("up_arrow", "press")        
    end
end

function onPoseEdge(pose, edge)
    myo.debug("onPoseEdge: " .. pose .. ": " .. edge)
	
	pose = conditionallySwapWave(pose)
	
    if (pose ~= "rest" and pose ~= "unknown") then
        -- hold if edge is on, timed if edge is off
        myo.unlock(edge == "off" and "timed" or "hold")
    end
    
    local keyEdge = edge == "off" and "up" or "down"
    
	if (pose == "waveOut") then
		onWaveOut(keyEdge)		
	elseif (pose == "waveIn") then
		onWaveIn(keyEdge)
	elseif (pose == "fist") then
		onFist(keyEdge)
    elseif (pose == "fingersSpread") then
		onFingersSpread(keyEdge)			
	end
end

function onWaveOut(keyEdge)
	myo.debug("-->")
--	myo.vibrate("medium")
	myo.keyboard("right_arrow", keyEdge)
end

function onWaveIn(keyEdge)
	myo.debug("<--")
--	myo.vibrate("medium")
	myo.keyboard("left_arrow",keyEdge)
end

function onFist(keyEdge)
	myo.debug("Power-Up")
	myo.vibrate("short")
	myo.keyboard("space", keyEdge)
end

function onFingersSpread(keyEdge)
	myo.debug("Slide")
	myo.vibrate("long")
	myo.keyboard("down_arrow", keyEdge)
end

function conditionallySwapWave(pose)
	if myo.getArm() == "left" then
        if pose == "waveIn" then
            pose = "waveOut"
        elseif pose == "waveOut" then
            pose = "waveIn"
        end
    end
    return pose
end

		