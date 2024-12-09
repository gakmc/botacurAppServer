const mix = require('laravel-mix');



mix.js('resources/js/app.js', 'public/js')
   .sass('resources/sass/app.scss', 'public/css')
   .sass('resources/sass/403.scss', 'public/css');
 
 
 
 
//    .browserSync({
//       proxy: 'botacura.com',
//       socket: {
//          clients: true,
//       },
//       files: [
//          'app/**/*.php',
//          'resources/views/**/*.php',
//          'public/js/**/*.js',
//          'public/css/**/*.css',
//       ]
//   });
  
  // .browserSync({
  //    proxy: 'botacura.com',
     
  //    files: [
  //       'app/**/*.php',
  //       'resources/views/**/*.php',
  //       'public/js/**/*.js',
  //       'public/css/**/*.css',
  //    ]
  // });