package string.carfile;

import android.content.Context;
import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.List;

/**
 * Created by Nick on 11/1/2015.
 */
public class CarAdapter extends RecyclerView.Adapter<CarAdapter.CarViewHolder> {
    private List<CarInfo> cars;
    public static final String TAG = "CarAdapter";
    public OnItemClickListener itemClickListener;


    public CarAdapter(List<CarInfo> cars) {
        this.cars = cars;
    }

    @Override
    public CarViewHolder onCreateViewHolder(ViewGroup viewGroup, int i) {
        View view = LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.carlist_layout, viewGroup, false);
        return new CarViewHolder(view);
    }


    @Override
    public int getItemCount() {
        if (cars == null)
        {
            return 0;
        }
        return cars.size();
    }
    @Override
    public void onBindViewHolder(CarViewHolder carViewHolder, int i) {
        CarInfo ci = cars.get(i);
        carViewHolder.carName.setText(ci.getCarName());
        carViewHolder.carInformation.setText(ci.getYear() + " " + ci.getMake() + " " + ci.getModel());
        carViewHolder.itemView.setLongClickable(true);
    }

    public void setCars(List<CarInfo> cars) {
        this.cars = cars;
    }


    public class CarViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener, View.OnLongClickListener {
        public ImageView carPicture;
        public TextView carName;
        public TextView carInformation;

        public CarViewHolder(View itemView) {
            super(itemView);
            carName = (TextView) itemView.findViewById(R.id.carName);
            carInformation = (TextView) itemView.findViewById(R.id.carInformation);
            itemView.setOnClickListener(this);
            itemView.setOnLongClickListener(this);

        }

        @Override
        public void onClick(View view) {
            Log.d(TAG, "onClick " + getPosition());
            if (itemClickListener != null) {
                itemClickListener.onItemClick(view, getPosition());
            }
        }
        @Override
        public boolean onLongClick(View view) {

            Log.d(TAG, "onLongClick " + getPosition());
            if (itemClickListener != null) {
                itemClickListener.onItemLongClick(view, getPosition());
            }
            return true;
        }

    }
    public void setOnItemClickListener(final OnItemClickListener itemClickListener){
        this.itemClickListener = itemClickListener;
    }
    public void setOnLongItemClickListener(final OnItemClickListener itemClickListener){
        this.itemClickListener = itemClickListener;
    }





}
