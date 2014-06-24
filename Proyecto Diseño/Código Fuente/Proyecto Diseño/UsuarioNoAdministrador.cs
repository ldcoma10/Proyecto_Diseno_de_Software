using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Proyecto_Diseño
{
    // File:    UsuarioNoAdministrador.cs
    // Author:  Erick,Luis
    // Created: jueves 22 de mayo de 2014 12:30:07 a.m.
    // Purpose: Definition of Class UsuarioNoAdministrador

    //Clase en la cual se define un usuario que no es administrador
    //Este usuario no puede ver las estadísticas del funcionamiento del sistema

    public class UsuarioNoAdministrador : Usuario
    {
        public int cantidadDeDatos;
        public int cantidadDeConsultas;
        private static UsuarioNoAdministrador usuario;

        public static UsuarioNoAdministrador getUsuario(String Email1)
        {
            if (usuario == null)
            {
                usuario = new UsuarioNoAdministrador(Email1);
            }
            return usuario;
        }

        public UsuarioNoAdministrador(String Email1): base(Email1)
        {
        }

        public Boolean abusoEnConsultas()
        {
            ConexionGenericaABaseDeDatos conex = new ConexionGenericaABaseDeDatos();
            if (conex.ObtenerMaximoDeConsultasPorUsuario() < cantidadDeConsultas)
            {
                return true;
            }
            return false;
        }
    }
}