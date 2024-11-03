package io.pslab.communication;

import android.os.AsyncTask;
import android.util.Log;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;

import io.pslab.interfaces.HttpCallback;

public class HttpAsyncTask extends AsyncTask<byte[], Void, Void> {

    private SocketClient socketClient;
    private HttpCallback<byte[]> mHttpCallback;
    private int bytesToRead;

    public HttpAsyncTask(HttpCallback<byte[]> httpCallback, int bytesToRead) {
        socketClient = SocketClient.getInstance();
        mHttpCallback = httpCallback;
        this.bytesToRead = bytesToRead;
    }

    @Override
    protected Void doInBackground(byte[]... data) {
        int bytesRead = 0;
        try {
            if (data[0].length != 0) {
                socketClient.write(data[0]);

            } else {
                bytesRead = socketClient.read(bytesToRead);
            }
        } catch (IOException e) {
            mHttpCallback.error(e);
            e.printStackTrace();
        }
        if (data[0].length == 0 && bytesRead == bytesToRead) {
            mHttpCallback.success(socketClient.getReceivedData());
        } else if (data[0].length != 0) {
            mHttpCallback.success(new byte[]{});
        } else {
            mHttpCallback.error(new Exception());
        }
        return null;
    }
}
