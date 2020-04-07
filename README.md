# SimplyInv
 
 SimpleInv is an inventory management platform built using Ruby on Rails and Bootstrap 4.
 
 ## Purpose
 
 This project was created for a local boutique store owner who needed to keep track of their shop's inventory but did
 not want to go with a full blown system such as Shopify or other stock management tools.
 
 It's basic, opinionated and get's a very specific job done.
 
 ## Heroku
 
 The webapp is hosted for free using Heroku [here](https://simpleinvsite.herokuapp.com/).
 
 A `Procfile` is included if you wish to do the same.
 
 ## Random Bits
 
 The app uses `Lockup` gem to codeword protect the site. It's a simple form of admin login. You can use the heroku site with the following codeword = `simpleinv`.
 
 The site uses `wicked_pdf` to render qrcode labels for easy printing. This is backed by `wkhtmltopdf` under the hood.
 
 ## ENV Vars
 
 The following ENV vars need to be set:
 - `LOCKUP_CODEWORD`: Lockup codeword to access site.
 - `LOCKUP_HINT`: Lockup codeword hint.
 - `SITE_HASH_SALT`: A String salt for `hashids` gem.
 - `SITE_NAME`: The name to display in the navigation header.

 ## License
 
 The code has been open soured using an Unlicense with the permission of the original client. 
