globHtml = require 'glob-html'

module.exports = (grunt) ->
  grunt.registerMultiTask 'glob', 'Expand or concatenate globbed files', ->
    done = @async()
    options = this.options(
      concat: false
      minimify: false
      minimifyCss: false
      minimifyJs: false
      overwrite: true
      tempPath: '/tmp/'
      tidy: true
      group: 'application'
      jsPrefix: 'js'
      cssPrefix: 'css'
    )

    this.files.forEach (f) ->
      src = f.src?[0]
      return unless src?
      globHtml.processFile src, options, (err) ->
        if err?
          grunt.log.error "Failed to compile: #{err}"
          grunt.fail.warn "glob task failed"
        done()
