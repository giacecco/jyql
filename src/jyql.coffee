# Detection of Node.js thanks to Underscore and 
# http://stackoverflow.com/a/5197219/1218376
IS_NODE = typeof module isnt 'undefined' and module.exports?

### ***************************************************************************
Browser only
*************************************************************************** ###
if not IS_NODE

  browser_fetch = (query, callback) ->
  
    # Dynamically injects JavaScript or downloads a JavaScript file into the host 
    # web page. Thanks to http://www.hunlock.com/blogs/Howto_Dynamically_Insert_Javascript_And_CSS 
    # and http://unixpapa.com/js/dyna.html
    addScript = (script, callback) ->
      headID = document.getElementsByTagName("head")[0]
      newScript = document.createElement('script')
      newScript.type = 'text/javascript'
      if (script.match /^http[\s\S]*/)? # TODO: this could be better
        newScript.src = script
        # TODO: is there a way for the browser to fail gracefully if I can't load the script?
        newScript.onload = =>
          callback null # In reality I can't know if I was successful...
        headID.appendChild newScript
      else
        newScript.innerHTML = script
        headID.appendChild newScript
        callback null # How do I know if the script executed correctly?
      null
  
    # I create a temporary global function to be called back by YQL and a 
    # temporary global variable to store its data
    randomName = 'jyql_' + Math.random().toString(36).substr(2, 7)
    callbackFunctionSource = "var " + randomName + "_data = { };\nvar " + randomName + "_function = function (data) { " + randomName + "_data = data; };"
    # I add the temporary variable and function to the host web page's head 
    addScript callbackFunctionSource, =>
      # Note the line below: YQL should be called in SSL if the host page is in 
      # SSL, otherwise browsers such as Chrome may complain
      protocol = "http" or window?.parent?.document?.location?.protocol
      addScript protocol + "://query.yahooapis.com/v1/public/yql?format=json&callback=" + escape(randomName + '_function') + "&q=" + escape(query), (err) =>
        # TODO: validation that YQL returned valid JSON is missing here,
        # the Node.js version has it
        callback err, eval(randomName + '_data')

### ***************************************************************************
Node.js only
*************************************************************************** ###
if IS_NODE

  request = require 'request'

  nodejs_fetch = (query, callback) ->
    requestURL = "http://query.yahooapis.com/v1/public/yql?format=json&q=" + escape(query)
    request requestURL, (err, response, body) =>
      data = null
      if not err and response.statusCode is 200
        try
          data = JSON.parse(body)
        catch err2
          err = new Error('YQL returned data that is not valid JSON')
      callback err, data


### ***************************************************************************
Common
*************************************************************************** ###
jyql = (query, callback) ->

  processYQLOutput = (err, data) =>
    # I check for any errors returned by YQL 
    if not err and data?.error
      err = new Error(data.error.description)
    callback err, data

  # Shared checks on the input parameters
  if not callback? or typeof callback isnt 'function'
    return null
  if not query? or query is ''
    return callback new Error('No query was specified'), null
  # Depending on context I fetch the JSON one way or the other
  return nodejs_fetch query, processYQLOutput if IS_NODE
  return browser_fetch query, processYQLOutput
  

return module.exports = jyql if IS_NODE
this.jyql = jyql
