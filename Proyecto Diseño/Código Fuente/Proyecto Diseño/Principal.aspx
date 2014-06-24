<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Principal.aspx.cs" Inherits="Proyecto_Diseño.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"> 

    
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="http://fonts.googleapis.com/css?family=Oswald" rel="stylesheet" type="text/css" />
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="jumbotron.css" rel="stylesheet"/>
    
    
    <style type="text/css">
        .auto-style1
        {
            width: 1250px;
            height: 900px;
        }
    </style>   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
 <div id="Div1" class="navbar navbar-inverse navbar-fixed-top" role="navigation" style="background:#0182c3" runat="server">
      <div id="Div2" class="container" runat="server">
        
        <div id="Div3" class="navbar-header" runat="server">
                    
          <button id="Button1" type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse" runat="server">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            
          </button>

            <a class="navbar-brand" href="Principal.aspx" style="font-family: 'Arial Black'; color:#000" >INICIO</a>
          
           
        </div>
        <div id="Div4" class="navbar-collapse collapse" runat="server">
          <form class="navbar-form navbar-right" role="form" action="Principal.aspx" id="ctrl2" runat="server">
            <asp:ScriptManager ID="ScriptMgr" runat="server" EnablePageMethods="true"></asp:ScriptManager> 
            <div id="Div8" class="form-group" runat="server">
              <a class="fb-login-button" data-max-rows="1" data-size="small" data-show-faces="false" data-auto-logout-link="false">Iniciar</a>
            </div>
            <div id="Div5" class="form-group" runat="server">
              <a class="btn bg-info" id="registrarse" href="Registro.aspx"  runat="server" role="button">Registrarse</a>
            </div>           
            <div id="Div6" class="form-group" runat="server">
              <input id="usuario" type="text" placeholder="Email" runat="server" class="form-control"/>
            </div>
            <div id="Div7" class="form-group" runat="server">
              <input id="contrasena" type="password" placeholder="Contraseña" runat="server" class="form-control"/>
            </div>
            <a class="btn btn-success" id="iniciar" onclick="btnAccept_onclic();"  runat="server" role="button">Iniciar Sesión</a>             
          </form>            
        </div>

       

      </div>
    </div>

    
    <div class="jumbotron">
      <div class="container; img-responsive">
        <br />
        <br />
        <br />
        <h1 style="font-family: 'Minya Nouvelle'; color: darkorange;">TOURIST APP</h1>
        <p>Bienvenido!</p>        
        <img src="img/principal.jpg" class="img-responsive" />
        <br />
        <p><a class="btn btn-primary btn-lg; img-responsive" onclick="Configuracion_onclic();" role="button">Configuraciones &raquo;</a></p>
      </div>
    </div>

    

      <hr/>

      <footer>
        <p>&copy; TURISMO LECOVA </p>
      </footer>  
    
    
    
<script type="text/javascript">
    function btnAccept_onclic() {

        var usuario1 = document.getElementById('<%= usuario.ClientID %>').value;
        var contrasena1 = document.getElementById('<%= contrasena.ClientID %>').value;
        if (usuario1 != "" && contrasena1 != "") {
            PageMethods.IniciarSesionUsuario(usuario1, contrasena1, onSuccess, onFailure);
        }
        else {
            onFailure2();
        }
    }




    function onSuccess() {
        var us = document.getElementById('<%= usuario.ClientID %>').value;
        var cont = document.getElementById('<%= contrasena.ClientID %>').value;


        document.location.href = "SesionIniciada.aspx?" + btoa("value=" + us + "&value2=" + cont);
    }

    


    function onFailure() {
        alert("Por favor, vuelve a introducir tu contraseña.");
    }
    function onFailure2() {
        alert("Error debe de completar ambos datos para poder iniciar sesión, sino proceda a registrarse");
    }



    function Configuracion_onclic() {

        document.location.href = "Configuracion.aspx";

    }

</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>



    

<div id="fb-root"></div>
<script>

    window.fbAsyncInit = function () {
        FB.init({
            appId: '408149929323471',
            cookie: true,  // enable cookies to allow the server to access 

            xfbml: true,  // parse social plugins on this page
            version: 'v2.0' // use version 2.0

        });
        FB.getLoginStatus(checkLogin);

        function authUser() {
            FB.login(checkLogin, { scope: 'email' });
        }

        function checkLogin(response) {
            FB.Event.subscribe('auth.authResponseChange', function (response) {
                if (response.status == 'connected') {
                    FB.api('/me', function (response) {
                        if (response.email != null) {
                            try {

                                document.location.href = "SesionIniciada.aspx?" + btoa("value=" + response.email);
                            }
                            catch (Exception) {
                                alert('No se pudo iniciar sesión mediante facebook');
                            }
                        }
                        else {
                            alert('No se pudo iniciar sesión mediante facebook');
                        }
                    });

                }
            });
        }

    };
    // Load the SDK asynchronously
    (function (d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));


</script>
</asp:Content> 



    


