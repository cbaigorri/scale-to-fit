module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig

    # Metadata.
    pkg: grunt.file.readJSON("ScaleToFit.jquery.json")
    banner: "/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - " + "<%= grunt.template.today(\"yyyy-mm-dd\") %>\n" + "<%= pkg.homepage ? \"* \" + pkg.homepage + \"\\n\" : \"\" %>" + "* Copyright (c) <%= grunt.template.today(\"yyyy\") %> <%= pkg.author.name %>;" + " Licensed <%= _.pluck(pkg.licenses, \"type\").join(\", \") %> */\n"

    # Task configuration.
    clean:
      files: ["dist"]

    coffee:
      compile:
        files: 'src/scaleToFit.js': 'src/scaleToFit.coffee'

    concat:
      options:
        banner: "<%= banner %>"
        stripBanners: true

      dist:
        src: ["src/<%= pkg.name %>.js"]
        dest: "dist/<%= pkg.name %>.js"

    uglify:
      options:
        banner: "<%= banner %>"

      dist:
        src: "<%= concat.dist.dest %>"
        dest: "dist/<%= pkg.name %>.min.js"

    qunit:
      files: ["test/**/*.html"]

    jshint:
      gruntfile:
        options:
          jshintrc: ".jshintrc"
        src: "Gruntfile.coffee"

      # src:
      #   options:
      #     jshintrc: "src/.jshintrc"
      #   src: ["src/**/*.js"]

      test:
        options:
          jshintrc: "test/.jshintrc"
        src: ["test/**/*.js"]

    watch:
      gruntfile:
        files: "<%= jshint.gruntfile.src %>"
        tasks: ["jshint:gruntfile"]

      src:
        files: "src/scaleToFit.coffee"
        tasks: ["default"]

      test:
        files: "<%= jshint.test.src %>"
        tasks: ["jshint:test", "qunit"]


  # These plugins provide necessary tasks.
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-qunit"
  grunt.loadNpmTasks "grunt-contrib-jshint"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-coffee"

  # Default task.
  # grunt.registerTask "default", ["coffee", "jshint", "qunit", "clean", "concat", "uglify"]
  grunt.registerTask "default", ["coffee", "clean", "concat", "uglify"]

