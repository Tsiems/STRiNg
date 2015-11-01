package string.carfile;

import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import com.melnykov.fab.FloatingActionButton;

import java.util.ArrayList;

import butterknife.Bind;
import butterknife.ButterKnife;


public class Home extends ActionBarActivity {

    @Bind(R.id.carList) ListView carList;
    @Bind(R.id.homeFab) FloatingActionButton homeFab;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);
        ButterKnife.bind(this);
        //homeFab.attachToListView(carList);
        populateList();
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_home, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
    private void populateList() {
        ArrayList<String> cars = new ArrayList<String>();
        cars.add("Ford Pinto");
        cars.add("Mercedes E350");
        cars.add("Toyota Camry");
        cars.add("Ferrari California");
        cars.add("Ford Pinto");
        cars.add("Mercedes E350");
        cars.add("Toyota Camry");
        cars.add("Ferrari California");
        cars.add("Ford Pinto");
        cars.add("Mercedes E350");
        cars.add("Toyota Camry");
        cars.add("Ferrari California");
        ArrayAdapter<String> arrayAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, cars);
        carList.setAdapter(arrayAdapter);
    }
}
