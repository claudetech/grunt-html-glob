globHtml = require 'glob-html'
_        = require 'lodash'

module.exports = (grunt) ->
  grunt.registerMultiTask 'glob', 'Expand or concatenate globbed files', ->
    done = @async()
    baseOptions = this.options(
      concat: false
      minify: false
      minifyCss: false
      minifyJs: false
      tempPath: '/tmp/'
      tidy: true
      group: 'application'
      jsPrefix: 'js'
      cssPrefix: 'css'
    )

    return done() if @files.length == 0

    count = 0
    @files.forEach (f) =>
      src = f.src?[0]
      return unless src?
      options = _.extend({output: f.dest}, baseOptions)
      globHtml.processFile src, options, (err) =>
        if err?
          grunt.log.error "Failed to compile: #{err}"
          grunt.fail.warn "glob task failed"
        count += 1
        done() if count == @files.length
