package string.carfile;

import android.content.Context;
import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.view.KeyEvent;
import android.view.View;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import butterknife.Bind;
import butterknife.OnClick;

public class AddCar extends ActionBarActivity {

    @Bind(R.id.carNameInput) EditText carName;
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
    }

    @OnClick(R.id.carAddButton)
    void submit(View view){
        InputMethodManager imm = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
        imm.hideSoftInputFromWindow(notes.getWindowToken(), 0);
    }

}
