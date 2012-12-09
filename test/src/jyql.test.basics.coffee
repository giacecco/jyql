# This should be compiled using the --bare option, as it refers QUnit methods in the global scope without using 'this' for readibility

module 'jyql.test.basics'

asyncTest "If a callback is not specified, or it is not a function, jyql does nothing and returns null", 2, =>
  q = "select * from csv where url='http://download.finance.yahoo.com/d/quotes.csv?s=YHOO,GOOG,AAPL&f=sl1d1t1c1ohgv&e=.csv' and columns='symbol,price,date,time,change,col1,high,low,col2'"
  ok jyql(q, undefined) is null
  ok jyql(q, 'foo') is null
  start()

asyncTest "If I don't specify a query or it is empty, the callback returns an error", 2, =>
  jyql undefined, (err, data) =>
    ok (err?.message is "No query was specified") and (data is null)
    start()
  jyql '', (err, data) =>
    ok (err?.message is 'No query was specified') and (data is null)
    start()

asyncTest "If the query causes a syntax error, jyql returns the error", 1, =>
  gibberishQuery = 'safdgsadfafasfasdf'
  jyql gibberishQuery, (err, data) =>
    ok err?.message is "Query syntax error(s) [line 1:0 expecting statement_ql got '" + gibberishQuery + "']"
    start()
    