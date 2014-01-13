
# Load an image url or an array of image urls
load = (urlOrArr) ->
  if urlOrArr instanceof Array
    urlOrArr.forEach (url) ->
      _load url

  else
    _load urlOrArr
_load = (url) ->
  if resourceCache[url]
    resourceCache[url]
  else
    img = new Image()
    img.onload = ->
      resourceCache[url] = img
      if isReady()
        readyCallbacks.forEach (func) ->
          func()


    resourceCache[url] = false
    img.src = url
get = (url) ->
  resourceCache[url]
isReady = ->
  ready = true
  for k of resourceCache
    ready = false  if resourceCache.hasOwnProperty(k) and not resourceCache[k]
  ready
onReady = (func) ->
  readyCallbacks.push func
resourceCache = {}
loading = []
readyCallbacks = []
window.resources =
  load: load
  get: get
  onReady: onReady
  isReady: isReady