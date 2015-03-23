module.exports = class TypeWriter
  constructor: (config, el)->
    @fullSentence = ""
    @el = el
    @config = config
    @currentIndex = 0
    @totalLength = config.length

  start: ()->
    @_type @_setup(@config)

  done: (doneFn, wait)->
    @_doneFn = ()->
      setTimeout (=>
        doneFn()
      ), wait

  _setup: (config)->
    wordConfigs = config.map (obj, wordIndex)=>
      letters = []
      words = obj.words.split("")
      words.forEach (word, i)->
        letters.push
          letter: word
      return letters
    return wordConfigs
          
  _type: (words)=>
    return if @_done(@totalLength is @currentIndex)
    @_startSentence words[@currentIndex], =>
      @fullSentence += ' '
      @fullSentence += '<br>' if @config[@currentIndex].break
      @fullSentence = "" if @config[@currentIndex].clearAll
      setTimeout (=>
        @currentIndex++
        @_type(words)
      ), @config[@currentIndex].wait or 220

  _startSentence: (sentence, callback)->
    sentenceLength = sentence.length - 1
    sentence.forEach (letter, idx)=>
      setTimeout (=>
        @fullSentence += letter.letter
        @el.innerHTML = @fullSentence
        callback() if sentenceLength is idx
      ), @_rando(idx)

  _done: (done)->
    if done
      if typeof @_doneFn is 'function'
        @_doneFn()
    return done
  
  _rando: (i)->
    timeOut = (120 * i) + (Math.floor(Math.random() * 100))
    console.log timeOut
    return timeOut