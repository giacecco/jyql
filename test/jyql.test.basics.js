// Generated by CoffeeScript 1.4.0
var _this = this;

module('jyql.test.basics');

asyncTest("If a callback is not specified, or it is not a function, jyql does nothing and returns null", 2, function() {
  var q;
  q = "select * from csv where url='http://download.finance.yahoo.com/d/quotes.csv?s=YHOO,GOOG,AAPL&f=sl1d1t1c1ohgv&e=.csv' and columns='symbol,price,date,time,change,col1,high,low,col2'";
  ok(jyql(q, void 0) === null);
  ok(jyql(q, 'foo') === null);
  return start();
});

asyncTest("If I don't specify a query or it is empty, the callback returns an error", 2, function() {
  jyql(void 0, function(err, data) {
    ok(((err != null ? err.message : void 0) === "No query was specified") && (data === null));
    return start();
  });
  return jyql('', function(err, data) {
    ok(((err != null ? err.message : void 0) === 'No query was specified') && (data === null));
    return start();
  });
});

asyncTest("If the query causes a syntax error, jyql returns the error", 1, function() {
  var gibberishQuery;
  gibberishQuery = 'safdgsadfafasfasdf';
  return jyql(gibberishQuery, function(err, data) {
    ok((err != null ? err.message : void 0) === "Query syntax error(s) [line 1:0 expecting statement_ql got '" + gibberishQuery + "']");
    return start();
  });
});
