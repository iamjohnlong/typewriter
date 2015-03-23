module.exports = class TypeWriter
  constructor: (config, el)->
    @fullSentence = ""
    @el = el
    @config = config

  start: ()->
    @_type @_setup(@config)

  done: (doneFn, wait)->
    @_doneFn = ()->
      setTimeout (=>
        doneFn()
      ), wait

  _setup: (config)->
    prevTime = 0
    currTime = 0
    wordConfigs = config.map (obj)=>
      timeOut = []
      prevTime += currTime
      currTime = 0
      words = obj.words.split("")
      words.forEach (word, i)->
        t = 90 * i
        currTime = obj.wait or t + 320
        timeOut.push 
          timeout: t
          letter: word
      timeOut.push
        totalTime: currTime
        waitTime: prevTime
        break: obj.break
        clearAll: obj.clearAll
      return timeOut
    return wordConfigs
          
  _type: (words)=>
    wordsLength = words.length - 1
    words.forEach (sentence, i)=>
      timers = sentence.pop()
      sentenceLength = sentence.length - 1
      setTimeout (=>
        sentence.forEach (letter, idx)=>
          setTimeout (=>
            @fullSentence += letter.letter
            @el.innerHTML = @fullSentence
            if sentenceLength is idx
              @fullSentence += ' '
            if sentenceLength is idx && timers.break
              @fullSentence += '<br>'
            if sentenceLength is idx && timers.clearAll
              @fullSentence = ''
            if sentenceLength is idx && wordsLength is i
              if typeof @_doneFn is 'function'
                @_doneFn()
          ), letter.timeout
      ), timers.waitTime
