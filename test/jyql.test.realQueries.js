// Generated by CoffeeScript 1.4.0
var _this = this;

module('jyql.test.realQueries');

asyncTest('Fetch real data from Yahoo! Finance and check that the JSON structure is the expected one', 1, function() {
  var q;
  q = "select * from csv where url='http://download.finance.yahoo.com/d/quotes.csv?s=YHOO,GOOG,AAPL&f=sl1d1t1c1ohgv&e=.csv' and columns='symbol,price,date,time,change,col1,high,low,col2'";
  return jyql(q, function(err, data) {
    var _ref, _ref1, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7, _ref8, _ref9;
    ok(!(err != null) && (data != null ? (_ref = data.query) != null ? _ref.count : void 0 : void 0) === 3 && (data != null ? (_ref1 = data.query) != null ? (_ref2 = _ref1.results) != null ? _ref2.row[0].symbol : void 0 : void 0 : void 0) === "YHOO" && (data != null ? (_ref3 = data.query) != null ? (_ref4 = _ref3.results) != null ? _ref4.row[1].symbol : void 0 : void 0 : void 0) === "GOOG" && (data != null ? (_ref5 = data.query) != null ? (_ref6 = _ref5.results) != null ? _ref6.row[2].symbol : void 0 : void 0 : void 0) === "AAPL" && (data != null ? (_ref7 = data.query) != null ? (_ref8 = _ref7.results) != null ? (_ref9 = _ref8.row) != null ? _ref9.reduce(function(allOk, r) {
      return (allOk != null ? allOk : allOk = true) && (r.price != null) && (r.time != null) && (r.change != null) && (r.col1 != null) && (r.high != null) && (r.low != null) && (r.col2 != null);
    }) : void 0 : void 0 : void 0 : void 0));
    return start();
  });
});
