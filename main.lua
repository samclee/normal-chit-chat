g = love.graphics
m = love.mouse
ph =love.physics

require 'libs.pico'
ti = require 'libs.timer'
class = require 'libs.middleclass'
assets = require('libs/cargo').init('assets')
gs = require 'libs.gamestate'
ripple = require 'libs.ripple'
snds = {
  explosion = ripple.newSound(assets.explosion),
  beep = ripple.newSound(assets.beep1),
  press = ripple.newSound(assets.beep2),
  hover = ripple.newSound(assets.beep3)
}

clrs = {
  blk = {0 , 0, 0},
  wht = {1, 1, 1},
  org = {1, 0.553, 0},
  aqu = {0.353, 1, .929},
  red = {0.937, 0.463, 0.463},
  grn = {0.263, 0.937, 0.263},
  blu = {0.263, 0.263, 0.937},
  pnk = {1, 0.753,0.796},
  skblu = {0.459,0.855,1},
  dpnk = {0.91, 0.329, 0.502}
}

fonts = {
  sz16 = g.newFont('assets/basis.ttf', 16),
  sz32 = g.newFont('assets/basis.ttf', 32),
  sz48 = g.newFont('assets/basis.ttf', 48),
  sz64 = g.newFont('assets/basis.ttf', 64),
}

s = {}
statenames = {'start', 'game', 'ending'}
for _,n in pairs(statenames) do
  s[n] = require ('states.'.. n)
end

modes = {
  ACTIVE = 1,
  INACTIVE = 2
}

word_t = {
  CONJ = 1,
  NOUN = 2,
  VERB = 3,
  ADJT = 4,
  ADVB = 5
}

word_clrs = {
  clrs.red,
  clrs.blu,
  clrs.grn,
  clrs.org,
  clrs.pnk
}

words = {
  {
    'and',
    'and',
    'to',
    'but',
    'for',
    'with',
    'in',
    'to',
    'or',
    'so',
    'the',
    'of'
  },
  {
    'it',
    'that',
    'they',
    'them',
    'friend',
    'day',
    'a',
    'dog',
    'clown',
    'corn',
    'baby',
    'I',
    'I',
    'ham',
    'sword',
    'I'
  },
  {
    'is',
    'was',
    'loved',
    'had',
    'drew',
    'found',
    'ate',
    'made',
    'found',
    'broke',
    'bit',
    'held',
    'hugged'
  },
  {
    'my',
    'their',
    'every',
    'good',
    'sticky',
    'big',
    'heavy',
    'light',
    'scary'
  },
  {
    'not',
    'barely',
    'since',
    'well',
    'really'
  }
}

prompts = {
  {
    'How was your weekend?',
    'Sounds fun!'
  },
  {
    'What is your motto?',
    'Truly words to live by.'
  },
  {
    'Tell me a fun story.',
    'What a masterpiece.'
  }
}

promt_number = 1

Button = require 'classes.Button'
StartButton = require 'classes.StartButton'
WordBall = require 'classes.WordBall'
Wall = require 'classes.Wall'

function love.load()
  g.setBackgroundColor(1,1,0)

  gs.registerEvents()
  gs.switch(s.start)

end

function love.update(dt)
  ti.update(dt)
end
 
function love.draw()

end