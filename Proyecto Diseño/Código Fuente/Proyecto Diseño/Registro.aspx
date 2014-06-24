<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="Proyecto_Diseño.Registro" %>
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
        #contrasena
        {
            width: 349px;
        }
    </style>   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptMgr" runat="server" EnablePageMethods="true"></asp:ScriptManager>             
    
 <div id="Div1" class="navbar navbar-inverse navbar-fixed-top" role="navigation" style="background:#0182c3" runat="server">
      <div id="Div2" class="container" runat="server">
        <div id="Div3" class="navbar-header" runat="server">          
          <a class="navbar-brand" href="Principal.aspx" style="font-family: 'Arial Black'; color:#000" >INICIO</a>           
        </div>
      </div>
    </div>
 

    <br/>
    <br/>
    <br/>
    <br/>
    <br/>

    <div class="jumbotron" style="background:#fff">
      
        <asp:Label ID="Label1" runat="server" Text="Regístrate" style="font-family: 'Minya Nouvelle'; font-size: x-large;" ForeColor="#0182c3" CssClass="img-responsive"></asp:Label>
    <br/>
        <asp:Label ID="Label2" runat="server" Text="Ingresa el Correo Electrónico:" CssClass="img-responsive"></asp:Label>
    <br/>
        <asp:TextBox ID="correo" runat="server" Width="347px" CssClass="img-responsive"></asp:TextBox>
    <br/>
    <br/>
         <asp:Label ID="Label3" runat="server" Text="Ingresa una contraseña:" CssClass="img-responsive"></asp:Label>
    <br/>
        <asp:TextBox ID="contrasena"  runat="server"  CssClass="img-responsive" Width="347px" TextMode="Password"></asp:TextBox>
    <br/>
    <br/>
        <asp:Label ID="Label4" runat="server" Text="Vuelve a escribir la contraseña:" CssClass="img-responsive"></asp:Label>
    <br/>
        <asp:TextBox ID="contrasena2"  runat="server"   CssClass="img-responsive" TextMode="Password" Width="347px"></asp:TextBox>
    <br/>
    <br/>
        <a class="btn btn-primary btn-lg; img-responsive" id="iniciar" onclick="btnAccept_onclic();"  runat="server" role="button">Aceptar</a>       
    </div>        
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>

      <hr/>

      <footer>
        <p>&copy; TURISMO LECOVA </p>
      </footer>
<script type="text/javascript">
    function btnAccept_onclic() {

        var usuario = document.getElementById('<%= correo.ClientID %>').value;
        var contrasena = document.getElementById('<%= contrasena.ClientID %>').value;
        var contrasena2 = document.getElementById('<%= contrasena2.ClientID %>').value;
        var correoseparado = usuario.split("@");
        
        if (usuario != "" && contrasena != "" && contrasena2 != "" )
        {
            if (correoseparado.length == 2) {
                var correoseparado2 = correoseparado[1].split(".");
                if (correoseparado2.length == 2) {

                    if (contrasena == contrasena2)
                    {
                        if (esValida(contrasena)){
                            PageMethods.Registrarse(usuario, contrasena, onSuccess, onFailure);
                        }

                        else {
                            alert("Las contraseñas sólo puede contener números o letras");
                       }

                    }
                    else {
                        alert("Las contraseñas no coinciden, deben ser iguales");
                    }
                }

                else {
                    alert("Correo inválido, ingrese un correo válido");

                }

            }

            else {
                alert("Correo inválido, ingrese un correo válido");
            }
        }
        else {
            alert("Error debe de completar todos los campos para poder registrarse");
        }
    }

    function onSuccess() {
        alert("El usuario se registró correctamente");
        document.location.href = "Principal.aspx";
    }


    function onFailure() {
        alert("Falló el registro debido a que el usuario ya se encontraba registrado previamente");
        
    }

    function esValida(pwd) {
        
            var numaric = pwd;
            for (var j = 0; j < numaric.length; j++) {
                var alphaa = numaric.charAt(j);
                var hh = alphaa.charCodeAt(0);
                if ((hh > 47 && hh < 58) || (hh > 64 && hh < 91) || (hh > 96 && hh < 123)) {
                }
                else {
                    return false;
                }
            }
           
            return true;
        

    }


</script>   
    


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>



    
    </form>



    
</asp:Content>

