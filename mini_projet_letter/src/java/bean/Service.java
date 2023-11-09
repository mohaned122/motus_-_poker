package bean;


import java.io.Serializable;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.lang.String;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author zayoud_mohanned
 */
public class Service implements Serializable{
    private String url;
    private String login;
    private String pass;
    private Connection cx;
    
    public Service() {
        this.url = "jdbc:mysql://localhost:3306/game";
        this.login = "root";
        this.pass = "";
    }
    
        public boolean Connection(){
        try{
            //chargement de pilote
            Class.forName("com.mysql.cj.jdbc.Driver");
            //Connexion
            cx = DriverManager.getConnection(url, login, pass);
            return true;
        }catch(SQLException | ClassNotFoundException e){
            return false;
        }
    }
        
        public boolean deconnection(){
            try{
                cx.close();
                return true;
            }catch(SQLException e){
                return false;
            }
        }
        
     public int insertTry(String mot, int note) {
    try {
        String sql = "INSERT INTO `try` (`mot`, `note`) VALUES (?, ?)";
        PreparedStatement stm = cx.prepareStatement(sql);  
        stm.setString(1, mot);
        stm.setInt(2, note); // Use the provided note parameter
        int x = stm.executeUpdate();
        return x;
    } catch (SQLException ex) {
        ex.printStackTrace(); // Log the exception
        return 0;
    }
}

     
     public List<String> getAllTry(){
       try{
            List<String> l = new ArrayList<String>();
          String sql = "SELECT * FROM `try` ";
          Statement stm = cx.createStatement(); 
          ResultSet res = stm.executeQuery(sql);
          while(res.next()){
              l.add(res.getString("mot"));
          }
          return l;
       }catch(SQLException ex){
           return null;
       }
    }
     
    public int remouveTry(){
        String sql="DELETE FROM `try`;";
        Statement stm;
        try {
            stm = cx.createStatement();
             int x = stm.executeUpdate(sql);
             return x;
        } catch (SQLException ex) {
            return 0;
        }
    }
    
    public List<String> getWord(){
        int x =1; //math.random()*10
        List<String> str = new ArrayList<String>() ;
         try{
          String sql = "SELECT * FROM `word` where `id`="+x;
          Statement stm = cx.createStatement(); 
          ResultSet res = stm.executeQuery(sql);
          if(res.next()){
              str.add(res.getString("mot"));
              str.add(res.getString("description"));
          }
          return str;
       }catch(SQLException ex){
           return null;
       }
    }
}
