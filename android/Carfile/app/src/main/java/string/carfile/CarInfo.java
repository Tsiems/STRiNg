package string.carfile;

import android.os.Parcel;
import android.os.Parcelable;

import com.orm.SugarRecord;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Nick on 11/1/2015.
 */
public class CarInfo extends SugarRecord<CarInfo> implements Parcelable {
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
    public void setAll(String carName, String make, String model, String year, String color, int price, String vin, String license, String notes){
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

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeString(this.carName);
        dest.writeString(this.make);
        dest.writeString(this.model);
        dest.writeString(this.year);
        dest.writeString(this.color);
        dest.writeInt(this.price);
        dest.writeString(this.vin);
        dest.writeString(this.license);
        dest.writeString(this.notes);
    }

    protected CarInfo(Parcel in) {
        this.carName = in.readString();
        this.make = in.readString();
        this.model = in.readString();
        this.year = in.readString();
        this.color = in.readString();
        this.price = in.readInt();
        this.vin = in.readString();
        this.license = in.readString();
        this.notes = in.readString();
    }

    public static final Parcelable.Creator<CarInfo> CREATOR = new Parcelable.Creator<CarInfo>() {
        public CarInfo createFromParcel(Parcel source) {
            return new CarInfo(source);
        }

        public CarInfo[] newArray(int size) {
            return new CarInfo[size];
        }
    };
}

