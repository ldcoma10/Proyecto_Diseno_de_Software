using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Proyecto_Diseño
{
    // File:    ConexionGenericaABaseDeDatos.cs
    // Author:  Erick,Luis
    // Created: jueves 22 de mayo de 2014 03:33:29 a.m.
    // Purpose: Definition of Class ConexionGenericaABaseDeDatos

    using System;

    public class ConexionGenericaABaseDeDatos : IConexionSoloLectura
    {
        private static int maximoDeConsultasPorUsuario = 50;
        // maximoDeDatosASolicitarPorUsuario está definido como una cantidad en MegaBytes
        private static int maximoDeDatosASolicitarPorUsuario = 2048;
        

        public int ObtenerMaximoDeConsultasPorUsuario()
        {
            return maximoDeConsultasPorUsuario;
        }

        public int ObtenerMaximoDeDatosASolicitarPorUsuario()
        {
            return maximoDeDatosASolicitarPorUsuario;
        }
    }
}