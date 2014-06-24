using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Proyecto_Diseño
{
    // File:    AdministradorDelSistema.cs
    // Author:  Erick, Luis
    // Created: jueves 22 de mayo de 2014 12:20:51 a.m.
    // Purpose: Permite realizar un usuario de tipo administrador



    public class AdministradorDelSistema : Usuario
    {
        private string nombreFuncionario;

       
        //Constructor de la clase del Administrador Sistema
        public AdministradorDelSistema (String Email, String Contrasena):base(Email,Contrasena)
        { }


        //Método que permite dar permisos de un usuario no administrativo a uno administrativo 
        public bool CrearAdministradorDeSistema(String Correo) {
            ConexionEspecificaABasedeDatos conexion = new ConexionEspecificaABasedeDatos();
            System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection();
            con.ConnectionString = conexion.getHileradeConexion();
            SqlCommand cmd = new SqlCommand();
            try
            {
                cmd = new SqlCommand("Update Usuario set Rol= 'A' Where email='" + Correo + "'", con);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                return true;
            }

            catch (Exception) {
                return false;
            }
            }


        //Crea los usuario no Administrativos
        public Usuario CrearUsuarioNoAdministrador(String Correo,String Contraseña)
        {         

            ConexionEspecificaABasedeDatos conexion = new ConexionEspecificaABasedeDatos();
            System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection();
            con.ConnectionString = conexion.getHileradeConexion();
            SqlCommand cmd = new SqlCommand();
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandText = "SELECT email FROM usuario";
                SqlDataReader reader = cmd.ExecuteReader();

                //Se verifica si el usuario no está previamente registrado
                bool bandera = false;
                while (reader.Read())
                {

                    if (reader.GetString(0) == Correo)
                    {
                        bandera = true;
                        break;
                    }

                }
                con.Close();

                //Si el usuario no está registrado en la base de datos se procede a registrar
                if(!bandera){

                    cmd = new SqlCommand("INSERT INTO Usuario (EMAIL,Contrasena,Rol) " +
                    "VALUES(@Email,@Contrasena,@Rol)", con);
                cmd.Parameters.Add("@Email", System.Data.SqlDbType.NVarChar,500).Value = Correo;
                cmd.Parameters.Add("@Contrasena", System.Data.SqlDbType.NVarChar,100).Value = Contraseña;
                cmd.Parameters.Add("@Rol", System.Data.SqlDbType.Char, 1).Value = "E";

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                return new Usuario(Correo, Contraseña);
                }
                return null;


            }
            catch (Exception)
            {
                return null;
            }
            
            



        }


        //Método que permite mostrar la cantidad de usuarios conectados en la aplicación
        public int ObtenerUsuariosConectados()
        {
            int cantidad=2;
            ConexionEspecificaABasedeDatos conexion = new ConexionEspecificaABasedeDatos();
            System.Data.SqlClient.SqlConnection connection = new System.Data.SqlClient.SqlConnection();
            try
            {
                connection.ConnectionString = conexion.getHileradeConexion();
                connection.Open();
                SqlCommand command = new SqlCommand("Select Count(*) From UsuariosConectadosWeb", connection);
                SqlDataReader reader = command.ExecuteReader();
                if (reader.Read())
                {
                    cantidad = reader.GetInt32(0);
                }
                connection.Close();           
            }
            catch
            {
                connection.Close();
            }
            return cantidad;
        }


        //Método que permite mostrar las sesiones por usuario
        public int ObtenerSesionesPorUsuario(string usuario)
        {
        
            int cantidad=2;
            ConexionEspecificaABasedeDatos conexion = new ConexionEspecificaABasedeDatos();
            System.Data.SqlClient.SqlConnection connection = new System.Data.SqlClient.SqlConnection();


            try
            {
                connection.ConnectionString = conexion.getHileradeConexion();
                connection.Open();

                SqlCommand command = new SqlCommand("SELECT  COUNT(UsuariosConectadosWeb.IdUsuario) FROM Usuario INNER JOIN UsuariosConectadosWeb ON Usuario.IdUsuario = UsuariosConectadosWeb.IdUsuario Where Usuario.Email= '" + usuario +"'", connection);
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    cantidad = reader.GetInt32(0);
                }
                connection.Close();
           
            }
            catch
            {
                connection.Close();
            }
            return cantidad;

        }


        //Metodo que devuelve si el usuario ingresado es administrador, para realizar esto se procede a verificar su rol en la base de datos


        public bool EsAdministrador()
        {
            ConexionEspecificaABasedeDatos conexion = new ConexionEspecificaABasedeDatos();

            System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection();
            con.ConnectionString = conexion.getHileradeConexion();
            SqlCommand cmd = new SqlCommand();
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandText = "SELECT email,rol FROM usuario";
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {

                    if (reader.GetString(0) == this.Correo_electronico && reader.GetString(1).ToLower() == "a")
                    {
                        return true;
                    }
                    else if (reader.GetString(0) == this.Correo_electronico)
                    {
                        return false;
                    }

                }
                return false;

            }
            catch (Exception)
            {
                return false;
            }
        
        }

        

    }
}