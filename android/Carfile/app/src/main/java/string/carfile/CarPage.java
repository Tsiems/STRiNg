package string.carfile;

import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import butterknife.Bind;
import butterknife.ButterKnife;


public class CarPage extends AppCompatActivity {
    @Bind(R.id.carPageListView) ListView itemListView;
    @Bind(R.id.carPageImage) ImageView carImage;
    private static final String TAG = "CarPage";
    private CarInfo myCar;
    private ArrayList<String> itemList;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_car_page);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        ButterKnife.bind(this);
        Bundle extras = getIntent().getExtras();
        String carVin = extras.getString("vin", "NULL");
        Log.d(TAG, carVin);
        List<CarInfo> query = CarInfo.find(CarInfo.class, "vin = ?", carVin);
        myCar = query.get(0);
        setTitle(myCar.getCarName());
        itemList = new ArrayList<>(Arrays.asList("Oil", "Engine", "Repairs", "Checkup"));
        ArrayAdapter<String> arrayAdapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, itemList);
        itemListView.setAdapter(arrayAdapter);



    }

}
