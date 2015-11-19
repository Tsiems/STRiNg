package string.carfile;

import android.content.Intent;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.TextView;

import java.util.List;

import butterknife.Bind;
import butterknife.ButterKnife;

public class CarInfomationActivity extends AppCompatActivity {

    private static int RESULT_GOOD = 1;
    private static int EDIT_REQUEST_CODE = 1;
    @Bind(R.id.carInfoName) TextView name;
    @Bind(R.id.carInfoMake) TextView make;
    @Bind(R.id.carInfoModel) TextView model;
    @Bind(R.id.carInfoYear) TextView year;
    @Bind(R.id.carInfoColor) TextView color;
    @Bind(R.id.carInfoPrice) TextView price;
    @Bind(R.id.carInfoLicense) TextView license;
    @Bind(R.id.carInfoVin) TextView vin;
    @Bind(R.id.carInfoNotes) TextView notes;



    private CarInfo myCar;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_car_infomation);
        ButterKnife.bind(this);
        Bundle b = getIntent().getExtras();
        String vinIdent = b.getString("vin");
        List<CarInfo> query = CarInfo.find(CarInfo.class, "vin = ?", vinIdent);
        myCar = query.get(0);
        populatePage();
    }

    private void populatePage() {
        name.setText(myCar.getCarName());
        make.setText(myCar.getMake());
        model.setText(myCar.getModel());
        year.setText(myCar.getYear());
        color.setText(myCar.getColor());
        price.setText("$" + myCar.getPrice());
        license.setText(myCar.getLicense());
        vin.setText(myCar.getVin());
        if (myCar.getNotes().equals("")){
            notes.setText(R.string.noNotes);
        }
        else {
            notes.setText(myCar.getNotes());
        }

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.edit_car_details_menu, menu);
        return true;
    }
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {

            case R.id.editCarDetailsButton:
                Intent editCarDetails = new Intent(this, AddCar.class);
                editCarDetails.putExtra("vinForEdit", myCar.getVin());
                startActivityForResult(editCarDetails, EDIT_REQUEST_CODE);
                return true;

            default:
                // If we got here, the user's action was not recognized.
                // Invoke the superclass to handle it.
                return super.onOptionsItemSelected(item);

        }
    }
    protected void onActivityResult(int requestCode, int resultCode, Intent data){
        if(requestCode == EDIT_REQUEST_CODE){
            if (resultCode == RESULT_GOOD) {
                String vinIdent = data.getStringExtra("VIN_NUMBER_RESULT");
                List<CarInfo> query = CarInfo.find(CarInfo.class, "vin = ?", vinIdent);
                myCar = query.get(0);
                populatePage();
            }
        }
    }
    public void onBackPressed() {
        // super.onBackPressed();

        Intent intent = new Intent();
        intent.putExtra("VIN_NUMBER", myCar.getVin());
        setResult(RESULT_OK, intent);
        finish();
    }
}
