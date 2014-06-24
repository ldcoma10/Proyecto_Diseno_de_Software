using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Xml;
using System.Drawing;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace Proyecto_Diseño
{
    //Permite del usuario al sistema
    public partial class AdministradorDeImagenes : System.Web.UI.Page
    {


        
        protected void Page_Load(object sender, EventArgs e)
        {

            //Este lo redirecciona a la pantalla principal en caso que el usuario no haya iniciado sesión. 
            //De lo contrario permanecerá en esta pantalla de Administrador de Imágenes           
            literalMensaje.Text = "";
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
                        

                    }
                
                catch (Exception)
                {
                    Response.Redirect("Principal.aspx", false);

                }
                }
            
        }

        public void MensajeError(string mensaje)
        {
            literalMensaje.Text = String.Format("<div class=\"error\">{0}</div>", mensaje);
        }

        //Método para  guardar la imagen en una carpeta temporal 
        private void GuardarArchivo(HttpPostedFile file)
        {
            // Se carga la ruta física de la carpeta temp del sitio
            string ruta = Server.MapPath("~/temp");

            // Si el directorio no existe, crearlo
            if (!Directory.Exists(ruta))
                Directory.CreateDirectory(ruta);

            string archivo = String.Format("{0}\\{1}", ruta, file.FileName);

            // Verificar que el archivo no exista
            if (File.Exists(archivo))
                MensajeError(String.Format(
                  "Ya existe una imagen con nombre\"{0}\".", file.FileName));
            else
            {
                file.SaveAs(archivo);
            }
        }
        //Este método permite mostrarle  la ventana para seleccionar la imagen
        protected void cargarImagenes_Click(object sender, EventArgs e)
        {
            try
            {
                if (fileUploader1.HasFile)
                {
                    // Se verifica que la extensión sea de un formato válido
                    string ext = fileUploader1.PostedFile.FileName;
                    ext = ext.Substring(ext.LastIndexOf(".") + 1).ToLower();
                    string[] formatos =
                      new string[] { "jpg", "jpeg", "bmp", "png", "gif" };
                    if (Array.IndexOf(formatos, ext) < 0)
                        MensajeError("Formato de imagen inválido.");
                    else
                        GuardarBD(fileUploader1.PostedFile);

                }
                else
                    MensajeError("Seleccione un archivo del disco duro.");
            }
            catch (Exception ex)
            {
                MensajeError(ex.Message);
            }
        }


        //Permite guardar la imagen de la carpeta temporal a la Base de datos
        private void GuardarBD(HttpPostedFile file)
        {

            // Nombre de la imagen
            string nombre = file.FileName.Substring(
              0, file.FileName.LastIndexOf("."));
            // Extensión del archivo
            string ext = nombre.Substring(nombre.LastIndexOf(".") + 1);
            // Tipo de contenido
            string contentType = file.ContentType;
            // Imagen convertida a arreglo de bytes
            byte[] imagen = new byte[file.InputStream.Length];
            file.InputStream.Read(imagen, 0, imagen.Length);

            // Se insertan los valores en la base de datos
            ConexionEspecificaABasedeDatos conexion = new ConexionEspecificaABasedeDatos();
            System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection();
            con.ConnectionString = conexion.getHileradeConexion();

            //Toma la ip del usuario para proceder a guardar la imagen según la ip 
            try
            {
                string ip;
                if (Request.UserHostAddress.Equals("::1"))
                {
                    ip = "201.206.114.2";
                }
                else
                {
                    ip = Request.UserHostAddress;                   
                }

                //Tomar el nombre de usuario
                HttpCookie solicitarCookie;
                solicitarCookie = Request.Cookies["TouristApp"];
                
                char[] usuariotemp = solicitarCookie.Value.ToCharArray();
                string usuario="";
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
                //Inserta la imagen a la base de datos
                SqlCommand cmd = new SqlCommand("INSERT INTO Foto (Foto,Ip,Comentario,Usuario) " +
                "VALUES(@Photo,@Ip,@Comentario,@Usuario)", con);
                cmd.Parameters.Add("@Photo", SqlDbType.Image, imagen.Length).Value = imagen;
                cmd.Parameters.Add("@Ip", SqlDbType.VarChar).Value = ip;
                cmd.Parameters.Add("@Comentario", SqlDbType.VarChar).Value = TextBox1.Text;
                cmd.Parameters.Add("@Usuario", SqlDbType.VarChar).Value = usuario;

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                TextBox1.Text = "";
                ClientScript.RegisterStartupScript(GetType(),"onSuccess","onSuccess()",true);
            }
            catch (Exception)
            {
                ClientScript.RegisterStartupScript(GetType(), "onFailure", "onFailure()", true);

            }

            finally
            {
                if (con != null)
                {
                    if (con.State == ConnectionState.Open)
                        con.Close();
                    con.Dispose();
                }
            }
        }
    }
}