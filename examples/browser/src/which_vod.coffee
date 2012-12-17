$ ->

  interpretLovefilm = (data) ->
    films = []
    for row in data.query.results?.div
      film = {}
      do (row) =>
        film =
          title: row.div.div[1].div[0].h3.a.title
          starring: [ row.div.div[1].div[1].div.table.tr[0]?.td.a.content ]
          director: [ row.div.div[1].div[1].div.table.tr[1]?.td.a.content ]
          synopsis: row.div.div[1].div[0].div.p
        film.genre = [ row.div.div[1].div[1].div.table.tr[2]?.td.a.content ] if row.div.div[1].div[1].div.table.tr[2]?
        film.starring.push x.content for x in row.div.div[1].div[1].div.table.tr[0].td.p.a if row.div.div[1].div[1].div.table.tr[0].td.p?
        film.director.push x.content for x in row.div.div[1].div[1].div.table.tr[1].td.p.a if row.div.div[1].div[1].div.table.tr[1].td.p?
        film.genre.push x.content for x in row.div.div[1].div[1].div.table.tr[2].td.p.a if row.div.div[1].div[1].div.table.tr[2]?.td?.p?
        if not film.genre?
          film.genre = film.director
          film.director = film.starring
          film.starring = undefined
        films.push film
    return films
    
  searchString = 'heidi'
  q = 'select * from html where url="http://www.lovefilm.com/search/results/?q=' + escape(searchString) + '&items_per_page=100" and xpath=\'//div[@class=\"section glow listview\"]/div[@class=\"film_listing sd open fl_detail cf first_row\" or @class=\"film_listing sd open fl_detail cf\"]\''
  jyql q, (err, data) =>
    console.log data
    console.log interpretLovefilm(data)
