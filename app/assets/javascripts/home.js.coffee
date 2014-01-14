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
  Game.canvas.addEventListener 'mousedown', (e) ->
    for object in Game.objects
      x = object.pos[0] + Map.pos[0]
      y = object.pos[1] + Map.pos[1]
      console.log "X ", e.clientX, x
      if e.clientX > x && e.clientX < x + object.width && e.clientY > y && e.clientY < y + object.height
        Game.objects.splice(Game.objects.indexOf(object), 1)

  canvas = Game.canvas
  canvas.width = $(window).width() - 20
  canvas.height = $(window).height()
  Game.ctx = canvas.getContext("2d")
  ctx = Game.ctx
  Game.init()
  Map.load()
  Game.main()

  $("#track").click ->
    Game.trackObject = !!!Game.trackObject

Game.addCockroach = (name) ->
  cockroach = $.extend(true, {}, Game.Objects.Cockroach);
  cockroach.load()
  cockroach.name = "name"
  cockroach.pos[0] = Math.floor(Math.random() * Game.canvas.width)
  cockroach.pos[1] = Math.floor(Math.random() * Game.canvas.height)
  cockroach.angle =  Math.floor(Math.random() * 360)
  Game.objects.push(cockroach)

Game.init = ->
  Game.objects = []
  i = 0
  while i < 3
    i++
    Game.addCockroach("Cockroach #{i}")
    

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
  
  if Game.trackObject
    Map.pos[0] = - Game.objects[0].pos[0] + Game.canvas.width / 2
    Map.pos[1] = - Game.objects[0].pos[1] + Game.canvas.height / 2
  
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

  if Math.floor(Math.random()*20) == 5
    Game.addCockroach("random cockroach")

#processKey = (e) ->
  #left
  #if e.keyCode == 37

#window.addEventListener('keydown',processKey,false);

