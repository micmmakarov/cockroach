window.Game ||= {}
Objects = Game.Objects
Map = Game.Map
# Init

Game.requestAnimFrame = (->
  window.requestAnimationFrame or window.webkitRequestAnimationFrame or window.mozRequestAnimationFrame or (callback) ->
    window.setTimeout callback, 1000 / 60
)()

$ ->
  resources.load([
    '127.0.0.1:3000/assets/cockroach-02.png',
    '127.0.0.1:3000/assets/cockroach-02.png'
  ])
  resources.onReady(Game.init)

$ ->
  Game.canvas = document.getElementById('canvas')
  canvas = Game.canvas
  canvas.width = $(window).width() - 20
  canvas.height = $(window).height()
  Game.ctx = canvas.getContext("2d")
  ctx = Game.ctx
  Game.init()
  Map.load()
  Game.main()

Game.init = ->
  Game.objects = []
  i = 0
  while i < 10000
    i++
    cockroach = $.extend(true, {}, Game.Objects.Cockroach);
    cockroach.load()
    cockroach.name = "Cockroach #{i}"
    cockroach.pos[0] = Math.floor(Math.random() * Game.canvas.width)
    cockroach.pos[1] = Math.floor(Math.random() * Game.canvas.height)
    cockroach.angle =  Math.floor(Math.random() * 360)
    Game.objects.push(cockroach)

Game.renderObjects = (index) ->
  for object in Game.objects
    object.render(index)

Game.renderMap = (index) ->
  Map.render()

Game.render = (index) ->
  ctx = Game.ctx
  canvas = Game.canvas
  ctx.fillStyle = '#000000'
  ctx.fillRect(0, 0, canvas.width, canvas.height)
  
  #Map.pos[0] = - Game.objects[0].pos[0] + Game.canvas.width / 2
  #Map.pos[1] = - Game.objects[0].pos[1] + Game.canvas.height / 2
  
  Game.renderMap(index)
  Game.renderObjects(index)


Game.lastTime = Date.now()

#main loop
Game.main = ->
  now = Date.now()
  dt = (now - Game.lastTime) / 1000.0
  Game.render(dt)
  Game.lastTime = now
  window.setTimeout Game.main, 1000 / 60

#processKey = (e) ->
  #left
  #if e.keyCode == 37

#window.addEventListener('keydown',processKey,false);
