
app = require('express')()
http = require('http').Server app
io = require('socket.io')(http)

people = []

app.get '/', (req,res) ->
  res.sendfile "index.html"

app.get '/zepto.js', (req,res) ->
  res.sendfile "zepto.js"

io.on 'connection', (socket) ->
  console.log socket.id + ' connected.'
  people.push { id: socket.id, x: 100, y: 100 }
  io.emit 'places', people

  socket.on 'click', (pos) ->
    for person in people when person.id == socket.id
      person.x = pos.x
      person.y = pos.y
      io.emit 'places', people
  
  socket.on 'disconnect', ->
    console.log socket.id + " disconnected."
    people = people.filter (item, i) ->
      item.id != socket.id
    io.emit 'places', people

http.listen 3000, ->
  console.log 'listening on *:3000'

