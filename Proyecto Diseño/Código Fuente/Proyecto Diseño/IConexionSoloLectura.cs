using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Proyecto_Diseño
{
    // File:    IConexionSoloLectura.cs
    // Author:  Erick,Luis
    // Created: jueves 22 de mayo de 2014 08:59:44 a.m.
    // Purpose: Interace sólo lectura
    //Esta permite restringir la modificación de los datos que tiene las conexiones genéricas

    using System;

    public interface IConexionSoloLectura
    {
        int ObtenerMaximoDeConsultasPorUsuario();
        int ObtenerMaximoDeDatosASolicitarPorUsuario();

    }
}