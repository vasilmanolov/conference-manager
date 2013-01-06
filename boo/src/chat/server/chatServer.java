package chat.server;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;

import chat.constants;

public class chatServer {
	
	public static void main(String[] args) {
		ServerSocket serverSocket = null;
		try {
			 serverSocket = new ServerSocket(constants.CHAT_PORT);
			 Socket clientSocket = null;
			 int i = 0;
			 while (true) {

				clientSocket = serverSocket.accept();
				Thread thread = new servConn(clientSocket);
				thread.start();
			 }
			 
		} catch (IOException e) {
			e.printStackTrace();
		}
		 finally
		 {
			 
			 try {
					if (serverSocket != null) {
						serverSocket.close();
					}
				} catch (IOException e) {
				}
		 }
	}

}
