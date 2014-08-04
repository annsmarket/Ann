module.exports = (grunt) ->
    grunt.loadNpmTasks('grunt-contrib-watch')
    grunt.loadNpmTasks('grunt-newer')

    grunt.registerMultiTask 'coffee', 'Compile CoffeeScript files into JavaScript', ->
        path = require('path')
        options = @options(
            bare: true
            separator: grunt.util.linefeed
        )
        grunt.verbose.writeflags options, 'Options'
        files = undefined
        if @files?
            files = @files
        else
            files = @data.files

        output = files[0].src.filter((filepath) ->
            if grunt.file.exists(filepath)
                true
            else
                grunt.log.warn 'Source file \'' + filepath + '\' not found.'
                false
        ).map((filepath) ->
            grunt.util.spawn
                cmd: 'coffee'
                args: ['-l', '-c', '-b', '-m', filepath]
                , (error, result, code) ->
                    grunt.log.error error
                    grunt.log.warn result
                    grunt.log.warn code
                    return

            compileCoffee filepath, options
        )

    compileCoffee = (srcFile, options) ->
        options = grunt.util._.extend filename: srcFile, options
        srcCode = grunt.file.read srcFile
        try
            return require('coffee-script').compile srcCode, options
        catch e
            grunt.log.error e
            grunt.fail.warn 'CoffeeScript failed to compile.'

    srcFiles = 'js/**/*.litcoffee'

    grunt.initConfig
        pkg: grunt.file.readJSON('package.json')

        coffee:
            all:
                options:
                    runtime: 'none'
                    compile: true
                    literate: true
                    sourceMap: true
                    src: srcFiles
            build:
                options:
                    runtime: 'none'
                    compile: true
                    literate: true
                    sourceMap: true
                    files: [{src: srcFiles}]

        watch:
            coffeescript:
                files: srcFiles
                tasks: ["newer:coffee:all"]
            javascript:
                files: "assets/**/*.js"
                tasks: ["uglify:dev"]
            livereload:
                files: ["Gruntfile.coffee", "js/*.js", "*.html"]
                options:
                    livereload: true

    grunt.registerTask 'default', [
        'watch'
    ]
