package string.carfile;

import android.content.Context;
import android.os.Bundle;
import android.support.design.widget.Snackbar;
import android.support.v7.app.ActionBarActivity;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import butterknife.Bind;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class AddCar extends AppCompatActivity {
    private static final String TAG = "AddCar";

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
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        ButterKnife.bind(this);
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
        if (cMake.length() == 0 || cMake.length() > 25)
        {
            Snackbar.make(view, "Enter a valid make less than 25 characters", Snackbar.LENGTH_SHORT).show();
            make.requestFocus();
            return;
        }
        if (cModel.length() == 0 || cModel.length() > 25)
        {
            Snackbar.make(view, "Enter a valid car model less than 25 characters", Snackbar.LENGTH_SHORT).show();
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

        CarInfo newCar = new CarInfo(cName, cMake, cModel, cYear, cColor, cPrice, cVin, cLicense, cNotes);
        newCar.save();
        finish();


    }






}
