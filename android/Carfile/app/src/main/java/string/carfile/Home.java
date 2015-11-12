package string.carfile;

import android.content.Intent;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
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
    private List<CarInfo> cars = CarInfo.listAll(CarInfo.class);
    private CarAdapter carAdapter;
    private static final String TAG = "Home";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);
        ButterKnife.bind(this);
        //homeFab.attachToListView(carList);
        LinearLayoutManager llm = new LinearLayoutManager(this);
        llm.setOrientation(LinearLayoutManager.VERTICAL);
        carList.setLayoutManager(llm);
        carAdapter = new CarAdapter(cars);
        carList.setAdapter(carAdapter);
    }
    @Override
    protected void onResume(){
        super.onResume();
        Log.d(TAG, "onResume Called");
        cars = CarInfo.listAll(CarInfo.class);
        carAdapter.setCars(cars);
        carAdapter.notifyDataSetChanged();
    }

    @OnClick(R.id.homeFab)
    public void addCar(View view) {
        Intent carAddPage = new Intent(getApplicationContext(), AddCar.class);
        startActivityForResult(carAddPage, 0);
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

}
