package io.pslab.fragment;

import android.app.Activity;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.view.inputmethod.EditorInfo;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ProgressBar;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.DialogFragment;

import com.google.android.material.snackbar.Snackbar;


import io.pslab.R;
import io.pslab.communication.SocketClient;
import io.pslab.others.CustomSnackBar;
import io.pslab.others.ScienceLabCommon;

public class ESPFragment extends DialogFragment {
    private static final String TAG = ESPFragment.class.getSimpleName();

    private String espIPAddress = "";
    private ProgressBar espConnectProgressBar;
    private Button espConnectBtn;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.fragment_esp, container, false);
        EditText espIPEditText = rootView.findViewById(R.id.esp_ip_edit_text);
        espConnectBtn = rootView.findViewById(R.id.esp_connect_btn);
        espConnectProgressBar = rootView.findViewById(R.id.esp_connect_progressbar);
        espConnectBtn.setOnClickListener(v -> {
            espIPAddress = espIPEditText.getText().toString();
            espConnectBtn.onEditorAction(EditorInfo.IME_ACTION_DONE);
            Activity activity;
            if (espIPAddress.isEmpty() && ((activity = getActivity()) != null)) {
                CustomSnackBar.showSnackBar(activity.findViewById(android.R.id.content),
                        getString(R.string.incorrect_IP_address_message), null, null, Snackbar.LENGTH_SHORT);
            } else {
                new ESPTask().execute();
            }
        });
        espIPEditText.setOnEditorActionListener((v, actionId, event) -> {
            if (actionId == EditorInfo.IME_ACTION_DONE) {
                espConnectBtn.performClick();
                return true;
            }
            return false;
        });
        return rootView;
    }

    @Override
    public void onResume() {
        super.onResume();
        WindowManager.LayoutParams params = getDialog().getWindow().getAttributes();
        params.height = ViewGroup.LayoutParams.WRAP_CONTENT;
        params.width = ViewGroup.LayoutParams.MATCH_PARENT;
        getDialog().getWindow().setAttributes(params);
    }

    private class ESPTask extends AsyncTask<Void, Void, Boolean> {

        @Override
        protected void onPreExecute() {
            espConnectBtn.setVisibility(View.GONE);
            espConnectProgressBar.setVisibility(View.VISIBLE);
        }

        @Override
        protected Boolean doInBackground(Void... voids) {
            try {
                SocketClient socketClient = SocketClient.getInstance();
                socketClient.openConnection(espIPAddress, 80);
                if (socketClient.isConnected()) {
                    ScienceLabCommon.setIsWifiConnected(true);
                    ScienceLabCommon.setEspBaseIP(espIPAddress);
                    return true;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return false;
        }

        @Override
        protected void onPostExecute(Boolean result) {
            espConnectProgressBar.setVisibility(View.GONE);
            espConnectBtn.setVisibility(View.VISIBLE);
            Activity activity;
            if (!result && ((activity = getActivity()) != null)) {
                CustomSnackBar.showSnackBar(activity.findViewById(android.R.id.content),
                        getString(R.string.incorrect_IP_address_message), null, null, Snackbar.LENGTH_SHORT);
            } else {
                Log.v("ESPFragment", "ESP Connection Successful");
                ScienceLabCommon.getInstance().openDevice(null);
                ScienceLabCommon.isWifiConnected = true;
                getParentFragmentManager().beginTransaction().remove(ESPFragment.this).commitAllowingStateLoss();
                getParentFragmentManager().beginTransaction().replace(R.id.frame, HomeFragment.newInstance(true, false)).commitAllowingStateLoss();
            }
        }
    }
}