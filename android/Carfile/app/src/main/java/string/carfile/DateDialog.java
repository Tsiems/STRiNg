package string.carfile;

import android.app.DatePickerDialog;
import android.app.Dialog;
import android.app.DialogFragment;
import android.os.Bundle;
import android.view.View;
import android.widget.DatePicker;
import android.widget.EditText;

import java.util.Calendar;

/**
 * Created by Nick on 11/21/2015.
 */
public class DateDialog extends DialogFragment implements DatePickerDialog.OnDateSetListener {
    private long time;

    EditText txtDate;
    public DateDialog(){

    }
    public void setView(View view){
        txtDate = (EditText) view;
    }

    public Dialog onCreateDialog(Bundle savedInstanceState){
        final Calendar calendar = Calendar.getInstance();
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH);
        int day = calendar.get(Calendar.DAY_OF_MONTH);
        time = calendar.getTime().getTime();
        return new DatePickerDialog(getActivity(), this, year, month, day);
    }

    public void onDateSet(DatePicker view, int year, int month, int day){
        String date = month + "-" + day + "-" + year;
        txtDate.setText(date);
    }
    public long getTime(){
        return time;
    }
}
