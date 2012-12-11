$ ->

  interpretNationalRailData = (nationalRailData) ->
    console.log nationalRailData
    data = [ ]
    rawData = nationalRailData
    rawData = rawData?.query?.results?.tr or [ ]  
    for row in rawData
      do (row) =>
        # TODO: what do I find in row.td[2] when a train is cancelled?
        tempData = 
          arrivalTime: row.td[0]?.p,
          actualArrivalTime: row.td[0]?.p, # this is just provisional
          source: row.td[1]?.p,
          platform: row.td[3]?.p,
          detailsURL: "http://ojp.nationalrail.co.uk" + row.td[4]?.a.href if row.td[4]?
        if (row.td[2].class is "status status-delay") or (row.td[2].class is "status" and row.td[2].p isnt "On time")
          # the train is delayed or early
          tempData.actualArrivalTime = row.td[2].p.content     
        data.push tempData
    return data

  getLiveArrivals = (from, to, callback) ->
    # validate this against http://ojp.nationalrail.co.uk/service/ldbboard/arr/EUS/WFJ/from
    q = "select * from html where url='http://ojp.nationalrail.co.uk/service/ldbboard/arr/" + to + "/" + from + "/From' and xpath='//div[@class=\"tbl-cont\"]/table/tbody/tr'"
    jyql q, (err, data) =>
      callback err, interpretNationalRailData(data)

  getLiveArrivals 'WFJ', 'EUS', (err, data) =>
    $('#listOfTrains').append '<tr><td>' + train.arrivalTime + '</td><td>' + train.source + '</td><td>' + train.actualArrivalTime + '</td></tr>' for train in data
    $('#loadingMessage').html 'err was: ' + err
