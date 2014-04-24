module.exports = function(grunt) {

  // Project configuration.
  	grunt.initConfig({
	    pkg: grunt.file.readJSON('package.json'),

	    sass: {
	    	dist: {
		      	options: {
		        	style: 'compressed'
		      	},
		      	files: {
		        	'tmp/style.css': 'lib/style.scss'
		      	}
		    }
		},
		cssmin: {
		  	combine: {
		    	files: {
		      		'tmp/stylemin.css': ['lib/vendor/lemonade.css','lib/vendor/slides.css','lib/vendor/magnific.css','tmp/style.css']
		    	}
		  	}
		},
		autoprefixer: {
            dist: {
                files: {
                    'soundfreaq-theme-7783581/assets/style.css.liquid':['tmp/stylemin.css']
                }
            }
        },
        coffee: {
          compile: {
	            files: {
	              	'tmp/script.js': 'lib/script.coffee'
	            }
          	}
     	},
     	uglify: {
      		my_target: {
      		    files: {
      		    	'soundfreaq-theme-7783581/assets/script.js.liquid': ['lib/vendor/jquery.js','lib/vendor/cookie.js','lib/vendor/magnific.js','lib/vendor/slides.js','lib/vendor/scrollfix.js','tmp/script.js'],
      		    }
      		}
	    },
	    watch: {
	     	css: {
	        	files: 'lib/*.scss',
	        	tasks: ['sass','cssmin','autoprefixer'],
	        	options: {
	          		livereload: true,
	        	},
	      	},
	      	scripts: {
	      	    files: 'lib/*.coffee',
	      	    tasks: ['coffee','uglify']
	      	},
	    }

  	});

  // Load the plugin that provides the "uglify" task.
  
  	grunt.loadNpmTasks('grunt-contrib-uglify');
  	grunt.loadNpmTasks('grunt-contrib-sass');
  	grunt.loadNpmTasks('grunt-autoprefixer');
  	grunt.loadNpmTasks('grunt-contrib-coffee');
  	grunt.loadNpmTasks('grunt-contrib-watch');
  	grunt.loadNpmTasks('grunt-contrib-cssmin');

  	// Default task(s).
  	grunt.registerTask('default', ['uglify','sass','autoprefixer','coffee','watch','cssmin']);


};