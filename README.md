jyql
====

![nodei.co npm status](https://nodei.co/npm/jyql.png)

Jyql is a browser-based and Node.js JavaScript library for fetching text-based 
data (html, JSON, XML, RSS feeds...) from any Internet source using the Yahoo! 
Query Language engine (http://developer.yahoo.com/yql/ also known as YQL) as a 
proxy. It is as simple as...

    <script src="dist/jyql-min.js"></script>
    <script>
      // Get the estimated arrival times of live trains from Berkhamsted to Euston
      var q = "select * from html where url='http://ojp.nationalrail.co.uk/service/ldbboard/dep/EUS/BKM/To' and xpath='//div[@class=\"tbl-cont\"]/table/tbody/tr'";
      jyql(q, function (err, data) { console.log(data); });
    </script>

The real value added of using jyql comes from implementing it client side, 
within the browser, as jyql allows you to transparently manage the 
cross-scripting limitations that most mainstream web browsers implement for 
security reasons, without making your web page necessarily less secure though. 
At runtime, under the bonnet, jyql transforms all your queries for external 
data into YQL JSONP script includes. If you don't know what this means, 
thanks to jyql you may not need to :-)

Jyql does not change anything of the query string YQL expects, nor of the JSON 
YQL it produces, so it is also very easy for you to test your queries directly 
against [YQL's interactive console](http://developer.yahoo.com/yql/console/).

It is just for consistency across browser and server code that jyql is designed 
to be used also on the server as a Node.js module and it is published in 
[npm](https://npmjs.org/package/jyql). Node.js, though, has plenty of 
alternative ways to fetch content from the Internet without cross-scripting 
limitations nor the need of using YQL.

Jyql would not exist without Yahoo!, so if you decide to use jyql be grateful 
to them and carefully read their terms of service and use referenced further 
down in this document.

![Powered by Yahoo!](http://l.yimg.com/a/i/ydn/poweredby-144x20.png)

I welcome suggestions, reviewers and contributors. Thanks!

# Why jyql
Today web browsers are powerful enough and suitable to fetch and transform data 
that is available from the Internet, to then assemble it together and present
it to the user. Traditionally this role is performed on the server, where 
computational power was less of an issue and the security of what content was
fetched could be better controlled.

Security is also the reason why the JavaScript implementation of most web
browsers won't allow client-side code to fetch data from websites that are 
different from the one the current web page is served from (e.g. read about 
cross-site request forgery 
[here](http://en.wikipedia.org/wiki/Cross-site_request_forgery)). This is a 
strong although due limitation for developers, that penalises in particular
the ones who are short on resources and cannot afford pushing to the server the
same functionality.

The Yahoo! Query Language engine solves a great part of this problem. It takes
the task of transforming the data one wants into a JSONP script she can then
import into her web page. Script imports are the only data retrieval operations
that are allowed cross-site, hence overriding the limitation described above. 
Read more about JSONP (here)[http://en.wikipedia.org/wiki/JSONP].

Jyql is a wrapper around Yahoo! Query Language, allowing you rely on the power 
of their services in a few lines of client-side JavaScript code. It can be as 
simple as in the example at the top of this document, that displays on the web
browser's JavaScript console the JSON output of a query.

#Requirements

## In the browser
None! 

## In Node.js
The beautifully simple [mikeal / request](https://github.com/mikeal/request).

## For developers
The source of jyql and all of its examples and test scripts are written in 
[CoffeeScript](http://coffeescript.org/) that is always compiled before being
used in tests or examples.

Jyql test scripts rely on the [QUnit](http://qunitjs.com/) framework and, for 
the time being, cover the web browser-based functionality of the library only. 

[Grunt](http://gruntjs.com) is used for packaging for distribution.

#Licensing

##Yahoo! Query Language Terms Of Use
By using jyql you are also accepting both Yahoo! terms of service at 
[http://info.yahoo.com/legal/us/yahoo/utos/utos-173.html](http://info.yahoo.com/legal/us/yahoo/utos/utos-173.html)
and Yahoo! Query Language's terms of use at [http://info.yahoo.com/legal/us/yahoo/yql/yql-4307.html](http://info.yahoo.com/legal/us/yahoo/yql/yql-4307.html).

##MIT license
Copyright (c) 2012 Gianfranco Cecconi.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.