module.exports = {
  paths: {
    watched: ['assets']
  },

  files: {
    // javascripts: {
    //   joinTo: 'javascripts/app.js'
    // },
    stylesheets: {
      joinTo: 'stylesheets/app.css'
    }
  },

  plugins: {
    sass: {
      mode: 'ruby' // set to 'native' to force libsass
    }
  },

  conventions: {
    assets: () => false // forces brunch to compile files in /assets folder
  }
}
