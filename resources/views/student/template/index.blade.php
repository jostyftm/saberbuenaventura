<!DOCTYPE html>
<html lang="es">
   <head>
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
      <title>@yield('title')</title>

      <!-- Bootstrap -->
      <link href="{{ asset('plugin/bootstrap/css/bootstrap.css') }}" rel="stylesheet">
      <link href="{{ asset('plugin/font-awesome/css/font-awesome.min.css') }}" rel="stylesheet">
      <link href="{{ asset('css/default.css')}}" rel="stylesheet">
      <link href="{{ asset('css/student.css') }}" rel="stylesheet" type="text/css">
      <link href="{{ asset('css/preicfes.css') }}" rel="stylesheet" type="text/css">
      @yield('css')
   <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
   <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
   <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
   </head>
   <body>
      @include('student.template.header')
      <div class="container">
         <div class="row">
            @yield('content')
         </div>
      </div>
      {{-- <footer id="footerAd" class="clearfix">
         <div class="container-fluid">
            <div class="col-md-12">
               @include('student.template.footer')  
            </div>
         </div>       
      </footer> --}}
      <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
      <script src="{{ asset('plugin/jquery/jquery.min.js') }}"></script>
      <!-- Include all compiled plugins (below), or include individual files as needed -->
      <script src="{{ asset('plugin/bootstrap/js/bootstrap.min.js') }}"></script>
      @yield('js')
   </body>
</html>