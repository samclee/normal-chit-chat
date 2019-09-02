local WordBall = class('WordBall')

function WordBall:initialize(x, y, r, wt, id, world, n)
  self.clr = word_clrs[wt]
  self.mode = modes.ACTIVE
  self.wt = wt
  self.id = id
  self.font = fonts.sz48
  self.n = n

  self.primed = false


  local dir = 1
  if (love.math.random() > 0.5) then dir = -1 end
  self.body = ph.newBody(world, x, y, 'dynamic')
  self.body:applyTorque((love.math.random(500)) * dir)
  self.shape = ph.newCircleShape(r)
  self.fixture = ph.newFixture(self.body, self.shape, 1)
  self.fixture:setRestitution(0.9)
end

function WordBall:update(x, y)
  if self.mode == modes.ACTIVE and self:contains_mouse(x, y) then
    self.primed = true
  else
    self.primed = false
  end
end

function WordBall:draw()
  circfill(self.body:getX(), self.body:getY(), self.shape:getRadius(), self.clr)
  if self.mode == modes.ACTIVE then
    if self.primed then
      g.setLineWidth(4)
      g.setColor(self.clr)
      circ(self.body:getX(), self.body:getY(), self.shape:getRadius() + 8, self.clr)
    end

    local word = words[self.wt][self.id]
    local tw = txtw(word, self.font)

    g.push()
    g.translate(self.body:getX(), self.body:getY())
    g.rotate(self.body:getAngle() * 10)

    prtf(word, -tw / 2, -25, self.font, clrs.blk)

    g.pop()
  end
end

function WordBall:randomize(x, y)
  if self:contains_mouse(x, y) then
    self.id = round(love.math.random(#words[self.wt]))
  end
end

function WordBall:activate(x, y, sentence)
  if self:contains_mouse(x, y) then
    add(sentence, self.clr)
    add(sentence, words[self.wt][self.id] .. ' ')
    --self:shrink()
    self.mode = modes.INACTIVE
  end

  return true
end

function WordBall:contains_mouse(x, y)
  return self.fixture:testPoint(x, y)
end

function WordBall:shrink()
  self.shape:setRadius(20)
end

return WordBall