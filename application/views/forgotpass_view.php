<!DOCTYPE html>
<html class="no-js css-menubar" lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
  <meta name="description" content="CV Owl is a free Resume and CV Builder that helps to create a highly professional and recruiter preferred resume and CV that represents you a good fit for an open position you applying for.">
  <meta name="author" content="MayankAggarwal">
  <meta property="og:url"           content="http://www.cvowl.com/Home" />
  <meta property="og:type"          content="website" />
  <meta property="og:title"         content="CVowl" />
  <meta property="og:description"   content="World's Best and Free Online CV Builder - CV Owl" />
  <meta property="og:image"         content="http://www.cvowl.com/static/classic/topbar/assets/images/logo.png" />

  <title>World's Best and Free Online CV Builder - CV Owl</title>
  
  <link rel="manifest" href="/manifest.json">
  <meta name="viewport" content="width=device-width">
  <meta name="mobile-web-app-capable" content="yes">
  <link rel="icon" sizes="192x192" href="/128.png">
  <!-- Stylesheets -->
  <link rel="stylesheet" href="/static/classic/global/css/bootstrap.min.css">
  <link rel="stylesheet" href="/static/classic/global/css/bootstrap-extend.min.css">
  <link rel="stylesheet" href="/static/classic/topbar/assets/css/site.min.css">
  
  <!-- Plugins -->
  <link rel="stylesheet" href="/static/classic/global/vendor/animsition/animsition.css">
  <link rel="stylesheet" href="/static/classic/global/vendor/asscrollable/asScrollable.css">
  <link rel="stylesheet" href="/static/classic/global/vendor/offline/offline-language-english.css">
  <link rel="stylesheet" href="/static/classic/global/vendor/offline/offline-language-english-indicator.css">
  <link rel="stylesheet" href="/static/classic/global/vendor/offline/offline-theme-chrome.css">
  <!-- Fonts -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
  <link rel='stylesheet' href='http://fonts.googleapis.com/css?family=Roboto:300,400,500,300italic'>
  <!--[if lt IE 9]>
    <script src="/static/classic/global/vendor/html5shiv/html5shiv.min.js"></script>
    <![endif]-->
  <!--[if lt IE 10]>
    <script src="/static/classic/global/vendor/media-match/media.match.min.js"></script>
    <script src="/static/classic/global/vendor/respond/respond.min.js"></script>
    <![endif]-->
  <!-- Scripts -->
  <script src="/static/classic/global/vendor/modernizr/modernizr.js"></script>
  <script src="/static/classic/global/vendor/breakpoints/breakpoints.js"></script>
  <script src="/static/classic/global/vendor/offline/offline.min.js"></script>
  <script>
  Breakpoints();
  </script>
  <script type="application/ld+json">
       { 
         "@context" : "http://schema.org", 
         "@type" : "Organization", 
         "name" : "CV Owl", 
         "url" : "http://www.cvowl.com", 
         "sameAs" : [ "https://www.facebook.com/cvowl", "https://twitter.com/cvowl", "https://www.youtube.com/user/svowl", "https://plus.google.com/+cvowl"] 
       }
 </script>
</head>

<!-- <h1 id="landscape" style="display:none;">Site is not meant to be viewed in landscape mode</h1> -->
<body class="page-forgot-password layout-full">
  <!--[if lt IE 8]>
        <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
    <![endif]-->
  <div class="page animsition vertical-align text-center" data-animsition-in="fade-in"
  data-animsition-out="fade-out">
    <div class="page-content vertical-align-middle">
      <h2>Choose New Password</h2>
      <div class="wrong_input text-danger"></div>
      <p> &nbsp;</p>
      <form method="post" role="form" id="changepassword">
        <div class="form-group">
          <input type="password" class="form-control" id="pass" name="email" placeholder="New Password">
        </div>
        <div class="form-group">
          <input type="password" class="form-control" id="cpass" name="email" placeholder="Confirm Password">
        </div>
        <div class="form-group">
          <button type="submit" class="btn btn-primary btn-block"><strong>Reset Password</strong></button>
        </div>
      </form>
      <footer class="page-copyright">
        <p>CVowl</p>
        <p>© 2015. All RIGHT RESERVED.</p>
        <div class="social">
          <a href="javascript:void(0)">
            <i class="icon bd-twitter" aria-hidden="true"></i>
          </a>
          <a href="javascript:void(0)">
            <i class="icon bd-facebook" aria-hidden="true"></i>
          </a>
          <a href="javascript:void(0)">
            <i class="icon bd-dribbble" aria-hidden="true"></i>
          </a>
        </div>
      </footer>
    </div>
  </div>
  <!-- End Page -->
  <!-- Core  -->
  <script src="/static/classic/global/vendor/jquery/jquery.js"></script>
  <script src="/static/classic/global/vendor/bootstrap/bootstrap.js"></script>
  <script src="/static/classic/global/vendor/animsition/animsition.js"></script>
  
  <!-- Scripts -->
  <script src="/static/classic/global/js/core.js"></script>
  <script src="/static/classic/topbar/assets/js/site.js"></script>
  <script src="/static/classic/global/js/components/animsition.js"></script>
  <script>
  
  (function(document, window, $) {
    'use strict';
    var Site = window.Site;
    $(document).ready(function() {
      Site.run();
      $('form#changepassword').submit(function(e){
        e.preventDefault();
        var pass = $('#pass').val();
        var cpass = $('#cpass').val();
        if(pass == cpass){
          $('.wrong_input').html("");
          $.post('/home/changepassword',{newpass:pass,confpass:cpass},function(data){
            console.log(data);
            var obj = $.parseJSON(data);
            if(obj.resp == 1){
              location.reload();
            }else{
              alert(obj.msg);
            }
          });
        }else{
          $('.wrong_input').html("Passwords do not match");
          // alert('Password do not match');
        }
      })
    });
  })(document, window, jQuery);

  </script>
</body>
</html>