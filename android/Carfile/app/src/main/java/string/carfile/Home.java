package string.carfile;

import android.content.Intent;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import com.melnykov.fab.FloatingActionButton;
import java.util.ArrayList;
import java.util.List;

import butterknife.Bind;
import butterknife.ButterKnife;
import butterknife.OnClick;


public class Home extends AppCompatActivity {

    @Bind(R.id.carList) RecyclerView carList;
    @Bind(R.id.homeFab) FloatingActionButton homeFab;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);
        ButterKnife.bind(this);
        //homeFab.attachToListView(carList);
        LinearLayoutManager llm = new LinearLayoutManager(this);
        llm.setOrientation(LinearLayoutManager.VERTICAL);
        carList.setLayoutManager(llm);
        CarAdapter carAdapter = new CarAdapter(populateList());
        carList.setAdapter(carAdapter);
    }

    @OnClick(R.id.homeFab)
    public void addCar(View view) {
        Intent carAddPage = new Intent(getApplicationContext(), AddCar.class);
        startActivity(carAddPage);
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
    private List<CarInfo> populateList() {
        List<CarInfo> cars = new ArrayList<>();
        cars.add(new CarInfo("Nick's Car", "Mini", "Countryman", 2012));
        cars.add(new CarInfo("Steven's Car", "Ford", "Focus", 2015));
        cars.add(new CarInfo("Bob's Car", "Ford", "Model-T", 1913));
        cars.add(new CarInfo("Jill's Car", "BMW", "X5", 2014));
        cars.add(new CarInfo("Nick's Car", "Mini", "Countryman", 2012));
        cars.add(new CarInfo("Steven's Car", "Ford", "Focus", 2015));
        cars.add(new CarInfo("Bob's Car", "Ford", "Model-T", 1913));
        cars.add(new CarInfo("Jill's Car", "BMW", "X5", 2014));
        cars.add(new CarInfo("Nick's Car", "Mini", "Countryman", 2012));
        cars.add(new CarInfo("Steven's Car", "Ford", "Focus", 2015));
        cars.add(new CarInfo("Bob's Car", "Ford", "Model-T", 1913));
        cars.add(new CarInfo("Jill's Car", "BMW", "X5", 2014));

       // ArrayAdapter<String> arrayAdapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, cars);
        return cars;
    }
}
