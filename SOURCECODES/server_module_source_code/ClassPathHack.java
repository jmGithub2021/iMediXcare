package imedixserver;

import java.io.*;
import java.net.*;
import java.lang.*;
import java.lang.reflect.Method;
import java.lang.instrument.*;
import java.util.jar.*;
import org.aspectj.weaver.loadtime.Agent;

public class ClassPathHack{
    private static final Class[] parameters = new Class[] {URL.class};
    public static void addFile(String s) throws IOException
    {
        File f = new File(s);
        addFile(f);
    }
    public static void addFile(File f) throws IOException
    {
        addClassPath(f);
    }

    public static void addClassPath(File f) throws IOException {
        try {
        ClassLoader cl = ClassLoader.getSystemClassLoader();
        Instrumentation inst = Agent.getInstrumentation();            
            // If Java 9 or higher use Instrumentation
            if (!(cl instanceof URLClassLoader)) {
                inst.appendToSystemClassLoaderSearch(new JarFile(f));
            }

            // If Java 8 or below fallback to old method
            /*Method m = URLClassLoader.class.getDeclaredMethod("addURL", URL.class);
            m.setAccessible(true);
            m.invoke(cl, (Object)f.toURI().toURL());*/
        } catch (Throwable e) { 
            e.printStackTrace(); 
            throw new IOException("Error, could not add URL to system classloader");
        }
    }    
}