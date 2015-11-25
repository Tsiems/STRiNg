package string.carfile;

import com.orm.SugarRecord;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Nick on 11/14/2015.
 */
public class MaintenanceItem extends SugarRecord<MaintenanceItem> {
    private String type; // e.g. oil, engine, other
    private long lastDate;
    private long nextDate;
    private String location;
    private String price;
    private String notes;
    private long carID;

    public MaintenanceItem(){

    }

    public long getCarID() {
        return carID;
    }

    public void setCarID(long carID) {
        this.carID = carID;
    }

    public MaintenanceItem(String type, String location, String price, String notes, long carID) {
        this.type = type;
        this.location = location;
        this.price = price;
        this.notes = notes;
        this.carID = carID;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public long getLastDate() {
        return lastDate;
    }

    public void setLastDate(String lastDate) {
        SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yyyy");
        Date date = null;
        try {
            date = sdf.parse(lastDate);
        } catch (ParseException e) {
            this.lastDate = 0;
        }
        this.lastDate = date.getTime();
    }

    public long getNextDate() {
        return nextDate;
    }

    public void setNextDate(String nextDate) {
        SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yyyy");
        Date date = null;
        try {
            date = sdf.parse(nextDate);
        } catch (ParseException e) {
            this.nextDate = 0;
        }
        this.nextDate = date.getTime();
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}
