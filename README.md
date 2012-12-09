jyql
====

Jyql is a browser-based and Node.js JavaScript library for fetching data from 
any Internet source using the Yahoo! Query Language engine (YQL) as a proxy. 

The real value added of jyql comes from using it within the browser, as using
jyql allows you to override the cross-scripting limitations that most 
mainstream web browsers implements for security reasons, without making your 
web page less secure though. 

It is just for consistency across browser and server code that jyql is designed
to be used also on the server as a Node.js module. Node.js, though, has plenty 
of alternative ways to achieve the same results without the need of using YQL.

Jyql would not exist without Yahoo!, so be grateful to them and
carefully read their terms of service and use referenced further down in this 
document.

![Powered by Yahoo!](http://l.yimg.com/a/i/ydn/poweredby-144x20.png)

# Why jyql
Today web browsers are powerful enough and suitable to fetch and transform data 
that is available from the Internet, to then assemble it together and present
it to the user. Traditionally this role is performed on the server, where 
computational power was less of an issue and the security of what content was
fetched could be better controlled.

Security is also the reason why the JavaScript implementation of most web
browsers won't allow you to fetch scripts or data from domain names different
than the one the current web page is served from ([HERE GOES A LINK TO SOME
NICE WEB SITE THAT EXPLAINS THE PROBLEM IN MORE DETAIL]). This is a strong 
limitation for developers who are short on resources and cannot afford a 
'server component' to their applications.

The Yahoo! Query Language engine solves a great part of this problem, as it can
take the task of transform the data one wants to import into a JSONP script you
can import into your web page ([HERE GOES A LINK TO SOME NICE WEB SITE 
EXPLAINING JSONP]).

Jyql is a wrapper around Yahoo! Query Language, allowing you rely on the power 
of their services in a few lines of client-side JavaScript code. It can be as 
simple as in the example below, that displays on the web browser's JavaScript
console the JSON output of a query:

    <script src="jyql.js"></script>
    <script>
      // Get the estimated arrival times of live trains from Clapham
      // Junction to Berkhamsted
      var q = "select * from html where url='http://ojp.nationalrail.co.uk/service/ldbboard/dep/BKM/CLJ/To' and xpath='//div[@class=\"tbl-cont\"]/table/tbody/tr'";
      jyql(q, function (err, data) { console.log(data); });
    </script>

#Requirements

## In the browser
None! 

## In Node.js
The beautifully simple [mikeal / request](https://github.com/mikeal/request).

## For developers
The source of jyql and all of its examples and test scripts are written in 
[CoffeeScript](http://coffeescript.org/).

Jyql test scripts rely on the [QUnit](http://qunitjs.com/) framework and, for 
the time being, cover the web browser version only. 

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