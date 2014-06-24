using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Proyecto_Diseño
{

    //Fachada: Esta clase permite simplificar la vista al programador mediante la integración de métodos de varias clases en una única clase  
    public class GestordeUsuario
    {
        private int CantidaddeUsuariosConectados;
        private static GestordeUsuario gestor;

        public static GestordeUsuario getGestor()
        {
            if (gestor == null)
            {
                gestor = new GestordeUsuario();
            }
            return gestor;
        }

        //Método que permite recuperar la contraseña desde la base de datos para luego enviar un correo al usuario solicitante
        public Boolean RecuperarContrasena(String Correo) {
            return false; }

        // Metódo que permite el envío de correos
        public bool EnviarCorreo(string receptor, string mensaje)
        {

            System.Net.Mail.MailMessage mmsg = new System.Net.Mail.MailMessage();
            mmsg.To.Add(receptor);
            mmsg.Subject = "Contraseña Olvidada";
            mmsg.SubjectEncoding = System.Text.Encoding.UTF8;

            //Cuerpo del Mensaje
            mmsg.Body = "Contraseña: " + mensaje;
            mmsg.BodyEncoding = System.Text.Encoding.UTF8;
            mmsg.IsBodyHtml = false;

            //Datos del emisor
            mmsg.From = new System.Net.Mail.MailAddress("touristappdesde2014@gmail.com");
            //Cliente de correo
            System.Net.Mail.SmtpClient cliente = new System.Net.Mail.SmtpClient();
            cliente.Credentials =
                new System.Net.NetworkCredential("touristappdesde2014@gmail.com", "touristapp");
            cliente.Port = 587;
            cliente.EnableSsl = true;
            cliente.Host = "smtp.gmail.com";

            try
            {
                cliente.Send(mmsg);
                return true;
            }
            catch (System.Net.Mail.SmtpException)
            {
                return false;
            }
        }




        //Método que renueva la contraseña desde la base de datos este recibe la contraseña antigua y la nueva contraseña 
        public Boolean RenovarContraseña(String Correo, String ContrasenaVieja, String ContrasenaNueva)
        {
            ConexionEspecificaABasedeDatos conexion = new ConexionEspecificaABasedeDatos();

            System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection();
            con.ConnectionString = conexion.getHileradeConexion();
            SqlCommand cmd = new SqlCommand();
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandText = "SELECT email,contrasena FROM usuario";
                SqlDataReader reader = cmd.ExecuteReader();

                bool bandera = false;
                while (reader.Read())
                {

                    if (reader.GetString(0) == Correo && reader.GetString(1) == ContrasenaVieja)
                    {
                        bandera = true;
                        break;
                    }

                }
                con.Close();
                if (bandera)
                {

                    cmd = new SqlCommand("Update Usuario set Contrasena= '" + ContrasenaNueva + "' Where email='"+Correo+"'", con);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return true;
                }
                return false;


            }
            catch (Exception)
            {
                return false;
            }
        }

        //Al usuario registrar un usuario este método procede a llamar a la clase usuario administrador para proceder a crear este
        public bool RegistrarNuevoUsuario(String usuario, String contrasena){

            AdministradorDelSistema AS = new AdministradorDelSistema(usuario,contrasena);
            Usuario us=AS.CrearUsuarioNoAdministrador(usuario,contrasena);
            if (us == null)
            {
                return false;
            }
            else {
                return true;
            }
        
        }


        //Con los datos ingresados en la pantalla principal, se procede a autenticar el usuario
        public bool AutenticarUsuario(String Correo,String Contrasena){
            
            ConexionEspecificaABasedeDatos conexion=new ConexionEspecificaABasedeDatos();
           
            System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection();
            con.ConnectionString = conexion.getHileradeConexion();
            SqlCommand cmd = new SqlCommand(); 
           try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandText = "SELECT email,contrasena FROM usuario";
                SqlDataReader reader = cmd.ExecuteReader();
                bool usuarioRegistrado = false;
                while (reader.Read())
                {
                    String emailprovisional=reader.GetString(0);
                    if (Contrasena != null)
                    {
                        if (emailprovisional == Correo && reader.GetString(1) == Contrasena)
                        {
                            String nombre = reader.GetString(0);
                            String contrasena = reader.GetString(1);
                            usuarioRegistrado = true;
                            break;
                        }
                    }
                    //en caso de iniciar mediante facebook, ya que no se tiene la contraseña
                    else if (Contrasena == null) {
                        if (emailprovisional == Correo)
                        {
                            String nombre = reader.GetString(0);                            
                            usuarioRegistrado = true;
                            break;
                        }
                    }
                    
                    
                }
                
                return usuarioRegistrado;
               
                
            }
            catch (Exception) {
                return false;
            }
            
        }


        //Llama a la clase administrador para verificar que el correo ingresado se e han dado los permisos para que sea Administrador
        public bool EsAdministrador(String Correo) {
            AdministradorDelSistema AS=new AdministradorDelSistema(Correo,null);
            return AS.EsAdministrador();
        }


    }

}