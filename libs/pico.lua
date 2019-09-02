function rect(x,y,w,h,c)
  love.graphics.setColor(c)
  love.graphics.rectangle('line',x,y,w,h)
  love.graphics.setColor(1,1,1)
end

function rectfill(x,y,w,h,c)
  love.graphics.setColor(c)
  love.graphics.rectangle('fill',x,y,w,h)
  love.graphics.setColor(1,1,1)
end

function circ(x,y,r,c)
  love.graphics.setColor(c)
  love.graphics.ellipse('line',x,y,r)
  love.graphics.setColor(1,1,1)
end

function circfill(x,y,r,c)
  love.graphics.setColor(c)
  love.graphics.ellipse('fill',x,y,r)
  love.graphics.setColor(1,1,1)
end

function add(tbl, val)
  table.insert(tbl, val)
end

function del(tbl, i)
  table.remove(tbl, i)
end

function delv(tbl, val)
  for i,v in ipairs(tbl) do
    if v == val then
      table.remove(tbl, i)
    end
  end
end

function prt(str, x, y, c)
  local x, y = x or 0, y or 0

  love.graphics.setColor(c)
  love.graphics.print(str, x, y)
  love.graphics.setColor(1,1,1)
end

function prtf(str, x, y, f, c)
  love.graphics.setFont(f)
  prt(str, x, y, c)
end

function txtw(str, f)
  return f:getWidth(str)
end

function prtc(str, y, c)
  local cur_font = love.graphics.getFont()
  local text_w = cur_font:getWidth(str)
  local mid_x = (600 - text_w) / 2
  prt(str, mid_x, y, c)
end

function within(l,m,h)
  return l < m and m < h
end

function foreach(tbl, f)
  for k,v in pairs(tbl) do
    f(v)
  end
end

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function spr(s, x, y, flip_x, flip_y)
  local sx, sy = 1, 1
  if flip_x then sx = -1 end
  if flip_y then sy = -1 end
  lg.draw(s, x, y, 0, sx, sy, s:getWidth(), s:getHeight())
end