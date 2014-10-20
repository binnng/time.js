((WIN) ->

  YEAR = "year"
  MONTH = "month"
  DAY = "day"
  HOUR = "hour"
  MINUTE = "minute"
  SECOND = "second"

  DEFAULT_FORMAT = "%y-%M-%d %h:%m:%s"

  # 格式字符串含义字典
  map = 
    "%y": YEAR
    "%M": MONTH
    "%d": DAY
    "%h": HOUR
    "%m": MINUTE
    "%s": SECOND

  # `unify`
  # 统一时间戳的位数，并强制转换为`Number`类型
  # php可能传过来10位
  unify = (time) ->
    time -= 0
    time *= 1000 if "#{time}".length is 10
    time

  # `two`
  # 一位转换为两位
  two = (str) ->
    s = "#{str}"
    s = "0#{s}" if s.length is 1
    s

  # `replace`
  # 字符串多项替换
  # 把str里的src替换为dst
  replace = (str, src, dst) ->
    reg = new RegExp src, "g"
    str.replace reg, dst


  # `getFullTime`
  # 传入时间戳，返回时间Object
  # ```
  # var time = getTime(1413772288388); 
  # // => {year: 2014,month: 10,day: 20,hour: 10,minute: 31,second: 28}
  # ```
  getFullTime = (time) ->
    date = new Date(unify time)

    year: date.getFullYear()
    month: two (date.getMonth() + 1)
    day: two date.getDate()
    hour: two date.getHours()
    minute: two date.getMinutes()
    second: two date.getSeconds()


  time = 
    # `time.default`
    # 默认方法，定制生成时间格式
    default: (time, format) ->
      if format and (typeof format) isnt "string"
        throw new Error "format must be a string."

      fullTime = getFullTime time
      ret = format or DEFAULT_FORMAT

      for src of map
        ret = replace(ret, src, fullTime[map[src]])

      ret

    # `time.human`
    # 更加**人性化**的展示时间
    # 刚刚，一天前，一周前...
    human: (time) ->
      time = unify time
      int = parseInt

      curTime = +new Date()
      diff = curTime - time
      ago = ""

      if 1000 * 60 > diff
        ago = "刚刚"
      else if 1000 * 60 <= diff and 1000 * 60 * 60 > diff
        ago = int(diff / (1000 * 60)) + "分钟前"
      else if 1000 * 60 * 60 <= diff and 1000 * 60 * 60 * 24 > diff
        ago = int(diff / (1000 * 60 * 60)) + "小时前"
      else if 1000 * 60 * 60 * 24 <= diff and 1000 * 60 * 60 * 24 * 30 > diff
        ago = int(diff / (1000 * 60 * 60 * 24)) + "天前"
      else if 1000 * 60 * 60 * 24 * 30 <= diff and 1000 * 60 * 60 * 24 * 30 * 12 > diff
        ago = int(diff / (1000 * 60 * 60 * 24 * 30)) + "月前"
      else
        ago = int(diff / (1000 * 60 * 60 * 24 * 30 * 12)) + "年前"
      
      ago


  # 暴露出去
  entry = time.default
  entry.human = entry.ago = time.human

  if typeof module isnt "undefined" and module.exports
    module.exports = exports = entry

  else if typeof WIN["define"] is "function"
    define (require, exports, module) ->
      module.exports = exports = entry

  # 为angular定制的service
  else if typeof WIN["angular"] is "object"
    angularApp = angular.module("binnng/time", [])

    angularApp.factory "$time", -> entry
    angularApp.filter "ago", -> (time) -> entry.ago time
    angularApp.filter "date", -> (time) -> entry time, "%y年%M月%d日"
    angularApp.filter "datetime", -> (time) -> entry time, DEFAULT_FORMAT

  # 啥都不是，直接暴露到window
  else
    WIN["Time"] = entry


) window