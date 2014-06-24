using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto_Diseño
{
    //Esta pantalla es la que se muestra cuando se procede a registrar un nuevo usuario
    public partial class Registro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        //Se procede a registrar el usuario utilizando la fachada (Gestor de Usuario)
        [ScriptMethod, WebMethod]
        public static void Registrarse(String usuario, String contrasena)
        {

            GestordeUsuario GU = GestordeUsuario.getGestor();

            bool registro = GU.RegistrarNuevoUsuario(usuario, contrasena);
            if (!registro)
            {
                HttpContext.Current.Response.Redirect("error.aspx", false);
            }
            

        }
    }
}