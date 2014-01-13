window.Game ||= {}
Game.Objects ||= {}

Game.Map =
  pos: [0, 0]
  image: 'http://127.0.0.1:3000/assets/pizza.jpg'
  load: ->
    image = new Image()
    image.src = @image
    @sprite = image

  render: (index) ->
    ctx = Game.ctx
    x =  @pos[0]
    y =  @pos[1]
    if @sprite
      ctx.drawImage(@sprite, x, y)

Game.Objects.Cockroach =
  step: 5
  pos: [1000, 300]
  width: 118
  height: 194
  loaded: false
  spritesLoaded: 0
  makeUturn: ->
    if @uturn <= 0
      @uturn = 180
  uturn: 0

  load: ->
    for image_url in @images
      image = new Image()
      image.src = image_url
      @sprites.push(image)
  sprites: []
  images: [
      'http://127.0.0.1:3000/assets/cockroach-01.png',
      'http://127.0.0.1:3000/assets/cockroach-02.png'
    ]
  angle: 250
  move: (index) ->  
    x = @pos[0] + @width /2 
    y = @pos[1] + @height/2

    if (y < @width || x < @height || x > Game.canvas.width - @width|| y > Game.canvas.height - @height)&&(@uturn <= 0)
      @makeUturn()
      console.log @name, x,y, @uturn
    lag = index * 100
    x = Math.sin(@angle* Math.PI/180) * lag
    y = Math.cos(@angle* Math.PI/180) * lag
    @pos[0] = @pos[0] + x
    @pos[1] = @pos[1] - y
    @distance = @distance + index    
    currentStep = Math.round(@distance/0.15)
    if currentStep != @currentStep
      if @currentStep/3 == Math.floor(@currentStep/3)
        if @uturn <= 0
          @angle = @angle + (Math.random() * 50 - 25)
        else
          @uturn = @uturn - 10
          if @uturn >= 110
            @angle = @angle - 30

      @currentSpriteIndex = @currentSpriteIndex + 1
      if @currentSpriteIndex >= @sprites.length
        @currentSpriteIndex = 0

    @currentStep = currentStep
    #@pos[0] = @pos[0] - 1

  currentSpriteIndex: 0
  currentSprite: ->
    @sprites[@currentSpriteIndex]
  distance: 0
  render: (index) ->
    @move(index)
    ctx = Game.ctx
    x = @pos[0] + @width /2 + Game.Map.pos[0]
    y = @pos[1] + @height/2 + Game.Map.pos[1]
    
    ctx.save();
    ctx.translate(x, y)
    ctx.rotate(@angle * Math.PI / 180);
    ctx.drawImage(@currentSprite(), -@width/2, -@height/3*2)
    ctx.restore();
    
