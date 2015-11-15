package string.carfile;

import android.support.design.widget.Snackbar;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import butterknife.Bind;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class CarSetUp extends ActionBarActivity {


    @Bind(R.id.vinNumberEnter) EditText vinInput;
    @Bind(R.id.setupContinue) Button continueButton;
    String cVin;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_car_set_up);
        ButterKnife.bind(this);

    }
    @OnClick(R.id.setupContinue)
    public void submit(View view){
        cVin = vinInput.getText().toString();
        if(cVin.length() < 11 || cVin.length() > 17)
        {

            Snackbar.make(view, "Enter a valid VIN number", Snackbar.LENGTH_SHORT).show();
            vinInput.requestFocus();
            return;
        }
        else {
            lookUpCar();
        }
    }

    private void lookUpCar(){










    }
}
