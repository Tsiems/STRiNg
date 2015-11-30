package string.carfile;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.support.v7.app.AppCompatActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.TextView;

import java.util.List;

import butterknife.Bind;
import butterknife.ButterKnife;

public class MaintenanceDisplay extends AppCompatActivity {

    @Bind(R.id.maintainTypeDisplay) TextView typeView;
    @Bind(R.id.locationDisplay) TextView location;
    @Bind(R.id.dateDisplay) TextView lastDate;
    @Bind(R.id.dueDateDisplay) TextView nextDate;
    @Bind(R.id.priceDisplay) TextView price;
    @Bind(R.id.notesDisplay) TextView notes;
    private String type;
    private long carId;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_maintenance_display);
        ButterKnife.bind(this);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        getSupportActionBar().setElevation(0);
        Bundle b = getIntent().getExtras();
        type = b.getString("type");
        carId = b.getLong("carID");

        populateWindow();
    }
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.edit_maintain_item, menu);
        return true;
    }
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {

            case R.id.editMaintainButton:
                Intent editDetails = new Intent(this, AddMaintenanceItem.class);
                ////Put extra value
                editDetails.putExtra("type", type);
                editDetails.putExtra("carID", carId);
                editDetails.putExtra("edit", 1);
                List<MaintenanceItem> check1 = MaintenanceItem.find(MaintenanceItem.class, "type = ? and car_id = ?", type, carId + "");
                editDetails.putExtra("id", check1.get(0).getId());
                startActivity(editDetails);
                return true;

            case R.id.deleteMaintainButton:
                //Delete item
                List<MaintenanceItem> check = MaintenanceItem.find(MaintenanceItem.class, "type = ? and car_id = ?", type, carId + "");
                check.get(0).delete();
                finish();
                return true;

            default:
                // If we got here, the user's action was not recognized.
                // Invoke the superclass to handle it.
                return super.onOptionsItemSelected(item);

        }
    }




    protected void onResume(){
        super.onResume();
        populateWindow();
    }




    private void populateWindow(){
        List<MaintenanceItem> m = MaintenanceItem.find(MaintenanceItem.class, "type = ? and car_id = ?", type, carId + "");
        MaintenanceItem temp = m.get(0);
        typeView.setText(type);
        location.setText(temp.getLocation());
        lastDate.setText(temp.getDateString());
        nextDate.setText(temp.getNextDateString());
        price.setText(temp.getPrice());
        notes.setText(temp.getNotes());
    }

}
