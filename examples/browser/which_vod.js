// Generated by CoffeeScript 1.4.0
(function() {

  $(function() {
    var interpretLovefilm, q, searchString,
      _this = this;
    interpretLovefilm = function(data) {
      var film, films, row, _fn, _i, _len, _ref, _ref1,
        _this = this;
      films = [];
      _ref1 = (_ref = data.query.results) != null ? _ref.div : void 0;
      _fn = function(row) {
        var film, x, _j, _k, _l, _len1, _len2, _len3, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7, _ref8, _ref9;
        film = {
          title: row.div.div[1].div[0].h3.a.title,
          starring: [(_ref2 = row.div.div[1].div[1].div.table.tr[0]) != null ? _ref2.td.a.content : void 0],
          director: [(_ref3 = row.div.div[1].div[1].div.table.tr[1]) != null ? _ref3.td.a.content : void 0],
          synopsis: row.div.div[1].div[0].div.p
        };
        if (row.div.div[1].div[1].div.table.tr[2] != null) {
          film.genre = [(_ref4 = row.div.div[1].div[1].div.table.tr[2]) != null ? _ref4.td.a.content : void 0];
        }
        if (row.div.div[1].div[1].div.table.tr[0].td.p != null) {
          _ref5 = row.div.div[1].div[1].div.table.tr[0].td.p.a;
          for (_j = 0, _len1 = _ref5.length; _j < _len1; _j++) {
            x = _ref5[_j];
            film.starring.push(x.content);
          }
        }
        if (row.div.div[1].div[1].div.table.tr[1].td.p != null) {
          _ref6 = row.div.div[1].div[1].div.table.tr[1].td.p.a;
          for (_k = 0, _len2 = _ref6.length; _k < _len2; _k++) {
            x = _ref6[_k];
            film.director.push(x.content);
          }
        }
        if (((_ref7 = row.div.div[1].div[1].div.table.tr[2]) != null ? (_ref8 = _ref7.td) != null ? _ref8.p : void 0 : void 0) != null) {
          _ref9 = row.div.div[1].div[1].div.table.tr[2].td.p.a;
          for (_l = 0, _len3 = _ref9.length; _l < _len3; _l++) {
            x = _ref9[_l];
            film.genre.push(x.content);
          }
        }
        if (!(film.genre != null)) {
          film.genre = film.director;
          film.director = film.starring;
          film.starring = void 0;
        }
        return films.push(film);
      };
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        row = _ref1[_i];
        film = {};
        _fn(row);
      }
      return films;
    };
    searchString = 'heidi';
    q = 'select * from html where url="http://www.lovefilm.com/search/results/?q=' + escape(searchString) + '&items_per_page=100" and xpath=\'//div[@class=\"section glow listview\"]/div[@class=\"film_listing sd open fl_detail cf first_row\" or @class=\"film_listing sd open fl_detail cf\"]\'';
    return jyql(q, function(err, data) {
      console.log(data);
      return console.log(interpretLovefilm(data));
    });
  });

}).call(this);
