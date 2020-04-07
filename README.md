# SimplyInv
 
 SimpleInv is an inventory management platform built using Ruby on Rails and Bootstrap 4.
 
 ## Purpose
 
 This project was created for a local boutique store owner who needed to keep track of their shop's inventory but did
 not want to go with a full blown system such as Shopify or other stock management tools.
 
 It's basic, opinionated and get's a very specific job done.
 
 ## Heroku
 
 The webapp is hosted for free using Heroku [here]().
 
 A `Procfile` is included if you wish to do the same.
 
 ## Random Bits
 
 The app uses `Lockup` gem to codeword protect the site. It's a simple form of admin login. You can use the heroku site with the following codeword = `simpleinv`.
 
 The site uses `wicked_pdf` to render qrcode labels for easy printing. This is backed by `wkhtmltopdf` under the hood.

 ## License
 
 The code has been open soured using an Unlicense with the permission of the original client. 
