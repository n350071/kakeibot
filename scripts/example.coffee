# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->

  robot.hear /予算/i, (res) ->
    url = "https://script.google.com/macros/s/AKfycbyqYYjmdd-TnNz1mzy_c3zOLpHGHKd-jSYuqqXo71m-s_zqxIYH/exec"
    url = url + "?type=badget"
    robot.http(url)
      .get() (err, httpRes, body) ->
        if err
          res.send "Encountered an error :( #{err}"
          return
        url =  httpRes.headers.location
        robot.http(url)
          .get() (err, httpRes, body) ->
            data = JSON.parse body
            retStr = "---予算---" + '\n' ;
            for cate, index in data.category
              retStr = retStr + "#{cate} : #{data.badget[index]}"  + '\n'
            res.send retStr

  robot.hear /実績/i, (res) ->
    url = "https://script.google.com/macros/s/AKfycbyqYYjmdd-TnNz1mzy_c3zOLpHGHKd-jSYuqqXo71m-s_zqxIYH/exec"
    url = url + "?type=actual"
    robot.http(url)
      .get() (err, httpRes, body) ->
        if err
          res.send "Encountered an error :( #{err}"
          return
        url =  httpRes.headers.location
        robot.http(url)
          .get() (err, httpRes, body) ->
            data = JSON.parse body
            retStr = "---実績---" + '\n' ;
            for cate, index in data.category
              retStr = retStr + "#{cate} : #{data.actual[index]}"  + '\n'
            res.send retStr

  robot.hear /残り/i, (res) ->
    url = "https://script.google.com/macros/s/AKfycbyqYYjmdd-TnNz1mzy_c3zOLpHGHKd-jSYuqqXo71m-s_zqxIYH/exec"
    url = url + "?type=remain"
    robot.http(url)
      .get() (err, httpRes, body) ->
        if err
          res.send "Encountered an error :( #{err}"
          return
        url =  httpRes.headers.location
        robot.http(url)
          .get() (err, httpRes, body) ->
            data = JSON.parse body
            retStr = "---残り---" + '\n' ;
            for cate, index in data.category
              retStr = retStr + "#{cate} : #{data.remain[index]}"  + '\n'
            res.send retStr

  robot.hear /(.*)/i, (res) ->
    postURL = "https://script.google.com/macros/s/AKfycbyqYYjmdd-TnNz1mzy_c3zOLpHGHKd-jSYuqqXo71m-s_zqxIYH/exec"
    paramAry = res.match[0].split " "
    sendData = JSON.stringify({
        "method": "actualInput","params": {"item": [paramAry[0]],"qty": [paramAry[1]],"note": [paramAry[2]],"phase": 1}
      })
    #sendData = JSON.stringify({
    #    "method": "actualInput","params": {"item": ["生きる"],"qty": ["180"],"note": ["うどん"],"phase": 1}
    #  })
    robot.http(postURL)
      .header('Content-Type', 'application/json')
      .post(sendData) (err, httpRes, body) ->
        url =  httpRes.headers.location
        robot.http(url)
          .get() (err, httpRes, body) ->
            data = JSON.parse body
            if(data.status == "success")
              res.send "#{data.message}"






  # robot.hear /badger/i, (res) ->
  #   res.send "Badgers? BADGERS? WE DON'T NEED NO STINKIN BADGERS"
  #
  # robot.respond /open the (.*) doors/i, (res) ->
  #   doorType = res.match[1]
  #   if doorType is "pod bay"
  #     res.reply "I'm afraid I can't let you do that."
  #   else
  #     res.reply "Opening #{doorType} doors"
  #
  # robot.hear /I like pie/i, (res) ->
  #   res.emote "makes a freshly baked pie"
  #
  # lulz = ['lol', 'rofl', 'lmao']
  #
  # robot.respond /lulz/i, (res) ->
  #   res.send res.random lulz
  #
  # robot.topic (res) ->
  #   res.send "#{res.message.text}? That's a Paddlin'"
  #
  #
  # enterReplies = ['Hi', 'Target Acquired', 'Firing', 'Hello friend.', 'Gotcha', 'I see you']
  # leaveReplies = ['Are you still there?', 'Target lost', 'Searching']
  #
  # robot.enter (res) ->
  #   res.send res.random enterReplies
  # robot.leave (res) ->
  #   res.send res.random leaveReplies
  #
  # answer = process.env.HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING
  #
  # robot.respond /what is the answer to the ultimate question of life/, (res) ->
  #   unless answer?
  #     res.send "Missing HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING in environment: please set and try again"
  #     return
  #   res.send "#{answer}, but what is the question?"
  #
  # robot.respond /you are a little slow/, (res) ->
  #   setTimeout () ->
  #     res.send "Who you calling 'slow'?"
  #   , 60 * 1000
  #
  # annoyIntervalId = null
  #
  # robot.respond /annoy me/, (res) ->
  #   if annoyIntervalId
  #     res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #     return
  #
  #   res.send "Hey, want to hear the most annoying sound in the world?"
  #   annoyIntervalId = setInterval () ->
  #     res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #   , 1000
  #
  # robot.respond /unannoy me/, (res) ->
  #   if annoyIntervalId
  #     res.send "GUYS, GUYS, GUYS!"
  #     clearInterval(annoyIntervalId)
  #     annoyIntervalId = null
  #   else
  #     res.send "Not annoying you right now, am I?"
  #
  #
  # robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
  #   room   = req.params.room
  #   data   = JSON.parse req.body.payload
  #   secret = data.secret
  #
  #   robot.messageRoom room, "I have a secret: #{secret}"
  #
  #   res.send 'OK'
  #
  # robot.error (err, res) ->
  #   robot.logger.error "DOES NOT COMPUTE"
  #
  #   if res?
  #     res.reply "DOES NOT COMPUTE"
  #
  # robot.respond /have a soda/i, (res) ->
  #   # Get number of sodas had (coerced to a number).
  #   sodasHad = robot.brain.get('totalSodas') * 1 or 0
  #
  #   if sodasHad > 4
  #     res.reply "I'm too fizzy.."
  #
  #   else
  #     res.reply 'Sure!'
  #
  #     robot.brain.set 'totalSodas', sodasHad+1
  #
  # robot.respond /sleep it off/i, (res) ->
  #   robot.brain.set 'totalSodas', 0
  #   res.reply 'zzzzz'



