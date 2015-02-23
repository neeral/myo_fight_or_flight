--scriptId = 'com.thalmic.examples.myfirstscript'
scriptId = 'edu.stanford.myo.myfirstscript'
scriptTitle = "My First Script"
scriptDetailsUrl = ""

locked = true
appTitle = ""

function onForegroundWindowChange(app, title)
    myo.debug("onForegroundWindowChange: " .. app .. ", " .. title)
	appTitle = title
    return true
end

function activeAppName()
	return appTitle
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
	myo.debug("Next")
	--myo.vibrate("short")
	myo.keyboard("tab", keyEdge)
end

function onWaveIn(keyEdge)
	myo.debug("Previous")
	--myo.vibrate("short")
	--myo.vibrate("short")
	myo.keyboard("tab",keyEdge,"shift")
end


function onFist(keyEdge)
	myo.debug("Enter")	
	--myo.vibrate("medium")
	myo.keyboard("return",keyEdge)
end

function onFingersSpread(keyEdge)
	myo.debug("Escape")
	--myo.vibrate("long")
	myo.keyboard("escape", keyEdge)
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