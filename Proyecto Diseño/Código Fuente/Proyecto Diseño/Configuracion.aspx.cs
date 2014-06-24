using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto_Diseño
{
    public partial class Configuracion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


        }
 


        //Este pérmite recuperar Contraseña
        public void RecuperarContraseña(object sender, EventArgs e)
        {
            try
            {

                string user = correo1.Text;
                String mensaje = "";
                ConexionEspecificaABasedeDatos conexion = new ConexionEspecificaABasedeDatos();
                System.Data.SqlClient.SqlConnection connection = new System.Data.SqlClient.SqlConnection();
                connection.ConnectionString = conexion.getHileradeConexion();
                connection.Open();

                SqlCommand command = new SqlCommand("Select Contrasena FROM Usuario Where Email='" + user + "'", connection);
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    mensaje = reader.GetString(0);
                }
                connection.Close();

                GestordeUsuario gu = new GestordeUsuario();
                if (gu.EnviarCorreo(user, mensaje))
                {
                    ClientScript.RegisterStartupScript(GetType(), "onSuccess", "onSuccess()", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(GetType(), "onFailure", "onFailure()", true);

                }

            }
            catch (Exception)
            {
                ClientScript.RegisterStartupScript(GetType(), "onFailure", "onFailure()", true);

            }
        }


        //Este método permite cambiar la contraseña
        [ScriptMethod, WebMethod]
        public static void RenovarContrasena(String usuario, String contrasenaVieja, String contrasenaNueva)
        {

            GestordeUsuario GU = GestordeUsuario.getGestor();

            bool registro = GU.RenovarContraseña(usuario, contrasenaVieja,contrasenaNueva);
            if (!registro)
            {
                HttpContext.Current.Response.Redirect("error.aspx", false);
            }


        }
    }
}