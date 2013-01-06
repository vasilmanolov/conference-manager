package chat.server;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

public class servConn extends Thread {
	private Socket clientSocket;
	public servConn(Socket sock) {
		this.clientSocket = sock;
	}
	
	@Override
	public void run() {
		 try
		 {
			 InputStreamReader rdr = new InputStreamReader(clientSocket.getInputStream());
			 BufferedReader reader = new BufferedReader(rdr);
			 
			 PrintWriter output = new PrintWriter(clientSocket.getOutputStream(),true);
			 output.println("Hello client!");
			 
		 }
		catch (IOException e) {
			e.printStackTrace();
		}
		 finally
		 {			
			 try {
					if (clientSocket != null) {
						clientSocket.close();
					}
				} catch (IOException e) {
				}
		 }
	}
}
