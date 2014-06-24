<%@ WebHandler Language="C#" Class="ImageHandler" %>

using System;
using System.Web;
using System.Configuration;
using System.Data.SqlClient;

//Convensor de binary data a imágenes

public class ImageHandler : IHttpHandler {
    private ImageHandler instancia;

    


    public ImageHandler getInstancia()
    {
        if (instancia == null)
        {
            instancia = new ImageHandler();
        }
        return instancia;       
    }
        
    
        public void ProcessRequest (HttpContext context) {
        string imageid = context.Request.QueryString["IdFoto"];

        Proyecto_Diseño.ConexionEspecificaABasedeDatos conexion = new Proyecto_Diseño.ConexionEspecificaABasedeDatos();
        System.Data.SqlClient.SqlConnection connection = new System.Data.SqlClient.SqlConnection();
        connection.ConnectionString = conexion.getHileradeConexion();
            
        connection.Open();
        SqlCommand command = new SqlCommand("select Foto from Foto where IdFoto="+imageid, connection);
        SqlDataReader dr = command.ExecuteReader();
        dr.Read();
        context.Response.BinaryWrite((Byte[])dr[0]);
        connection.Close();
        context.Response.End();              
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}