#  key_kurasu = 'kurasu'  
#
#  # 変数定義
#  stday           = ''  #開始日
#  numTurms        = ''  #期数
#  numDays         = ''  #日数
#
#  itemNames       = ['A','B','C']  #品目名
#
#  phase           = []  #基毎に予算、実績を格納
#  budgets         = []  #予算を格納
#  actuals         = []  #実績を格納
#  specialBudet    = 0
#  specialAcutual  = 0
#
#  # 内部的な変数
#  thisPhase       = 3   #いまは第#phase?
#
#  # 予算設定[1.5,5,30]のような入力を受けて、結果を返す
#  robot.hear /予算設定[(.*)]/i, (res) ->
#    input = res.match[1]
#    #,の区切りを切る
#    #1000倍して
#    #予算に格納する
#    budgets = [15000,50000,30000]
#    #今月の予算に格納する
#    phase[thisPhase] = budgets
#    #DBへ格納する
#    #for budet : budets(
#    #  robot.brain.set key budget
#    #)
#    res.send "予算設定しました"
#
#  robot.hear /くらす(.*)/i, (res) ->
#    spendMoney = res.match[1]
#    kurasu = parseInt(getKakei(key_kurasu),10) - parseInt(spendMoney,10)
#    robot.brain.set key_kurasu, kurasu
#    res.send """
#            「くらす」に#{spendMoney}円を使いました。
#            --残高---------------------
#            「くらす」は#{kurasu}です。
#            --------------------------
#            """
#
#  robot.hear /clear/i, (res) ->
#    robot.brain.set key_kurasu, 0
#    robot.brain.set key_taberu, 0
#    robot.brain.set key_others, 0
#
#    kurasu = parseInt(getKakei(key_kurasu),10)
#
#    res.send """
#            「くらす」は#{kurasu}です。
#            """    
#
#  robot.hear /set(.*)/i, (res) ->
#    robot.brain.set key_kurasu, res.match[1]
#
#    kurasu = parseInt(getKakei(key_kurasu),10)
#
#    res.send """
#            予算設定しました！
#            「くらす」は#{kurasu}です。
#            """    
