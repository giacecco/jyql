# This should be compiled using the --bare option, as it refers QUnit methods in the global scope without using 'this' for readibility

module 'jyql.test.realQueries'

asyncTest 'Fetch real data from Yahoo! Finance and check that the JSON structure is the expected one', 1, =>
  # Example from Yahoo! YQL console: http://developer.yahoo.com/yql/console/?q=select%20*%20from%20csv%20where%20url%3D'http%3A%2F%2Fdownload.finance.yahoo.com%2Fd%2Fquotes.csv%3Fs%3DYHOO%2CGOOG%2CAAPL%26f%3Dsl1d1t1c1ohgv%26e%3D.csv'%20and%20columns%3D'symbol%2Cprice%2Cdate%2Ctime%2Cchange%2Ccol1%2Chigh%2Clow%2Ccol2'
  q = "select * from csv where url='http://download.finance.yahoo.com/d/quotes.csv?s=YHOO,GOOG,AAPL&f=sl1d1t1c1ohgv&e=.csv' and columns='symbol,price,date,time,change,col1,high,low,col2'"
  jyql q, (err, data) =>
    ok not err? and
      # checking if the number of results is the right one
      data?.query?.count is 3 and
        # and the symbols are the right ones and in the specified order
        data?.query?.results?.row[0].symbol is "YHOO" and
        data?.query?.results?.row[1].symbol is "GOOG" and
        data?.query?.results?.row[2].symbol is "AAPL" and
        # and each of the above has the properties it is supposed to have
        data?.query?.results?.row?.reduce (allOk, r) =>
          (allOk ?= true) and r.price? and r.time? and r.change? and 
            r.col1? and r.high? and r.low? and r.col2?
    start()
    