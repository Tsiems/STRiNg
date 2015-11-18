package string.carfile;

import android.content.Intent;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.ContextMenu;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import com.melnykov.fab.FloatingActionButton;
import java.util.ArrayList;
import java.util.List;

import butterknife.Bind;
import butterknife.ButterKnife;
import butterknife.OnClick;
import butterknife.OnItemClick;


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
        Log.d(TAG, "Cars in list: " + cars.size());
        //homeFab.attachToListView(carList);
        LinearLayoutManager llm = new LinearLayoutManager(this);
        llm.setOrientation(LinearLayoutManager.VERTICAL);
        carList.setLayoutManager(llm);
        carAdapter = new CarAdapter(cars);
        carList.setAdapter(carAdapter);
        registerForContextMenu(carList);
        carAdapter.setOnItemClickListener(new OnItemClickListener() {
            @Override
            public void onItemClick(View view, int position) {
                Intent carPage = new Intent(getApplicationContext(), CarPage.class);
                Bundle b = new Bundle();
                b.putString("vin", cars.get(position).getVin());
                carPage.putExtras(b);
                startActivity(carPage);
            }

            @Override
            public void onItemLongClick(View view, int position) {
                Log.d(TAG, "ITEM WAS LONG PRESSED!");
                openContextMenu(view);

            }
        });

    }
    @Override
    public void onCreateContextMenu(ContextMenu menu, View v,
                                    ContextMenu.ContextMenuInfo menuInfo) {
        super.onCreateContextMenu(menu, v, menuInfo);
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.cardeletemenu, menu);
        menu.setHeaderTitle("Delete Car?");
    }


    @Override
    protected void onResume(){
        super.onResume();
        Log.d(TAG, "onResume Called");
        resetCarList();
    }

    private void resetCarList() {
        cars = CarInfo.listAll(CarInfo.class);
        carAdapter.setCars(cars);
        carAdapter.notifyDataSetChanged();
    }


    @OnClick(R.id.homeFab)
    public void addCar(View view) {
        Intent carAddPage = new Intent(getApplicationContext(), CarSetUp.class);
        startActivityForResult(carAddPage, 0);
    }
}
