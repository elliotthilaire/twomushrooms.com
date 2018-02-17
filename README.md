# README.md

This is the code behind http://twomushrooms.com, a project to share some of the photos I have taken.

## Requirements

 - Ruby
 - ImageMagick

## Deployment

  ```
  bundle install
  bundle exec rackup

  ./build.sh
  ./sync-with-s3.sh
  ```

## To do list

 - Refactor JS out of index page and turn it into a reusable module
 - Add next and previous buttons when viewing images in the gallery

## Contribution

I would love for you to review my code and help me improve it.
Feel free to get in touch or fork and make pull requests.

## License

MIT
