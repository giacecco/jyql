# Dynamically downloads and add one script to the host web page
# Thanks to http://www.hunlock.com/blogs/Howto_Dynamically_Insert_Javascript_And_CSS and http://unixpapa.com/js/dyna.html
addScript = (script, callback) ->
  headID = document.getElementsByTagName("head")[0]
  newScript = document.createElement('script')
  newScript.type = 'text/javascript'
  if (script.match /^http[\s\S]*/)? # TODO: this could be better
    newScript.src = script
    # TODO: is there a way for the browser to fail gracefully if I can't load the script?
    newScript.onload = ->
      callback null # In reality I can't know if I was successful...
    headID.appendChild newScript
  else
    newScript.innerHTML = script
    headID.appendChild newScript
    callback null # How do I know if the script executed correctly?
  null


jyql = (query, namespace = 'jyql', callback) ->
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
  null

# found this trick at http://stackoverflow.com/questions/4214731/coffeescript-global-variables
root = exports ? this
root.jyql = jyql
