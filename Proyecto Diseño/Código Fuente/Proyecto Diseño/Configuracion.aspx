<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Configuracion.aspx.cs" Inherits="Proyecto_Diseño.Configuracion" %>
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
        #wrapper 
        { 
            width:800px;
        } 
        section 
        { 
            width: 600px; 
            float:left; 
        } 

        aside 
        { 
            width:400px; 
            float:left; 
        } 
    </style>   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <form id="form2" runat="server">
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

    <section class="jumbotron; img-responsive" style="background:#fff">
      
        <asp:Label ID="Label1" runat="server" Text="Cambiar la contraseña" style="font-family: 'Minya Nouvelle'; font-size: x-large;" ForeColor="#0182c3" CssClass="img-responsive"></asp:Label>
    <br/>
        <asp:Label ID="Label2" runat="server" Text="Ingresa el Correo Electrónico:" CssClass="img-responsive"></asp:Label>
    <br/>
        <asp:TextBox ID="correo" runat="server" Width="347px" CssClass="img-responsive"></asp:TextBox>
    <br/>
    <br/>
         <asp:Label ID="Label3" runat="server" Text="Ingresa la antigua contraseña:" CssClass="img-responsive"></asp:Label>
    <br/>
        <asp:TextBox ID="contrasena"  runat="server"  CssClass="img-responsive" Width="347px" TextMode="Password"></asp:TextBox>
    <br/>
    <br/>
        <asp:Label ID="Label4" runat="server" Text="Ingresa la nueva contraseña:" CssClass="img-responsive"></asp:Label>
    <br/>
        <asp:TextBox ID="contrasena2"  runat="server"   CssClass="img-responsive" TextMode="Password" Width="347px"></asp:TextBox>
    <br/>
    <br/>
        <a class="btn btn-primary btn-lg; img-responsive" id="iniciar" onclick="btnAccept_onclic();"  runat="server" role="button">Aceptar</a>       
    </section>        
    
    
    <aside class="jumbotron; img-responsive" style="background:#fff">
      
        <asp:Label ID="Label5" runat="server" Text="Recuperar Contraseña" style="font-family: 'Minya Nouvelle'; font-size: x-large;" ForeColor="#0182c3" CssClass="img-responsive"></asp:Label>
    <br/>
        <asp:Label ID="Label6" runat="server" Text="Ingresa el Correo Electrónico:" CssClass="img-responsive"></asp:Label>
    <br/>
        <asp:TextBox ID="correo1" runat="server" Width="347px" CssClass="img-responsive"></asp:TextBox>
    <br/>

    <asp:Button ID="Aceptar1" runat="server" Text="Aceptar" OnClick="RecuperarContraseña" CssClass="img-responsive" />

    </aside>


    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>

      <hr/>
    <section>
        <footer>
        <p>&copy; TURISMO LECOVA </p>
      </footer>
    </section>
      
<script type="text/javascript">
    function btnAccept_onclic() {

        var usuario = document.getElementById('<%= correo.ClientID %>').value;
        var contrasenaA = document.getElementById('<%= contrasena.ClientID %>').value;
        var contrasenaN = document.getElementById('<%= contrasena2.ClientID %>').value;
        var correoseparado = usuario.split("@");

        if (usuario != "" && contrasenaA != "" && contrasenaN != "") {
            if (correoseparado.length == 2) {
                var correoseparado2 = correoseparado[1].split(".");
                if (correoseparado2.length == 2) {

                    if (contrasenaA != contrasenaN) {
                        PageMethods.RenovarContrasena(usuario, contrasenaA,contrasenaN, onSuccess, onFailure);
                    }
                    else {
                        alert("Las contraseñas son iguales, para poderlas cambiar deben ser distintas");
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
            alert("Error debe de completar todos los campos para poder cambiar los datos");
        }
    }

    function onSuccess() {
        alert("Se cambió la contraseña correctamente");
        document.location.href = "Principal.aspx";
    }


    function onFailure() {
        alert("No se pudo cambiar la contraseña, la contraseña ingresada es incorrecta");

    }


</script>   
    


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>


        <script type="text/javascript">


            function onSuccess() {
                alert("Listo");
            }


            function onFailure() {
                alert("Error: ¿Introdujo un correo válido y anteriormente asociado a esta aplicación?");
            }


        </script>

    
    </form>



    
</asp:Content>


