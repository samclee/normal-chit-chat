local state = {}
local balls = {}
local world = {}
local sentence = {}
local tmr = {}


local wall_h = 1200
local ps = g.newParticleSystem(assets.particle)
ps:setParticleLifetime(.1,.5)
ps:setSpread(2 * math.pi)
ps:setSpeed(500,500)



function state:enter()
  g.setBackgroundColor(clrs.blk)
  world = ph.newWorld(0, 9.81 * 64, true)

  -- logic
  sentence = {}
  tmr = {width = 600, seconds = 9}
  ti.tween(10, tmr, {width = 0, seconds = 1}, 'linear', function()
    for i = #balls, 1, -1 do
      local b = balls[i]
      b.fixture:destroy()
      b.body:destroy()
      del(balls, i)
    end

    world:destroy()


    gs.switch(s.ending, sentence)
  end)

  -- walls
  Wall:new(300, 600, 600, 20, world)
  Wall:new(0, -(wall_h / 2 - 600), 20, wall_h, world)
  Wall:new(600, 600, 20, wall_h, world)

  -- use for loop
  --add(balls, WordBall:new(300, 300, 70, 1, 1, world))
  local cur_num = 0
  for cat = 1, #words do
    local cur_cat = words[cat]
    for ind = 1, #cur_cat do
      local x_pos = 30 + (cur_num % 4) * 140
      local y_pos = 550 - (cur_num / 4) * 120
      add(balls, WordBall:new(x_pos, y_pos, 70, cat, ind, world, cur_num))
      cur_num = cur_num + 1
    end
  end

  for i = #balls, 2, -1 do
    local j = round(love.math.random(i))
    local ix, iy = balls[i].body:getPosition()
    local jx, jy = balls[j].body:getPosition()

     balls[i].body:setPosition(jx, jy)
     balls[j].body:setPosition(ix, iy)
  end

end

function state:update(dt)
  world:update(dt)
  ps:update(dt)

  local mx, my = m.getPosition()

  --[[foreach(balls, function(b)
    b:update(mx, my)
  end)]]

  for i = #balls, 1, -1 do
    local b = balls[i]
    if b.mode == modes.ACTIVE then
      b:update(mx, my)
    else
      ps:moveTo(b.body:getX(), b.body:getY())
      ps:setColors(b.clr[1],b.clr[2],b.clr[3],1)
      ps:emit(32)

      b.fixture:destroy()
      b.body:destroy()
      del(balls, i)

      snds.explosion:play()
    end
  end
end

function state:draw()
  rectfill(0, 0, tmr.width, 600, clrs.wht)
  foreach(balls, function(b)
    b:draw()
  end)

  g.draw(ps, 0, 0)

end

function state:mousepressed(x, y, btn)
  if btn == 1 then
    for i,b in ipairs(balls) do
      if b.mode == modes.ACTIVE then
        b:activate(x, y, sentence)
      end
    end
  elseif btn == 2 then
    for i,b in ipairs(balls) do
      if b.mode == modes.ACTIVE then
        b:randomize(x, y)
      end
    end
  end
end


return state