package string.carfile;

import com.orm.SugarRecord;

import java.util.Date;

/**
 * Created by Nick on 11/14/2015.
 */
public class MaintenanceItem extends SugarRecord<MaintenanceItem> {
    private String type; // e.g. oil, engine, other
    private String name; // for other
    private Date firstDate;
    private Date secondDate;
    private String location;




}
