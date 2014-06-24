<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="SesionIniciada.aspx.cs" Inherits="Proyecto_Diseño.SesionIniciada" %>
<%@ Register Assembly="GMaps" Namespace="Subgurim.Controles" TagPrefix="cc" %>

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
    
    
    <form id="Form1" role="form" runat="server"> 
    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation" style="background: #0182c3" runat="server">
        
        <asp:ScriptManager ID="ScriptMgr" runat="server" EnablePageMethods="true"></asp:ScriptManager>
        <div class="container" runat="server">
            <div class="navbar-header" runat="server">
                <button id="Button1" type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse" runat="server">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    

                </button>

                <a class="navbar-brand" href="SesionIniciada.aspx" style="font-family: 'Arial Black'; color: #000">INICIO</a>
                <a class="navbar-brand" href="AdministradorDeImagenes.aspx" style="font-family: 'Arial Black'; color: #000">Subir Foto</a>
                <a class="navbar-brand" href="VisualizadorDeFoto.aspx" style="font-family: 'Arial Black'; color: #000">Mis Fotos</a>


            </div>      
            <div class="navbar-form navbar-right">
                <div class="navbar-collapse collapse" runat="server">
                    <a class="btn btn-success" id="botonAdministrador" href="UsuarioAdministrador.aspx" role="button" runat="server">Administrativo</a>
                    <a class="btn btn-danger" id="cerrar" onclick="btnCerrar_onclic();" href="Principal.aspx" role="button" runat="server">Cerrar Sesión</a>                
                    
                </div>
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
    <br />
    <br />
    <br />
    <br />
        
    <br />    
    <br />
    <hr />


    


                    
         
    <section>
        
         
        <!--Variables para el manejo de las búsquedas de destinos-->
        Start Location:
        <asp:TextBox ID="tb_fromPoint" runat="server" meta:resourcekey="tb_fromPointResource1" CssClass="img-responsive"></asp:TextBox>
        <br />
        End Location:
        <asp:TextBox ID="tb_endPoint" runat="server" meta:resourcekey="tb_endPointResource1" CssClass="img-responsive"></asp:TextBox>
        <br />
        <input type="button" id="btn1" value="Trazar Ruta" class="img-responsive"/>
        <br />

        <!--Variables para el manejo de las búsquedas de destinos-->
        <asp:Button ID="btnSearch" runat="server" Text="Mostrar imágenes del destino" OnClick="btn1_clicked"  CssClass="img-responsive"/>
        <br />
        <br />
                       
            <cc:GMap ID="Mapa" runat="server"  CssClass="img-responsive; table-responsive"/>
        
                
        </section> 

    <aside class="img-responsive">
        <asp:DataList ID="dlSearch" runat="server" Width="463px" BackColor="White" 
            BorderColor="White" BorderStyle="None" BorderWidth="1px" CellPadding="4"
            CssClass="auto-style2; img-responsive" GridLines="Both" Height="16px"
            HorizontalAlign="Right"
            OnSelectedIndexChanged="dlSearch_SelectedIndexChanged1">
            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
            <ItemStyle BackColor="White" ForeColor="#003399" />
            <ItemTemplate>
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#Eval("Url") %>'><img src='<%#Eval("Url") %>' width="200" height="100"/></asp:HyperLink>
                <asp:LinkButton ID="LinkButton2" runat="server" Text='<%#Eval("Title") %>'
                    PostBackUrl='<%#Eval("OriginalContextUrl") %>' OnClick="LinkButton2_Click"> </asp:LinkButton><br />
                <br />
            </ItemTemplate>
            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
            <FooterTemplate>
                <asp:Label Visible='<%#bool.Parse((dlSearch.Items.Count==0).ToString())%>' runat="server"
                    ID="lblNoRecord" Text="No Record Found!"></asp:Label>
            </FooterTemplate>
            <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
        </asp:DataList>

        <br />

    </aside>
</form>
    

 


   
    <script type='text/javascript'>
        function btnCerrar_onclic() {
                       
            PageMethods.CerrarSesionUsuario(onSuccess, onFailure);
            
        }
            
        function onSuccess() {
            eraseCookie();
                document.location.href = "Principal.aspx";
       }
       function onFailure() {
           eraseCookie();
           document.location.href = "Principal.aspx";
       }

       function eraseCookie() {
           var d = new Date();
           document.cookie = "TouristApp=1;expires=" + d.toGMTString() + ";" + ";";
           
           
       }
        

        
    </script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</asp:Content>



