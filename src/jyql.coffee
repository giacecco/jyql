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


jyql = (query, callback) ->
  # TODO: force the 'namespace' for temporary functions and variables to use the same name the jyql is available with 
  if not callback? or typeof callback isnt 'function'
    return null
  if not query? or query is ''
    return callback new Error('No query was specified'), null
  # I create a temporary global function to be called back by YQL and a 
  # temporary global variable to store its data
  randomName = 'jyql_' + Math.random().toString(36).substr(2, 7)
  callbackFunctionSource = "var " + randomName + "_data = { };\nvar " + randomName + "_function = function (data) { " + randomName + "_data = data; };"
  # I add the temporary variable and function to the host web page's head 
  addScript callbackFunctionSource, =>
    # TODO: https should be chosen if the host page has been served in ssl, otherwise the browser could refuse access for security reasons
    addScript "http://query.yahooapis.com/v1/public/yql?format=json&callback=" + escape(randomName + '_function') + "&q=" + escape(query), (err) =>
      # I check for any errors returned by YQL 
      if not err and eval(randomName + '_data').error?
        err = new Error(eval(randomName + '_data').error.description)
      callback err, eval(randomName + '_data')
  null

# found this trick at http://stackoverflow.com/questions/4214731/coffeescript-global-variables
root = exports ? this
root.jyql = jyql
