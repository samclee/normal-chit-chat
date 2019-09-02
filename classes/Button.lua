local Button = class('Button')

function Button:initialize(p)
  self.x = p.x or 1
  self.y = p.y
  self.w = p.w or 1
  self.h = p.h

  self.primed = false
end

function Button:update(dt, mx, my)
  if self:contains_mouse(mx, my) then
    if not self.primed then snds.hover:play() end
    self.primed = true
  else
    self.primed = false
  end
end

function Button:contains_mouse(mx, my)
  return within(self.x, mx, self.x + self.w) and within(self.y, my, self.y + self.h)
end

return Button