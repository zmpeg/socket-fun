
app = require('express')()
http = require('http').Server app
io = require('socket.io')(http)

people = []

app.get '/', (req,res) ->
  res.sendfile "index.html"

app.get '/zepto.js', (req,res) ->
  res.sendfile "zepto.js"

io.on 'connection', (socket) ->
  console.log socket.id + " connected."
  people.push { id: socket.id, x: 100, y: 100 }
  io.emit 'places', people

  socket.on 'click', (pos) ->
    console.log pos
  
  socket.on 'disconnect', ->
    console.log socket.id + " disconnected."
    people = people.filter (item, i) ->
      item.id == socket.id

http.listen 3000, ->
  console.log 'listening on *:3000'

