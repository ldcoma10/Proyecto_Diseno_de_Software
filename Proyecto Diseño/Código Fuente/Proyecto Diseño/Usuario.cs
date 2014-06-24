using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Proyecto_Diseño
{
    //Esta clase permite contener información pertinente a un usuario
    public class Usuario
    {
        protected String Correo_electronico;
        protected String Contrasena;


        //Constructores de Usuario
        public Usuario(String Correo_electronico)
        {
            this.Correo_electronico = Correo_electronico;

        }
        public Usuario(String Correo_electronico,String Contrasena) {
            this.Correo_electronico = Correo_electronico;
            this.Contrasena = Contrasena;
            }


        //Método  para devolver el correo del usuario creado
        public String ObtenerCorreo() {
            return Correo_electronico;
        }
        
        

        //Método para obtener la contraseña
        private String ObtenerContrasena() { 
            return Contrasena; }

        //Método para modificar la contraseña
        public void modificarContrasena(String NuevaContrasena) { 
            this.Contrasena = NuevaContrasena; }

        



    }
}