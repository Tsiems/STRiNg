package string.carfile;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;

import com.melnykov.fab.FloatingActionButton;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import butterknife.Bind;
import butterknife.ButterKnife;
import butterknife.OnClick;


public class CarPage extends AppCompatActivity {
    @Bind(R.id.carPageListView) ListView itemListView;
    @Bind(R.id.carPageImage) ImageView carImage;
    @Bind(R.id.carDetailsButton) Button carDetailsButton;
    @Bind(R.id.carPageFab) FloatingActionButton fab;
    private static final String TAG = "CarPage";
    private static final int CAR_INFO_CODE= 111;
    private CarInfo myCar;
    private ArrayList<String> itemList;
    private ArrayAdapter<String> arrayAdapter;
    private List<MaintenanceItem> maintainItems;

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
        getMaintainItems();
        itemListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Intent maintenanceView = new Intent(getApplicationContext(), MaintenanceDisplay.class);
                maintenanceView.putExtra("carID", maintainItems.get(position).getCarID());
                maintenanceView.putExtra("type", maintainItems.get(position).getType());
                startActivity(maintenanceView);
            }
        });
    }


    @Override
    protected void onResume(){
        super.onResume();
        getMaintainItems();
    }
    @OnClick(R.id.carDetailsButton)
    public void lookAtCarDetails(View view){
        Intent intent = new Intent(getApplicationContext(), CarInfomationActivity.class);
        intent.putExtra("vin", myCar.getVin());
        startActivityForResult(intent, CAR_INFO_CODE);
    }

    @OnClick(R.id.carPageFab)
    public void addMaintenanceInfo(View view){
        Intent addInfo = new Intent(getApplicationContext(), AddMaintenanceItem.class);
        addInfo.putExtra("id", myCar.getId());
        addInfo.putExtra("edit", 0);
        startActivity(addInfo);
    }

    protected void onActivityResult(int requestCode, int resultCode, Intent data){
        if(requestCode == CAR_INFO_CODE){
            if (resultCode == RESULT_OK) {
                String vinIdent = data.getStringExtra("VIN_NUMBER");
                List<CarInfo> query = CarInfo.find(CarInfo.class, "vin = ?", vinIdent);
                myCar = query.get(0);
                setTitle(myCar.getCarName());
            }
        }

    }

    private void getMaintainItems(){
        maintainItems = MaintenanceItem.find(MaintenanceItem.class, "car_id = ?", myCar.getId() + "");
        Log.d(TAG, "MaintainItems size is = " + maintainItems.size());
        itemList = new ArrayList<>();
        for(int i = 0; i < maintainItems.size(); i++){
            itemList.add(maintainItems.get(i).getType());
        }

        arrayAdapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, itemList);
        itemListView.setAdapter(arrayAdapter);
    }


}
