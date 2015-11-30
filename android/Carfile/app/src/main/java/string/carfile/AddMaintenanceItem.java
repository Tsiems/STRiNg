package string.carfile;

import android.app.DatePickerDialog;
import android.app.DialogFragment;
import android.app.FragmentTransaction;
import android.os.Bundle;
import android.support.design.widget.Snackbar;
import android.support.v7.app.ActionBarActivity;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;

import java.util.Calendar;
import java.util.List;

import butterknife.Bind;
import butterknife.ButterKnife;
import butterknife.OnClick;
import butterknife.OnFocusChange;

public class AddMaintenanceItem extends ActionBarActivity {
    public static final String TAG = "ADDMAIT";

    @Bind(R.id.typeInput) AutoCompleteTextView typeInput;
    @Bind(R.id.dateInput) EditText dateInput;
    @Bind(R.id.dateDueInput) EditText dateDueInput;
    @Bind(R.id.locationInput) EditText locationInput;
    @Bind(R.id.maintainPriceInput) EditText priceInput;
    @Bind(R.id.maintainNotesInput) EditText notesInput;
    @Bind(R.id.saveMaintainButton) Button saveButton;
    private long carId;
    private boolean isEdit; //used to select how data is saved, type might change when editing.
    private long itemId; //used for editing
    private String[] maintenanceTypes;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_maintenance_item);
        ButterKnife.bind(this);
        maintenanceTypes = getResources().getStringArray(R.array.maintenanceTypes);
        ArrayAdapter<String> dropDownAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_dropdown_item_1line, maintenanceTypes);
        typeInput.setAdapter(dropDownAdapter);
        isEdit = false;
        Bundle b = getIntent().getExtras();
        carId = b.getLong("id");
        Log.d(TAG, carId + "");
        //////Code for Editing Item//////
        if (b.getInt("edit") == 1){
            isEdit = true;
            typeInput.setText(b.getString("type"));
            String type = typeInput.getText().toString();
            Log.d(TAG, "Type = " + type);
            itemId = b.getLong("id");
            MaintenanceItem temp = MaintenanceItem.findById(MaintenanceItem.class, itemId);
            typeInput.setText(temp.getType());
            dateInput.setText(temp.getDateString());
            dateDueInput.setText(temp.getNextDateString());
            locationInput.setText(temp.getLocation());
            priceInput.setText(temp.getPrice());
            notesInput.setText(temp.getNotes());
            typeInput.setEnabled(false);
            typeInput.setFocusable(false);

        }




        /////////////////////////////////

    }

    @OnClick(R.id.dateInput)
    void setFirstDate(View view){
        Log.d("ADDMAIT", "OnClick worked");
        DatePickerFrag dialog = new DatePickerFrag();
        dialog.setEditText(dateInput);
        dialog.show(getFragmentManager(), "datePicker");
    }
    @OnClick(R.id.dateDueInput)
    void setSecondDate(View view){

        DatePickerFrag dialog = new DatePickerFrag();
        dialog.setEditText(dateDueInput);
        dialog.show(getFragmentManager(), "datePicker1");
    }

    @OnClick(R.id.saveMaintainButton)
    void saveInfo(View view){
        String type = typeInput.getText().toString();
        if(type.length() == 0) {
            Snackbar.make(view, "Enter a type", Snackbar.LENGTH_SHORT);
            return;
        }
        String date1 = dateInput.getText().toString();
        if(date1.length() == 0) {
            Snackbar.make(view, "Enter a first date", Snackbar.LENGTH_SHORT);
            return;
        }
        String date2 = dateDueInput.getText().toString();
        if(date2.length() == 0) {
            Snackbar.make(view, "Enter a second date", Snackbar.LENGTH_SHORT);
            return;
        }
        String location = locationInput.getText().toString();
        if(location.length() == 0) {
            location = "No location specified";
        }
        String price = priceInput.getText().toString();
        if(price.length() == 0) {
            price = "No price";
        }
        String notes = notesInput.getText().toString();
        if(isEdit == true){
            MaintenanceItem temp = MaintenanceItem.findById(MaintenanceItem.class, itemId);
            temp.setLocation(location);
            temp.setPrice(price);
            temp.setNotes(notes);
            temp.setLastDate(date1);
            temp.setNextDate(date2);
            temp.save();
            finish();
        }


        MaintenanceItem temp = new MaintenanceItem(type, location, price, notes, carId );
        List<MaintenanceItem> check = MaintenanceItem.find(MaintenanceItem.class, "type = ? and car_id = ?", type, carId + "");
        if(check.size() == 1){
            temp = check.get(0);
        }
        temp.setType(type);
        temp.setLocation(location);
        temp.setPrice(price);
        temp.setNotes(notes);
        temp.setCarID(carId);
        temp.setLastDate(date1);
        temp.setNextDate(date2);
        temp.save();
        finish();


    }



}
