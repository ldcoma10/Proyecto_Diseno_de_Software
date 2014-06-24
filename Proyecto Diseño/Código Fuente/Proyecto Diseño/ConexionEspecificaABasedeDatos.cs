using System;

namespace Proyecto_Diseño
{

    //Ocurrencia de una conexión específica que permite conectarse a una base de datos definida
    public class ConexionEspecificaABasedeDatos
    {
       private string NombredeSABD;
       private string NombreDePerfilDeCorreo;
       private string NombreBD;
        
       private string HileradeConexion;


    //En este se especifican la base de datos utilizada

       public ConexionEspecificaABasedeDatos() {
           NombredeSABD="Sql Server 2012";
           NombreDePerfilDeCorreo = "Diseño Public Profile";
           NombreBD = "DB_9B1768_Base";

           HileradeConexion = "Data Source=SQL5011.Smarterasp.net;Initial Catalog=DB_9B1768_Base;User Id=DB_9B1768_Base_admin;Password=Berseke03;"
;
           
       }

        //devuelve la hilera de conexión
        public String getHileradeConexion(){
            return HileradeConexion;
        }
        
        public String getNombreDePerfilDeCorreo() {
            return NombreDePerfilDeCorreo;        
        }
        //devuelve el nombre de la base de datos utilizada
        public String getNombreBD()
        {
            return NombreBD;
        }
        //Devuelve el SABD utilizado
        public String getNombredeSABD()
        {
            return NombredeSABD;
        }
        //Método que devuelve la cantidad máxima de consultas por usuario
        public int getMaximoConsultasPorUsuario()
        {
            ConexionGenericaABaseDeDatos conexion = new ConexionGenericaABaseDeDatos();
            return conexion.ObtenerMaximoDeConsultasPorUsuario();
        }
        //Método que devuelve el máximo de datos que puede solicitar un usuario
        public int getMaximoDeDatosASolicitarPorUsuario()
        {
            ConexionGenericaABaseDeDatos conexion = new ConexionGenericaABaseDeDatos();
            return conexion.ObtenerMaximoDeDatosASolicitarPorUsuario();
        }

    }
    
}