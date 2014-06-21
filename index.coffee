
app = require('express')()
http = require('http').Server app
io = require('socket.io')(http)

app.get '/', (req,res) ->
  res.sendfile "index.html"

app.get '/zepto.js', (req,res) ->
  res.sendfile "zepto.js"

io.on 'connection', (socket) ->
  console.log 'a user connected'
  socket.on 'disconnect', ->
    console.log 'user disconnected'

http.listen 3000, ->
  console.log 'listening on *:3000'

