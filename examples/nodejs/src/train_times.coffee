jyql = require '../../lib/jyql'

console.log "This is the list of live trains from Berkhamsted to London Euston..."
q = "select * from html where url='http://ojp.nationalrail.co.uk/service/ldbboard/dep/EUS/BKM/To' and xpath='//div[@class=\"tbl-cont\"]/table/tbody/tr'"
jyql q, (err, data) ->
  console.log "err is: " + err
  console.log "data is: " + JSON.stringify data 