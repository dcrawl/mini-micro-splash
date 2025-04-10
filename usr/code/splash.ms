import "json"

// Clear Sprite Display
clear

// Load JSON Animation data
anim = json.parse(file.open("/usr/data/intro.json").read)

// Load Frame files
frames = []
sounds = []
for data in anim["frames"]
  frames.push file.loadImage(data[0])

  if data[2].len > 0 then
    // Load Sound
    sounds.push file.loadSound(data[2])
  else
    sounds.push null
  end if
end for

// Initialize
currentFrame = 0
lastFrame = anim["frames"].len - 1
frameSpeed = 1 / anim["fps"]
nextFrame = time + frameSpeed * anim["frames"][currentFrame][1]
frame = new Sprite
frame.x = 480
frame.y = 320
frame.image = frames[currentFrame]
display(4).sprites.push frame

while true
  currentTime = time

  if currentFrame >= lastFrame and currentTime >= nextFrame then break

	if currentTime >= nextFrame then
		// setup next frame
		currentFrame += 1
		data = anim["frames"][currentFrame]
		nextFrame += frameSpeed * data[1]
		frame.image = frames[currentFrame]

		if data[2].len > 0 then
			s = sounds[currentFrame]
			if s isa Sound then s.play
		end if
	end if
end while