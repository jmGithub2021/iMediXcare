package imedix;

import java.rmi.*;
import java.sql.*;
import java.rmi.registry.*;
import java.util.Vector;

public class rcVideoConference{
    public static VideoConferenceInterface vidconf_server = null;
    private Registry registry;
    projinfo proj;
    

    public rcVideoConference(String p){
        try{
           // value will be read from file;
           proj= new projinfo(p);
           
           registry=LocateRegistry.getRegistry(proj.blip, Integer.parseInt(proj.blport));
           vidconf_server= (VideoConferenceInterface)(registry.lookup("VideoConference"));
                         
          }catch(Exception ex){
                System.out.println(ex.getMessage());
          }
     }

     public String SayHello(String msg) throws RemoteException{
        System.out.println("Calling SayHello with "+ msg);
        return vidconf_server.SayHello(msg);
     }

     public Object StartConference(String room) throws RemoteException,SQLException
     {
         System.out.println("Calling StartConference");
         Object res = vidconf_server.StartConference(room);
         return res;
     }
     public Object StopConference(String room) throws RemoteException,SQLException
     {
         System.out.println("Calling StopConference");
         Object res = vidconf_server.StopConference(room);
         return res;
     }

     public Object GetDoctors() throws RemoteException, SQLException
     {
        System.out.println("Calling GetDoctors");
        Object res = vidconf_server.GetDoctors();
        return res;
     }
     
}
