package string.carfile;

import com.orm.SugarRecord;

import java.util.Date;

/**
 * Created by Nick on 11/14/2015.
 */
public class MaintenanceItem extends SugarRecord<MaintenanceItem> {
    private String type; // e.g. oil, engine, other
    private String name; // for other
    private int lastDate;
    private int nextDate;
    private String location;
    private double price;
    private String notes;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getLastDate() {
        return lastDate;
    }

    public void setLastDate(int lastDate) {
        this.lastDate = lastDate;
    }

    public int getNextDate() {
        return nextDate;
    }

    public void setNextDate(int nextDate) {
        this.nextDate = nextDate;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}
