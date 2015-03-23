# TypeWriter

A Class that writes out text to a DOM Node.

```coffee

TypeWriter = require('./typewriter/typewriter.coffee');

writer = [
  { words: 'Hello my name is John Long' }
  {
    words: 'and...'
    break: true
    wait: 3000
    clearAll: true
  }
  { 
    words: 'I like beer' 
  }
  {
    words: 'and...'
    wait: 1000
  }
  { words: 'I have a wife and child' }
  {
    words: 'plus...'
    wait: 1000
  }
  {
    words: 'Writing code is pretty fun.' 
  }

]
writer2 = [ { words: 'Also, I live in Salt Lake City, Utah' } ]

typeWriter = new TypeWriter(writer, document.getElementById('para'))
typeWriter2 = new TypeWriter(writer2, document.getElementById('para'))

typeWriter.start()
typeWriter.done (->
  typeWriter2.start()
), 2250

typeWriter2.done ->
  console.log 'all done'


```
