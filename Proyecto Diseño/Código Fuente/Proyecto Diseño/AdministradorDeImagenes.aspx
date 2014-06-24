<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AdministradorDeImagenes.aspx.cs" Inherits="Proyecto_Diseño.AdministradorDeImagenes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Tourist App</title>
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
    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation" style="background:#0182c3">
      <div class="container">
        <div class="navbar-header" >
          <a class="navbar-brand" href="SesionIniciada.aspx" style="font-family: 'Arial Black'; color:#000" >INICIO</a>
          <a class="navbar-brand" href="AdministradorDeImagenes.aspx" style="font-family: 'Arial Black'; color:#000" >Subir Foto</a>
          <a class="navbar-brand" href="VisualizadorDeFoto.aspx" style="font-family: 'Arial Black'; color:#000" >Mis Fotos</a>
                    
          

            
         </div>

                  
        </div>
      </div>
     
    <br />     
    <br />
    <br />
    <br /> 
      <div class="container">                           
        <img src="img/SesionIniciada.jpg" class="img-responsive" />               
      </div>
      <hr/>     
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <form id="form2" runat="server" class="img-responsive">
        <div>
            <p>
                <asp:Label ID="Label1" AssociatedControlID="fileUploader1" runat="server" CssClass="img-responsive" Style="font-family: 'Minya Nouvelle'; color: seagreen; font-size: larger"
                    Text="Seleccionar una imagen:" />
                <br />
                <br />
                <asp:FileUpload ID="fileUploader1" runat="server" CssClass="img-responsive" />
            </p>
            <br />
            <asp:Literal ID="literalMensaje" runat="server" />
            <br />
            <br />
            <div>
                <p>
                    <asp:Label ID="Label2" runat="server" Text="Escribe un comentario:" CssClass="img-responsive" />
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="img-responsive" Width="234px"></asp:TextBox>
                </p>
                <br />
                <br />
                <asp:Button ID="cargarImagen" runat="server"
                    Text="Cargar imágenes" OnClick="cargarImagenes_Click" CssClass="img-responsive" />
               </div>


            <div class="auto-style1">

                <style type="text/css">
                    .auto-style1
                    {
                        width: 1250px;
                        height: 900px;
                        margin-top: 61px;
                    }
                </style>
            </div>
        </div>
        <script type="text/javascript">


            function onSuccess() {
                alert("Listo");
            }


            function onFailure() {
                alert("Error desconocido al subir la imagen");
            }


        </script>

        </form>
</asp:Content>


