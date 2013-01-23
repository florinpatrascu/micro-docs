<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
        "http://www.w3.org/TR/html4/strict.dtd">

<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta charset="utf-8">
    <title>Micro: $!{Tools.PathUtilities.extractName("$path")} </title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="author" content="Florin T.PATRASCU">


    <link href="/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">
    
    <link href='http://fonts.googleapis.com/css?family=Inconsolata' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="/styles/github.css" type="text/css" charset="utf-8" media="screen">
    <link rel="stylesheet" href="/styles/main.css" type="text/css" charset="utf-8" media="screen">

    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

</head>

<body>
    <div class="navbar navbar-static-top">
      <div class="navbar-inner">
        <div class="container">
          $partials.get("header.html")
        </div>
      </div>
    </div>

    <div class="github container">
      <div class="row">
        <div id="main" class="span8">
          $content.get("markdown", $path)
        </div>
        <div id="sidebar" class="span4">
          $partials.get("sidebar.html")
        </div>
      </div>
    </div>
    
    <footer>
      <div class="container">
        $partials.get("footer.html")
      </div>
    </footer>
    
    <a href="https://github.com/florinpatrascu/micro"><img style="position: absolute; top: 0; right: 0; border: 0;" src="http://s3.amazonaws.com/github/ribbons/forkme_right_gray_6d6d6d.png" alt="Fork me on GitHub" /></a>

    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.9.0.min.js"></script>
    <script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>
    <script src="/bootstrap/js/bootstrap.min.js"></script>

    
    ## Include Google analytics if the site runs in production mode
    #if($site.isProduction())
     $!partials.get("google_analytics.html")
    #end
    
</body>
</html>
