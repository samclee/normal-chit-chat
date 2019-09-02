local Wall = class('Wall')

function Wall:initialize(x, y, w, h, world)
  self.body = ph.newBody(world, x, y)
  self.shape = ph.newRectangleShape(w, h)
  self.fixture = ph.newFixture(self.body, self.shape, 1)
end

return Wall