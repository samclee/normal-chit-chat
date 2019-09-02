-- centered small ones

local StartButton = class('StartButton', Button)

function StartButton:initialize(p)
  Button.initialize(self, p)
  self.to = p.to

  self.display = p.display
  self.font = fonts.sz48
  self.w = txtw(p.display, fonts.sz48) + 20
  self.x = (600 - txtw(p.display, fonts.sz48)) / 2
end

function StartButton:draw()
  g.setFont(self.font)
  if self.primed then
    rectfill(self.x-10, self.y, self.w, self.h, clrs.blk)
    prt(self.display, self.x, self.y, clrs.wht)
  else
    prt(self.display, self.x, self.y, clrs.blk)
  end
end

function StartButton:activate(mx, my)
  if self:contains_mouse(mx, my) then
    snds.press:play()
    gs.switch(s[self.to])
  end
end



return StartButton