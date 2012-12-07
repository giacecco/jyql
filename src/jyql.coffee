# select * from html where url="http://ojp.nationalrail.co.uk/service/ldbboard/dep/BKM/CLJ/To" and xpath='//div[@class="tbl-cont"]/table/tbody/tr'
# at http://developer.yahoo.com/yql/console/?q=select%20*%20from%20html%20where%20url%3D%22http%3A%2F%2Fojp.nationalrail.co.uk%2Fservice%2Fldbboard%2Fdep%2FBKM%2FCLJ%2FTo%22%20and%0A%20%20%20%20%20%20xpath%3D'%2F%2Fdiv%5B%40class%3D%22tbl-cont%22%5D%2Ftable%2Ftbody%2Ftr'


interpretNationalRailData = ->
  data = [ ]
  rawData = nationalRailData
  rawData = rawData?.query?.results.tr or [ ]  
  _.each rawData, (row) ->
    tempData = 
      arrivalTime: (new Tempus()).timeString(row.td[0].p + ":00"),
      # arrivalTime: (new Tempus()).timeString(row.td[0].p) if row.td[0]?, 
      source: row.td[1]?.p,
      status: row.td[2]?.p,
      platform: row.td[3]?.p,
      detailsURL: "http://ojp.nationalrail.co.uk" + row.td[4]?.a.href if row.td[4]?
    data.push tempData
  return data


# Dynamically downloads and add one script to the host web page
# Thanks to http://www.hunlock.com/blogs/Howto_Dynamically_Insert_Javascript_And_CSS and http://unixpapa.com/js/dyna.html
addScript = (script, callback) ->
  headID = document.getElementsByTagName("head")[0]
  newScript = document.createElement('script')
  newScript.type = 'text/javascript'
  if (script.match /^http[\s\S]*/)? # TODO: this could be better
    newScript.src = script
    newScript.onload = ->
      callback null # In reality I can't know if I was successful...
    headID.appendChild newScript
  else
    newScript.innerHTML = script
    headID.appendChild newScript
    callback null # How do I know if the script executed correctly?
  null


yql = (query, namespace = '', callback) ->
  # I create a temporary global function to be called back by YQL and a temporary global variable to store its data
  namespace += '_' if namespace isnt ''
  randomDataName = namespace + Math.random().toString(36).substr(2, 7)
  randomCallbackName = namespace + Math.random().toString(36).substr(2, 7)
  callbackFunctionSource = "var " + randomDataName + " = { };\nvar " + randomCallbackName + " = function (data) { " + randomDataName + " = data; };"
  # I add the above to the host web page's head element
  addScript callbackFunctionSource, =>
    # TODO: https should be chosen if the host page has been served in ssl, otherwise the browser could complain
    addScript "http://query.yahooapis.com/v1/public/yql?format=json&callback=" + escape(randomCallbackName) + "&q=" + escape(query), (err) =>
      callback err, eval(randomDataName)


$ ->
  q = "select * from html where url='http://ojp.nationalrail.co.uk/service/ldbboard/dep/BKM/CLJ/To' and xpath='//div[@class=\"tbl-cont\"]/table/tbody/tr'"
  yql q, 'co_giacec_ButtaLaPasta', (err, data) ->
    # addScriptFromURL "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20html%20where%20url%3D%22http%3A%2F%2Fojp.nationalrail.co.uk%2Fservice%2Fldbboard%2Fdep%2FBKM%2FCLJ%2FTo%22%20and%0A%20%20%20%20%20%20xpath%3D'%2F%2Fdiv%5B%40class%3D%22tbl-cont%22%5D%2Ftable%2Ftbody%2Ftr'&format=json&callback=nationalRailCallback", ->
    console.log data
    