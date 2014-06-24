<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="UsuarioAdministrador.aspx.cs" Inherits="Proyecto_Diseño.UsuarioAdministrador" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content = "width = device-width, initial-scale = 1.0, minimum-scale = 1.0, maximum-scale = 1.0, user-scalable = no" />

    <title>Tourist App</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="http://fonts.googleapis.com/css?family=Oswald" rel="stylesheet" type="text/css" />
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="jumbotron.css" rel="stylesheet"/>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation" style="background: #0182c3">
        <div class="container">
            <div class="navbar-header">
                <a class="navbar-brand" href="SesionIniciada.aspx" style="font-family: 'Arial Black'; color: #000">INICIO</a>                
            </div>
        </div>
    </div>  
    <br /> 
    <br /> 
    <br /> 
    <br /> 

        
    <div class="container; img-responsive">
        <img src="img/SesionIniciada.jpg" class="img-responsive" />
    </div>
      <hr/> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">  
   
    <br /> 
    <br />         
    <br /> 
    
    <form id="form2" runat="server" class="img-responsive" >
    <div class="img-responsive;">
        <p>
        <asp:Label ID="Label3" runat="server" CssClass=" table-responsive; img-responsive" style="font-family: 'Minya Nouvelle'; color: seagreen; font-size:larger" Text="Cambiar a usuario administrador:" />
        </p>
        </div>

    
    
        <br />  
        <div class="table-responsive">
        <table>
        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="UsuarioEstandar" DataTextField="Email" DataValueField="Email" CssClass="table-responsive;img-responsive">
        </asp:DropDownList>
        <asp:SqlDataSource ID="UsuarioEstandar" runat="server" ConnectionString="<%$ ConnectionStrings:DiseñoConnectionString %>" SelectCommand="SELECT Email FROM Usuario Where Rol='E'"></asp:SqlDataSource>
        <asp:Button ID="Button1" runat="server" Text="Aceptar" OnClick="Button1_Click" />
        </table>
        </div>        
        <br />  
        <br /> 
        <div class="img-responsive;">
        <p>        
        <asp:Label ID="Label1" runat="server" CssClass=" table-responsive; img-responsive" style="font-family: 'Minya Nouvelle'; color: seagreen; font-size:larger" Text="Usuarios Conectados:" />
        </p>
        </div> 
        <br />  
        <div class="table-responsive">
        <table class="table">
        <asp:GridView ID="GridView1" Width="500px" runat="server" AutoGenerateColumns="False" CellPadding="3" DataKeyNames="Cookie" DataSourceID="UsuariosConectados" Height="255px"  BackColor="White" BorderColor="#CCCCCC"  BorderStyle="None" BorderWidth="1px">
            <Columns>
                                
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" ControlStyle-Width="500px" ItemStyle-Width="500px"  ControlStyle-CssClass="col-md-9 col-md-push-3"/>
                
                <asp:BoundField DataField="Cookie" HeaderText="Cookie" SortExpression="Cookie" ControlStyle-Width="500px" ItemStyle-Width="500px" ControlStyle-CssClass="col-md-9 col-md-push-3"/>
                
                <asp:BoundField DataField="Fecha" HeaderText="Fecha" SortExpression="Fecha" ControlStyle-Width="500px" ItemStyle-Width="500px" ControlStyle-CssClass="col-md-9 col-md-push-3"/>
                

                <asp:BoundField DataField="Rol" HeaderText="Rol" SortExpression="Rol" ControlStyle-Width="500px" ItemStyle-Width="500px" ControlStyle-CssClass="col-md-9 col-md-push-3"/>
                
            </Columns>
            <FooterStyle BackColor="White" ForeColor="#000066" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left"  />
            <RowStyle ForeColor="#000066" />
            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White"  />
            <SortedAscendingCellStyle BackColor="#F1F1F1"  />
            <SortedAscendingHeaderStyle BackColor="#007DBB"  />
            <SortedDescendingCellStyle BackColor="#CAC9C9"  />
            <SortedDescendingHeaderStyle BackColor="#00547E"  />
        </asp:GridView> 
        </table>
        

        <asp:SqlDataSource ID="UsuariosConectados" runat="server" ConnectionString="<%$ ConnectionStrings:DiseñoConnectionString %>" SelectCommand="SELECT Usuario.Email, UsuariosConectadosWeb.NumeroCookie as Cookie, UsuariosConectadosWeb.Fecha, Usuario.Rol FROM Usuario INNER JOIN UsuariosConectadosWeb ON Usuario.IdUsuario = UsuariosConectadosWeb.IdUsuario"></asp:SqlDataSource>

        <br /> 
        <div class="img-responsive;">
        <p>
        <asp:Label ID="Label2" runat="server" CssClass=" table-responsive; img-responsive" style="font-family: 'Minya Nouvelle'; color: seagreen; font-size:larger" Text="Cantidad de Sesiones por Usuario:" />
        </p>
        </div>
        </div>
        <div class="table-responsive">
        <table class="table">          

            

        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="CantidadSesionUsuarios">
            <Columns>
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email"  />
                <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" ReadOnly="True" SortExpression="Cantidad" ControlStyle-Width="500px" ItemStyle-Width="500px" />
            </Columns>
            <FooterStyle BackColor="White" ForeColor="#000066" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
            <RowStyle ForeColor="#000066" />
            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#007DBB" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#00547E" />
        </asp:GridView>
        </table>
        </div>
        
        


    
    
        <asp:SqlDataSource ID="CantidadSesionUsuarios" runat="server" ConnectionString="<%$ ConnectionStrings:DiseñoConnectionString %>" SelectCommand="SELECT Usuario.Email as Email, COUNT(UsuariosConectadosWeb.IdUsuario) AS Cantidad 
        FROM Usuario INNER JOIN UsuariosConectadosWeb ON Usuario.IdUsuario = UsuariosConectadosWeb.IdUsuario  
        Group by Email
        Order by Email desc">
        </asp:SqlDataSource>


    
    
        
        
        
        
   
    
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    
    


    </form>
    

</asp:Content>


