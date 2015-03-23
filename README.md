# TypeWriter

A Class write out text to the dom.

```coffee

TypeWriter = require('./typewriter/typewriter.coffee');

writer = [
  { words: 'Hello my name is John Long' }
  {
    words: 'and...'
    break: true
  }
  {
    words: 'I like to party'
    clearAll: true
    wait: 4000
  }
  { words: 'with booze...' }
]
writer2 = [ { words: 'I live in Salt Lake City, Utah' } ]

typeWriter = new TypeWriter(writer, document.getElementById('para'))
typeWriter2 = new TypeWriter(writer2, document.getElementById('para'))

typeWriter.start()
typeWriter.done (->
  typeWriter2.start()
  return
), 3000
typeWriter2.done ->
  console.log 'all done'
  return
  

```
