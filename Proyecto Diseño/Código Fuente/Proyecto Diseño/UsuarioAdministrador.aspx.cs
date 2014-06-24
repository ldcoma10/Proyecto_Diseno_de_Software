using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto_Diseño
{
    //Pantalla en la cual se muestran las estadísticas del sistema
    public partial class UsuarioAdministrador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
              LlenarTextBox();
            
            
        }

    //Método en lo que se muestran los usuarios no administrador
        public void LlenarTextBox() {
            DropDownList1.DataSourceID = "UsuarioEstandar";
        
        }

        //Método que permite modificar un usuario no administrador en uno con permisos administrativos
        protected void Button1_Click(object sender, EventArgs e)
        {

            AdministradorDelSistema AS=new AdministradorDelSistema(null,null);
            bool respuesta=AS.CrearAdministradorDeSistema(DropDownList1.SelectedItem.Text);
            if (respuesta)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlert", "alert('Se cambió el usuario con privilegios Administrativos');", true);

            }
            else {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlert", "alert('No se pudo cambiar el usuario elegido a uno Administrador');", true);


            }
            
        }
        
    }
}