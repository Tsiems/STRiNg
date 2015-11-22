package string.carfile;

import android.app.DatePickerDialog;
import android.app.DialogFragment;
import android.app.FragmentTransaction;
import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.util.Log;
import android.view.View;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;

import java.util.Calendar;

import butterknife.Bind;
import butterknife.ButterKnife;
import butterknife.OnClick;
import butterknife.OnFocusChange;

public class AddMaintenanceItem extends ActionBarActivity {

    @Bind(R.id.dateInput) EditText dateInput;
    @Bind(R.id.dateDueInput) EditText dateDueInput;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_maintenance_item);
        ButterKnife.bind(this);
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


}
