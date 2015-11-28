package string.carfile;

import android.app.DatePickerDialog;
import android.app.Dialog;
import android.app.DialogFragment;
import android.os.Bundle;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.TextView;

import java.util.Calendar;

/**
 * Created by Nick on 11/22/2015.
 */
public class DatePickerFrag extends DialogFragment implements DatePickerDialog.OnDateSetListener {

    private EditText txt;
    public void setEditText(EditText txt){
        this.txt = txt;
    }


    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState){
        final Calendar c = Calendar.getInstance();
        int year = c.get(Calendar.YEAR);
        int month = c.get(Calendar.MONTH);
        int day = c.get(Calendar.DAY_OF_MONTH);

        return new DatePickerDialog(getActivity(), this, year, month, day);
    }

    public void onDateSet(DatePicker view, int year, int month, int day){
        String temp = (month + 1) + "-" + day + "-" + year;
        if (month < 10){
            temp = "0" + (month + 1) + "-" + day + "-" + year;
        }
        txt.setText(temp);

    }




}
