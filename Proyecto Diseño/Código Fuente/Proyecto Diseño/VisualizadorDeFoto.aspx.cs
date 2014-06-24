using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto_Diseño
{
    //Pantalla para ver las imágenes subidas por un usuario
    public partial class VisualizadorDeFoto : System.Web.UI.Page
    {
        System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection();
        DataTable dt = new DataTable();
        

        protected void Page_Load(object sender, EventArgs e)
        {

            //Se verifica que el usuario que haya iniciado sesión
            if (!IsPostBack)
            {
  
                    HttpCookie solicitarCookie;
                    solicitarCookie = Request.Cookies["TouristApp"];

                    try
                    {
                        if (solicitarCookie == null)
                        {
                            solicitarCookie.GetType();
                        }
                        else{
                            extraerFotos();
                        }


                    }

                    catch (Exception)
                    {
                        Response.Redirect("Principal.aspx", false);

                    }
                }
            
        
        }


        //Método para extrar las fotos de la base de datos y mostrarlas en pantalla
        protected void extraerFotos()
        {
            try
            {
                //Tomar el nombre de usuario
                HttpCookie solicitarCookie;
                solicitarCookie = Request.Cookies["TouristApp"];
                char[] usuariotemp = solicitarCookie.Value.ToCharArray();
                string usuario = "";
                bool bandera = false;
                //Se obtiene el usuario limpiando los valores obtenidos de la cookie
                foreach (char value in usuariotemp)
                {
                    if (bandera)
                    {
                        usuario = usuario + value;
                    }
                    else if (value.Equals('-'))
                    {
                        bandera = true;
                    }
                }

                UsuarioNoAdministrador user = UsuarioNoAdministrador.getUsuario(usuario);
                if (!user.abusoEnConsultas())
                {
                    ConexionEspecificaABasedeDatos conexion = new ConexionEspecificaABasedeDatos();
                    System.Data.SqlClient.SqlConnection connection = new System.Data.SqlClient.SqlConnection();
                    connection.ConnectionString = conexion.getHileradeConexion();
                    SqlCommand command = new SqlCommand("SELECT  Comentario,IdFoto from [Foto] where Usuario='" + usuario + "' Order by IdFoto Desc", connection);
                    SqlDataAdapter ada = new SqlDataAdapter(command);
                    ada.Fill(dt);
                    gridImagenes.DataSource = dt;
                    gridImagenes.DataBind();
                    user.cantidadDeConsultas = user.cantidadDeConsultas + 1;
                }
                else {
                    ClientScript.RegisterStartupScript(GetType(), "onFailure", "onFailure()", true);

                }


            }
            catch { }
   





        }

        


    }
}