using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto_Diseño
{
    //Esta es la pantalla principal que se le presenta al usuario al ingresar al sistema 
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                HttpCookie solicitarCookie;
                solicitarCookie = Request.Cookies["TouristApp"];
                if (solicitarCookie != null)
                {
                    Response.Redirect("SesionIniciada.aspx", false);

                }

            }
            

            
            
        }

        //Al iniciar sesión este procederá a verificar que este esté registrado 
        [ScriptMethod, WebMethod]
        public static void IniciarSesionUsuario(String usuario, String contrasena)
        {
                            
                GestordeUsuario GU= GestordeUsuario.getGestor();                
                bool user = GU.AutenticarUsuario(usuario, contrasena);
                
                if (!user)
                {
                    HttpContext.Current.Response.Redirect("error.aspx",false); 
          
                }           
            
        }  
        
    }
    
}