package string.carfile;

import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.support.design.widget.Snackbar;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RelativeLayout;
import android.widget.Toast;

import com.squareup.okhttp.Call;
import com.squareup.okhttp.Callback;
import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.Response;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;

import butterknife.Bind;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class CarSetUp extends AppCompatActivity implements AsyncResponse {

    private String jsonData;
    private CarInfo tempCar;
    private NetworkCarInfoFetch carGet;
    public final String TAG = "CarSetUp";
    @Bind(R.id.vinNumberEnter) EditText vinInput;
    @Bind(R.id.setupContinue) Button continueButton;
    String cVin;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        requestWindowFeature(Window.FEATURE_INDETERMINATE_PROGRESS);
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_car_set_up);
        ButterKnife.bind(this);
        tempCar = new CarInfo();

    }
    @Override
    public void processFinish(String output){
        Log.d(TAG, "processFinished received");
        Log.d(TAG, output);
        if(output.equals("fail")){
            showSnackbar();
        }
    }

    @OnClick(R.id.setupContinue)
    public void submit(View view){
        cVin = vinInput.getText().toString();
        if(cVin.length() < 11 || cVin.length() > 17)
        {

            Snackbar.make(view, "Enter a valid VIN number", Snackbar.LENGTH_SHORT).show();
            vinInput.requestFocus();
            return;
        }
        else {
            carGet = new NetworkCarInfoFetch(this);
            carGet.delegate = this;
            lookUpCar();
        }
    }

    @OnClick(R.id.manualEntryButton)
    public void startManualEntry(){
        Intent intent = new Intent(getApplicationContext(), AddCar.class);
        startActivity(intent);
        finish();
    }

    private void lookUpCar() {
        if (isNetWorkAvailable()) {
            Log.d(TAG, "Calling Network");
            carGet.execute(cVin);
        }
    }
    public void showSnackbar(){
        RelativeLayout layout = (RelativeLayout) findViewById(R.id.carSetupLayout);
        Snackbar.make(layout, "Could not fetch car details", Snackbar.LENGTH_SHORT).show();

    }


    public void parseResponse() throws JSONException {
        JSONObject car = new JSONObject(jsonData);
        String year = car.getString("year");
        String make = car.getJSONObject("make").getString("name");
        String model = car.getJSONObject("model").getString("name");
        tempCar.setYear(year);
        tempCar.setMake(make);
        tempCar.setModel(model);


    }

    private boolean isNetWorkAvailable() {
        ConnectivityManager manager = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
        Log.v(TAG, "NETWORK IS AVAILABLE");
        NetworkInfo networkInfo = manager.getActiveNetworkInfo();
        boolean isAvailable = false;
        if (networkInfo != null && networkInfo.isConnected()){
            isAvailable = true;
        }

        return isAvailable;
    }
}
