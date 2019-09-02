local state = {}
local btns = {}

function state:enter()
  g.setBackgroundColor(clrs.wht)
  btns = {}
  add(btns, StartButton:new({y = 300, h = 48, to = 'game', display = '<respond>'}))
  ph.setMeter(64)

  love.math.setRandomSeed(os.time())
  prompt_number = love.math.random(3)
  
end

function state:update(dt)
  local mx, my = m.getPosition()
  foreach(btns, function(b)
    b:update(dt, mx, my)
  end)
end

function state:draw()
  g.setFont(fonts.sz48)

  prtc(prompts[prompt_number][1], 50, clrs.blk)
  
  foreach(btns, function(b)
    b:draw()
  end)

end

function state:mousepressed(x, y, b)
  if b == 1 then
    foreach(btns, function(b)
      b:activate(x, y)
    end)
  end
end


return state