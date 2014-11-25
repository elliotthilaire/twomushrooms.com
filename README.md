# README.md

This is the code behind http://photography.elliotthilaire.net

## Requirements

 - Ruby
 - ImageMagick

## Deployment

  1. bundle install
  2. Put images in ./content/featured, gallery, hidden
  3. Run rake assets:precompile
  4. Copy newrelic.yml file from New Relic into config/newrelic.yml
  5. Launch it.

## To do list

 - Refactor JS out of index page and turn it into a reusable module
 - Add next and previous buttons when viewing images in the gallery
 - Create a nicer watermark
 - Move images out of ./content/ folder and onto S3 or similar.

## Contribution

I would love for you to review my code and help me improve it.
Feel free to get in touch or fork and make pull requests.


