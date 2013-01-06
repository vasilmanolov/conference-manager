package chat.client;

import java.io.BufferedReader;
import java.io.IOError;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

import chat.constants;

public final class chatClient {
	
	public static void main(String[] args) throws IOException{
		Socket clientSocket = new Socket("localhost", constants.CHAT_PORT);
		
		 InputStreamReader rdr = new InputStreamReader(clientSocket.getInputStream());
		 BufferedReader reader = new BufferedReader(rdr);
		 
		 PrintWriter output = new PrintWriter(clientSocket.getOutputStream(),true);
		 String line;
		 while((line = reader.readLine()) != null){
			 System.out.println(line);
		 }
		 output.println("Hello serv!");
		 try {
			clientSocket.close();
		} catch (IOError e) {
			
		}

	}

}
