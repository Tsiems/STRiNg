package string.carfile;

import com.orm.SugarRecord;

/**
 * Created by Nick on 11/1/2015.
 */
public class CarInfo extends SugarRecord<CarInfo> {
    private String carName;
    private String make;
    private String model;
    private String year;
    private String color;
    private int price;
    private String vin;
    private String license;
    private String notes;

    public CarInfo() {
    }

    public CarInfo(String carName, String make, String model, String year, String color, int price, String vin, String license, String notes) {
        this.carName = carName;
        this.make = make;
        this.model = model;
        this.year = year;
        this.color = color;
        this.price = price;
        this.vin = vin;
        this.license = license;
        this.notes = notes;
    }

    public String getCarName() {
        return carName;
    }

    public void setCarName(String carName) {
        this.carName = carName;
    }

    public String getMake() {
        return make;
    }

    public void setMake(String make) {
        this.make = make;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getVin() {
        return vin;
    }

    public void setVin(String vin) {
        this.vin = vin;
    }

    public String getLicense() {
        return license;
    }

    public void setLicense(String license) {
        this.license = license;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}