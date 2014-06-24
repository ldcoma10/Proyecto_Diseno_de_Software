using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Subgurim.Controles;
using Google.API.Search;
using System.Data;
using System.Data.SqlClient;

namespace Proyecto_Diseño
{
    public partial class SesionIniciada : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            
        
            if (!IsPostBack)
            {
               
                dlSearch.DataSource = null;
                dlSearch.DataBind();

                //Se verifica que el usuario que haya iniciado sesión 
               HttpCookie solicitarCookie;
                solicitarCookie = Request.Cookies["TouristApp"];
                if (solicitarCookie == null)
                {
                    try
                    {
                        string url = HttpContext.Current.Request.Url.AbsoluteUri;

                        HttpCookie myCookie = new HttpCookie("TouristApp");
                        List<String> Lista = DesincriptarUrl(url);

                        
                        myCookie.Value = CookieValue(Lista.First());
                        Response.Cookies.Add(myCookie);

						

                        Response.Redirect("SesionIniciada.aspx", false);
						
                    }
                    catch (Exception)
                    {
                        
                        Response.Redirect("Principal.aspx", false);
                        
                    }
                } 
            }

            mostrarMapa();
            trazarRuta();
            colocarMarcas();            
            esAdministrador();
            
           
            
            
        }
        //Con la url mandada como parametro  se desincripta. Esta contiene la contrasena y el email insertados en la pantalla principal
		private List<String> DesincriptarUrl(string url)
        {
            string[] encriptado = url.Split('?');
            var base64EncodedBytes = System.Convert.FromBase64String(encriptado[1]);
            string desincriptado = Encoding.UTF8.GetString(base64EncodedBytes);
            return SepararValores(desincriptado);
            }
        //De la url ingresada se debe separar el correo y la contraseña ingresada
        private List<String> SepararValores(string url) {
            
            List<String> Parametros = new List<string>();
            String [] valores=url.Split('&');
            int i = 0;
            for (;i<valores.Length;i++){
                String []valor=valores[i].Split('=');                
                Parametros.Add(valor[1]);
                if (i == 1) {
                    GestordeUsuario GU = GestordeUsuario.getGestor();
                    bool parametroscorrectos = GU.AutenticarUsuario(Parametros.First(),valor[1]);
                    if (!parametroscorrectos)
                    {
                        return null;

                    }                   
                }
                
            }

            //en caso de iniciar por facebook
            if (i == 1 && Parametros.Count == 1) {
                GestordeUsuario GU = GestordeUsuario.getGestor();

                bool parametroscorrectos = GU.AutenticarUsuario(Parametros.First(), null);
                
                if (!parametroscorrectos)
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlert", "alert('No se pudo iniciar mediante facebook, el usuario ingresado no está registrado, proceda a Registrarse');", true);

                    return null;

                }
            }
            
            return Parametros;
            
        }

        //Se guarda una cookie en el navegador con el correo ingresado
        public string CookieValue(String correo) {


            ConexionEspecificaABasedeDatos BD=new ConexionEspecificaABasedeDatos();
            System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection();
            con.ConnectionString = BD.getHileradeConexion();

            try
            {
                
                using (SqlCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = "IniciarSesion";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.Parameters.AddWithValue("@correo", correo);

                    var returnParameter = cmd.Parameters.Add("@Retorno", SqlDbType.Int);
                    returnParameter.Direction = ParameterDirection.ReturnValue;

                    con.Open();
                    cmd.ExecuteNonQuery();
                    int id = (int)returnParameter.Value;
                    con.Close();
                    return id + "-" + correo;
                }
            }
            catch (Exception)
            {
                return "";
            }
            
            
            
        }
        //Método en la que se cierra la sesión del usuario
        [ScriptMethod, WebMethod]
        public static void CerrarSesionUsuario()
        {
            
            
            HttpCookie solicitarCookie;
            solicitarCookie = HttpContext.Current.Request.Cookies["TouristApp"];
            
            if (solicitarCookie != null)
            {
                try
                {
                    
                        String contenidoCookie = solicitarCookie.Value;
                        string[] Cookie = contenidoCookie.Split('-');
                        QuitarCookieBD(Cookie[0]);
                        

                    
                    
                    
                }
                catch (Exception)
                {
                    System.Diagnostics.Debug.WriteLine("No funciono");
                }

            }
        }

        //Además de cerrar sesión se elimina la cookie del navegador y se elimina de la tabla de la bases de datos que indica los usuarios conectados en la aplicación 
        public static void QuitarCookieBD(string numerocookie){
            ConexionEspecificaABasedeDatos BD = new ConexionEspecificaABasedeDatos();
                System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection();
                con.ConnectionString = BD.getHileradeConexion();
                SqlCommand cmd = new SqlCommand();
                
                try
                {
                    cmd = new SqlCommand("Delete from UsuariosConectadosWeb Where numerocookie= " + numerocookie, con);
                    
                    
                    con.Open();
                    cmd.ExecuteNonQuery();
                   
                    con.Close();
                }
                catch (Exception) { 
                }

        }

        //Si el usuario es administrador se muestra el botón de las estadísticas en la pantalla de la sesión iniciada
        public void esAdministrador(){
            botonAdministrador.Visible = false;
            HttpCookie solicitarCookie= HttpContext.Current.Request.Cookies["TouristApp"];
            if (solicitarCookie != null)
            {
                String[] valorCookie = solicitarCookie.Value.Split('-');
                GestordeUsuario GU = GestordeUsuario.getGestor();
                if (GU.EsAdministrador(valorCookie[1]))
                {
                    botonAdministrador.Visible = true;
                }
            }
            



        }

        //Con base a la cookie se obtiene el usuario que ingresó sesión
        public String obtenerUsuarioActual()
        {
            //Tomar el nombre de usuario
            HttpCookie solicitarCookie;
            solicitarCookie = Request.Cookies["TouristApp"];

            char[] usuariotemp = solicitarCookie.Value.ToCharArray();
            string usuario = "";
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
            return usuario;

        }

        // Se colocan los pines en el mapa donde sean subido fotos
        public void colocarMarcas()
        {

            string ip;
            string databaseFile = Server.MapPath("~/img/GeoLiteCity.dat/GeoLiteCity.dat");
            LookupService service = new LookupService(databaseFile);
            Location location;
            GLatLng latlng;
            GMarker marker;
            string comentario;
            GInfoWindow window;


            try
            {
                //Tomar el nombre de usuario
                HttpCookie solicitarCookie;
                solicitarCookie = Request.Cookies["TouristApp"];
                char[] usuariotemp = solicitarCookie.Value.ToCharArray();
                string usuario = "";
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

                ConexionEspecificaABasedeDatos conexion = new ConexionEspecificaABasedeDatos();
                System.Data.SqlClient.SqlConnection connection = new System.Data.SqlClient.SqlConnection();
                connection.ConnectionString = conexion.getHileradeConexion();
                connection.Open();

                SqlCommand command = new SqlCommand("select ip,comentario from foto where Usuario='" + usuario + "'", connection);
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    ip = reader.GetString(0);
                    comentario = reader.GetString(1);

                    // Localizar en base a la IP
                    location = service.getLocation(ip);
                    if (location != null)
                    {
                        latlng = new GLatLng(location.latitude, location.longitude);
                        //Pone la marca de gota de agua con el comentario de la foto
                        marker = new GMarker(latlng);
                        window = new GInfoWindow(marker, comentario, true);
                        Mapa.addInfoWindow(window);
                    }
                }
                reader.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }



        

        public void btn1_clicked(object sender, EventArgs e)
        {
            string destino = tb_endPoint.Text;

            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            dt.Columns.Add(new DataColumn("Title", typeof(string)));
            dt.Columns.Add(new DataColumn("OriginalContextUrl", typeof(string)));
            dt.Columns.Add(new DataColumn("Url", typeof(string)));

            GimageSearchClient client = new GimageSearchClient("http://iis.ic-itcr.ac.cr/touristapp/");
            IList<IImageResult> results = client.Search(destino, 10);
            foreach (IImageResult result in results)
            {
                DataRow dr = dt.NewRow();
                dr["Title"] = result.Title.ToString();
                dr["OriginalContextUrl"] = result.OriginalContextUrl;
                dr["Url"] = result.Url;
                dt.Rows.Add(dr);
            }
            dlSearch.DataSource = dt;
            dlSearch.DataBind();



        }

        // Se traza la ruta con el punto de partida y el punto de destino según los datos ingresados por el usuario
        public void trazarRuta()
        {
            // Permitir trazar rutas
            GDirection direction = new GDirection();
            direction.autoGenerate = false;
            direction.buttonElementId = "btn1";
            direction.fromElementId = tb_fromPoint.ClientID;
            direction.fromText = "Salida desde";
            direction.toElementId = tb_endPoint.ClientID;
            direction.toText = "Destino";
            direction.errorMessage = "Ha ocurrido un error, intente con otros parámetros de búsqueda";
            direction.clearMap = false;
            Mapa.Add(direction);

        }
        //Método para dibujar el mapa
        public void mostrarMapa()
        {
            if (!Page.IsPostBack)
            {

                string databaseFile = Server.MapPath("~/img/GeoLiteCity.dat/GeoLiteCity.dat");
                LookupService service = new LookupService(databaseFile);

                // Localizar en base a la IP
                Location location = service.getLocation(Request.UserHostAddress);

                if (Request.UserHostAddress.Equals("::1"))
                {
                    location = service.getLocation("201.206.114.2");

                }

                if (location != null)
                {
                    GLatLng latlng = new GLatLng(location.latitude, location.longitude);
                    Mapa.setCenter(latlng, 10);
                }

                //Establecemos alto y ancho en px
                Mapa.Height = 640;
                Mapa.Width = 480;

                //Adiciona el control de la parte izq superior (moverse, ampliar y reducir)
                Mapa.Add(new GControl(GControl.preBuilt.LargeMapControl));


                Mapa.enableHookMouseWheelToZoom = true;

                //Tipo de mapa a mostrar
                Mapa.mapType = GMapType.GTypes.Normal;

                //Moverse con el cursor del teclado
                Mapa.enableGKeyboardHandler = true;
            }
        }

        protected void dlSearch_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {

        }

        protected void dlSearch_SelectedIndexChanged1(object sender, EventArgs e)
        {

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        
        
    }
}