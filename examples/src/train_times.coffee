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

  # Test this query directly on YQL's console at http://developer.yahoo.com/yql/console/?q=select%20*%20from%20html%20where%20url%3D%22http%3A%2F%2Fojp.nationalrail.co.uk%2Fservice%2Fldbboard%2Fdep%2FBKM%2FCLJ%2FTo%22%20and%0A%20%20%20%20%20%20xpath%3D'%2F%2Fdiv%5B%40class%3D%22tbl-cont%22%5D%2Ftable%2Ftbody%2Ftr'
  q = "select * from html where url='http://ojp.nationalrail.co.uk/service/ldbboard/dep/BKM/CLJ/To' and xpath='//div[@class=\"tbl-cont\"]/table/tbody/tr'"
  jyql q, (err, data) =>
    $('#listOfTrains').append '<tr><td>' + train.arrivalTime + '</td><td>' + train.source + '</td><td>' + train.status + '</td></tr>' for train in interpretNationalRailData(data)
    $('#loadingMessage').html ''
