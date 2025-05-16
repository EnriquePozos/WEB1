package conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
 


/**
 *
 * @author pozos
 */
public class conexion {
    //De esta clase solo se debe cambiar el nombre, usuario y contraseña de la bd.
    //Los atributos de esta clase sirven para configurar la cadena de conexion a la bd.
    //Nombre de la bd;
    String bd="web";
    //Ruta y puerto por donde se conectara a la bd.
    String url = "jdbc:mysql://localhost:3306/";
    String user = "root";
    String password ="root";
    String driver = "com.mysql.cj.jdbc.Driver";
    
    //Objeto de conexion.
    Connection conn;

    public conexion() {
        
    }
    //Es el metodo para realizar la conexion a la bd y retornar esa conexion.
        public Connection Conectar() throws SQLException,ClassNotFoundException{
                  
        try {
            Class.forName(driver);
            conn=DriverManager.getConnection(url+bd,user,password);  
            
        } catch(SQLException ex) {
            Logger.getLogger(conexion.class.getName()).log(Level.SEVERE, null, ex);
        }
       
        return conn;
        }
        
        public void Desconectar() throws SQLException{
        
        conn.close();
        
        }

    
}

