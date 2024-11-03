package io.pslab.communication;

import android.util.Log;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;

public class SocketClient {

    public static final String TAG = "SocketClient";
    private static SocketClient socketClient = null;
    private Socket socket;
    private OutputStream outputStream;
    private InputStream inputStream;
    private boolean isConnected = false;

    public static final int DEFAULT_READ_BUFFER_SIZE = 32 * 1024;

    private byte[] buffer = new byte[DEFAULT_READ_BUFFER_SIZE];

    private byte[] receivedData;

    private SocketClient() {
    }

    public void openConnection(String ip, int port) throws IOException {
        socket = new Socket(ip, port);
        outputStream = socket.getOutputStream();
        inputStream = socket.getInputStream();
        if (!socket.isConnected()) {
            isConnected = false;
            return;
        }
        isConnected = true;
    }

    public static SocketClient getInstance() {
        if (socketClient == null) {
            socketClient = new SocketClient();
        }
        return socketClient;
    }

    public boolean isConnected() {
        return isConnected;
    }

    public void write(byte[] data) throws IOException {
        if (isConnected && socketClient.isConnected && outputStream != null) {
            outputStream.write(data);
        }
    }

    public int read(int bytesToRead) throws IOException {
        int bytesRead = 0;
        if (isConnected && socketClient.isConnected && inputStream != null) {
            bytesRead = inputStream.read(buffer, 0, bytesToRead);

            if (bytesRead > 0) {
                receivedData = new byte[bytesRead];
                System.arraycopy(buffer, 0, receivedData, 0, bytesRead);
            } else {
                Log.e(TAG, "Read Error: " + bytesToRead);
                return bytesRead;
            }
        }
        return bytesRead;
    }

    public byte[] getReceivedData() {
        return receivedData;
    }

    public void closeConnection() {
        try {
            if (isConnected) {
                inputStream.close();
                outputStream.close();
                socket.close();
                isConnected = false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
