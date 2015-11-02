package string.carfile;

/**
 * Created by Nick on 11/1/2015.
 */
public class CarInfo {
    private String carName;
    private String make;
    private String model;
    private int year;

    public CarInfo() {

    }

    public CarInfo(String carName, String make, String model, int year) {

        this.carName = carName;
        this.make = make;
        this.model = model;
        this.year = year;
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

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }
}
