{exec} = require 'child_process'

COFFEE_EXEC = './node_modules/coffee-script/bin/coffee'

task 'build:library', 'Rebuild the jyql library', ->
  exec COFFEE_EXEC + ' -c -o lib/ src/', (err, stdout, stderr) ->
    console.log stderr + '\n' + stdout if stderr or stdout

task 'build:test', 'Rebuild the jyql tests', ->
  exec COFFEE_EXEC + ' -c --bare -o test/ test/src/', (err, stdout, stderr) ->
    console.log stderr + '\n' + stdout if stderr or stdout

task 'build:examples', 'Rebuild the jyql examples', ->
  exec COFFEE_EXEC + ' -c -o examples/lib/ examples/src/', (err, stdout, stderr) ->
    console.log stderr + '\n' + stdout if stderr or stdout
    