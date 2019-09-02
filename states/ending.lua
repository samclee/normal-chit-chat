local state = {}
local btns = {}
local done = false
local cur_ind = 1
local mytimer = 0

function state:enter(from, sentence)
  g.setBackgroundColor(clrs.wht)
  btns = {}
  self.sentence = sentence
  self.display_sentence = {}

  done = false
  cur_ind = 1
  mytimer = 0

  if #sentence == 0 then
    self.sentence = {{0,0,0}, 'bluh '}
  end

  local first_word = self.sentence[2]
  self.sentence[2] = '\"' .. string.upper(first_word:sub(1, 1)) .. first_word:sub(2, #first_word)

  local last_word = self.sentence[#self.sentence]
  self.sentence[#self.sentence] = last_word:sub(1, #last_word - 1) .. '.\"'

  add(btns, StartButton:new({y = 530, h = 48, to = 'start', display = '<play again>'}))

end

function state:update(dt)
  local mx, my = m.getPosition()
  foreach(btns, function(b)
    b:update(dt, mx, my)
  end)
end

function state:draw()
  prtc(prompts[prompt_number][1], 50, clrs.blk)
  g.setFont(fonts.sz48)
  g.printf(self.display_sentence, 20, 140, 540, 'center')

  if cur_ind <= #self.sentence then
    if mytimer < 2 then
      mytimer = mytimer + .1
    else
      mytimer = mytimer - 2
      add(self.display_sentence, self.sentence[cur_ind])
      add(self.display_sentence, self.sentence[cur_ind + 1])

      cur_ind = cur_ind + 2
      snds.beep:play({pitch = love.math.random(30,100)/100})
    end
  else
    done = true
  end

  if done then 
    prtc(prompts[prompt_number][2], 450, clrs.blk)
    
    foreach(btns, function(b)
      b:draw()
    end)

  end

end

function state:mousepressed(x, y, b)
  if b == 1 then
    foreach(btns, function(b)
      b:activate(x, y)
    end)
  end
end


return state