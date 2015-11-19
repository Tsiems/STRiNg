package string.carfile;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.Snackbar;
import android.support.v7.app.ActionBarActivity;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.KeyEvent;
import android.view.MenuItem;
import android.view.View;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import java.util.List;

import butterknife.Bind;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class AddCar extends AppCompatActivity {
    private static final String TAG = "AddCar";
    private CarInfo car;
    private boolean isEditing;

    @Bind(R.id.carNameInput) EditText name;
    @Bind(R.id.carMakeInput) EditText make;
    @Bind(R.id.carModelInput) EditText model;
    @Bind(R.id.carYearInput) EditText year;
    @Bind(R.id.carColorInput) EditText color;
    @Bind(R.id.carPriceInput) EditText price;
    @Bind(R.id.carVinInput) EditText vin;
    @Bind(R.id.carLicenseInput) EditText license;
    @Bind(R.id.carNotesInput) EditText notes;
    @Bind(R.id.carAddButton) Button carSubmit;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_car);
        ButterKnife.bind(this);
        Bundle data = getIntent().getExtras();
        isEditing = false;
        if (data.getString("carMake") != null){
            Log.d(TAG, "Starting manual data entry");
            make.setText(data.getString("carMake"));
            model.setText(data.getString("carModel"));
            year.setText(data.getString("carYear"));
            vin.setText(data.getString("carVin"));
        }
        if(data.getString("vinForEdit") != null){
            isEditing = true;
            List<CarInfo> query = CarInfo.find(CarInfo.class, "vin = ?", data.getString("vinForEdit"));
            car = query.get(0);
            name.setText(car.getCarName());
            make.setText(car.getMake());
            model.setText(car.getModel());
            year.setText(car.getYear());
            color.setText(car.getColor());
            price.setText(car.getPrice() + "");
            license.setText(car.getLicense());
            vin.setText(car.getVin());
            notes.setText(car.getNotes());
        }


    }

    @OnClick(R.id.carAddButton)
    void submit(View view){
        Log.d(TAG, "Submit button pressed");
        InputMethodManager imm = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
        imm.hideSoftInputFromWindow(notes.getWindowToken(), 0);
        String cName = name.getText().toString();
        String cMake = make.getText().toString();
        String cModel = model.getText().toString();
        String cYear = year.getText().toString();
        String cColor = color.getText().toString();
        int cPrice;
        String cVin = vin.getText().toString();
        String cLicense = license.getText().toString();
        String cNotes = notes.getText().toString();
        if (cName.length() == 0 || cName.length() > 25)
        {
            Snackbar.make(view, "Enter a valid name less than 25 characters", Snackbar.LENGTH_SHORT).show();
            name.requestFocus();
            return;
        }
        if (cMake.length() == 0 || cMake.length() > 50)
        {
            Snackbar.make(view, "Enter a valid make less than 50 characters", Snackbar.LENGTH_SHORT).show();
            make.requestFocus();
            return;
        }
        if (cModel.length() == 0 || cModel.length() > 50)
        {
            Snackbar.make(view, "Enter a valid car model less than 50 characters", Snackbar.LENGTH_SHORT).show();
            model.requestFocus();
            return;
        }
        if (cYear.length() == 0 || cYear.length() > 4)
        {
            Snackbar.make(view, "Enter a valid year", Snackbar.LENGTH_SHORT).show();
            year.requestFocus();
            return;
        }
        if (cColor.length() == 0 || cColor.length() > 25)
        {
            Snackbar.make(view, "Enter a valid color less than 25 characters", Snackbar.LENGTH_SHORT).show();
            color.requestFocus();
            return;
        }
        if (price.getText().toString().length() == 0)
        {
            Snackbar.make(view, "Enter a price for the car", Snackbar.LENGTH_SHORT).show();
            price.requestFocus();
            return;
        }
        cPrice = Integer.parseInt(price.getText().toString());
        if(cVin.length() < 11 || cVin.length() > 17)
        {

            Snackbar.make(view, "Enter a valid VIN number", Snackbar.LENGTH_SHORT).show();
            vin.requestFocus();
            return;
        }
        if(cLicense.length() == 0)
        {
            cLicense = "None";
        }
        if(cNotes.length() > 200)
        {
            Snackbar.make(view, "Only 200 characters allowed in notes", Snackbar.LENGTH_SHORT).show();
            notes.requestFocus();
            return;
        }

        if(isEditing == false){
            List<CarInfo> query = CarInfo.find(CarInfo.class, "vin = ?", cVin);
            if(!query.isEmpty()) {
                Log.d(TAG, cVin + " is already used!");
                Snackbar.make(view, "Vin Already Exists", Snackbar.LENGTH_SHORT).show();
                return;
            }
            car = new CarInfo(cName, cMake, cModel, cYear, cColor, cPrice, cVin, cLicense, cNotes);
            car.save();
            finish();
        }
        else {
            car.setAll(cName, cMake, cModel, cYear, cColor, cPrice, cVin, cLicense, cNotes);
            Intent intent = new Intent();
            intent.putExtra("VIN_NUMBER_RESULT", car.getVin());
            setResult(1, intent); //result of 1 signals save was a success
            car.save();
            finish();
        }








    }








}
