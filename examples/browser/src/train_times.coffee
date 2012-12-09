$ ->

  interpretNationalRailData = (nationalRailData) ->
    data = [ ]
    rawData = nationalRailData
    rawData = rawData?.query?.results?.tr or [ ]  
    for row in rawData
      do (row) =>
        tempData = 
          arrivalTime: row.td[0]?.p,
          source: row.td[1]?.p,
          status: row.td[2]?.p,
          platform: row.td[3]?.p,
          detailsURL: "http://ojp.nationalrail.co.uk" + row.td[4]?.a.href if row.td[4]?
        data.push tempData
    return data

  q = "select * from html where url='http://ojp.nationalrail.co.uk/service/ldbboard/dep/EUS/BKM/To' and xpath='//div[@class=\"tbl-cont\"]/table/tbody/tr'"
  jyql q, (err, data) =>
    $('#listOfTrains').append '<tr><td>' + train.arrivalTime + '</td><td>' + train.source + '</td><td>' + train.status + '</td></tr>' for train in interpretNationalRailData(data)
    $('#loadingMessage').html 'err was: ' + err
