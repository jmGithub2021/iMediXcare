package imedix;

/**
 * @author Mithun Sarkar
 **/
  
import java.rmi.*;
import java.sql.*;

public interface VideoConferenceInterface extends Remote{
    // test method
    public String SayHello(String msg) throws RemoteException;

    public Object StartConference(String room) throws RemoteException;
    public Object StopConference(String room) throws RemoteException;
    public Object GetDoctors() throws RemoteException;
}
