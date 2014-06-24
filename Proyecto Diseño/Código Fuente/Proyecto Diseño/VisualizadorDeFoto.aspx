<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="VisualizadorDeFoto.aspx.cs" Inherits="Proyecto_Diseño.VisualizadorDeFoto" %>


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
        
      <div class="container; img-responsive">                           
        <img src="img/SesionIniciada.jpg" class="img-responsive" />               
      </div>
      <hr/>     
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <form id="form2" runat="server" class="img-responsive">
    <div class="img-responsive;">
    <p>

      <asp:Label ID="Label1"  runat="server" style="font-family: 'Minya Nouvelle'; color: seagreen; font-size:larger" Text="Tus fotos:" CssClass="table-responsive; img-responsive" />
    </p>
   <div>
        <asp:GridView Width="500px" ID="gridImagenes" runat="server" AutoGenerateColumns="False" CssClass="table-responsive; img-responsive" CellPadding="4" ForeColor="#333333" GridLines="None" >
            <AlternatingRowStyle BackColor="White" />
            <Columns>            
                <asp:BoundField HeaderText = "¿De qué trata?" DataField="Comentario" ControlStyle-Width="500px" ItemStyle-Width="500px" >
<ControlStyle Width="500px"></ControlStyle>

<ItemStyle Width="500px"></ItemStyle>
                </asp:BoundField>
                <asp:TemplateField HeaderText="Imágenes" ControlStyle-Width="1000px" ItemStyle-Width="1000px" ControlStyle-CssClass="img-responsive">  
                 <ItemTemplate> 
                    <asp:Image ID="IdFoto" runat="server" ImageUrl='<%# "ImageHandler.ashx?IdFoto="+ Eval("IdFoto")  %>' CssClass="img-responsive"/> 
                 </ItemTemplate>

<ControlStyle CssClass="img-responsive" Width="1000px"></ControlStyle>

<ItemStyle Width="1000px"></ItemStyle>
            </asp:TemplateField>               
            </Columns>
            <EditRowStyle BackColor="#7C6F57" />
            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#E3EAEB" />
            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F8FAFA" />
            <SortedAscendingHeaderStyle BackColor="#246B61" />
            <SortedDescendingCellStyle BackColor="#D4DFE1" />
            <SortedDescendingHeaderStyle BackColor="#15524A" />
        </asp:GridView>
    
    </div>



        <div class="auto-style1">               
                 
<style type="text/css">
        .auto-style1
        {
            width: 1250px;
            height: 900px;
        }

    </style>
     </div>
    </div>

        
<script type="text/javascript">
    


    function onFailure() {
        alert("Se han detectado abusos en el uso de su cuenta!");

    }

    


</script>   
    
        
  </form>
</asp:Content>


