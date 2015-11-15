package string.carfile;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.design.widget.Snackbar;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.Response;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Nick on 11/15/2015.
 */
public class NetworkCarInfoFetch extends AsyncTask<String, Double, CarInfo>{
    private CarInfo tempCar;
    private Activity activity;
    private OkHttpClient client;
    private boolean isSuccess;
    private View view;
    public final String TAG = "Network";
    public AsyncResponse delegate = null;


    @Override
    protected void onPreExecute(){
    }

    @Override
    protected CarInfo doInBackground(String... vin){
        client = new OkHttpClient();
        tempCar = new CarInfo();
        try {
            Log.d(TAG, "Vin = " + vin[0]);
            run(vin[0]);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (JSONException e){
            e.printStackTrace();
        }


        return tempCar;
    }

    private void run(String vin) throws IOException, JSONException {
        Request request = new Request.Builder()
                .url("https://api.edmunds.com/api/v1/vehicle/vin/" + vin + "/configuration?api_key=5zyd8sa5k3yxgpcg7t49agav")
                .build();

        Response response = client.newCall(request).execute();
        if(!response.isSuccessful()){
            Log.d(TAG, "No Response");
            return;
        }
        isSuccess = true;

        String jsonData = response.body().string();
        //Log.d("NETWORK", jsonData);

        JSONObject results = new JSONObject(jsonData);
        parseJSON(vin, jsonData);

        }

    private void parseJSON(String vin, String jsonData) throws JSONException{
        Log.d(TAG, jsonData);
        JSONObject car = new JSONObject(jsonData);
        String year = Integer.toString(car.getInt("year"));
        Log.d(TAG, year);
        String make = car.getJSONObject("make").getString("name");
        String model = car.getJSONObject("model").getString("name");
        tempCar.setYear(year);
        tempCar.setMake(make);
        tempCar.setModel(model);
        tempCar.setVin(vin);
        Log.d(TAG, "Got Car Info");
        activity.finish();
        return;



    }
    @Override
    protected void onPostExecute(CarInfo tempCar){
        if(isSuccess == false){
            Log.d(TAG, "Couldn't get car info");
            delegate.processFinish("fail");
            return;
        }
        else {
            Intent intent = new Intent(activity.getApplicationContext(), AddCar.class);
            intent.putExtra("carMake", tempCar.getMake());
            intent.putExtra("carModel", tempCar.getModel());
            intent.putExtra("carYear", tempCar.getYear());
            intent.putExtra("carVin", tempCar.getVin());
            Log.d(TAG, tempCar.getMake() + "");
            activity.startActivity(intent);
        }
    }

    public NetworkCarInfoFetch(Activity activity) {
        this.activity = activity;
        isSuccess = false;
    }
    public void setView(View view){
        this.view = view;
    }


}
