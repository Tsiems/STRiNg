package string.carfile;

import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;

import java.util.List;

public class CarPage extends AppCompatActivity {
    private static final String TAG = "CarPage";
    private CarInfo myCar;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_car_page);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        Bundle extras = getIntent().getExtras();
        String carVin = extras.getString("vin", "NULL");
        Log.d(TAG, carVin);

        List<CarInfo> query = CarInfo.find(CarInfo.class, "vin = ?", carVin);
        myCar = query.get(0);
        setTitle(myCar.getCarName());

    }

}
