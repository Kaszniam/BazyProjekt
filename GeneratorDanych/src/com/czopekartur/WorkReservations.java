package com.czopekartur;

import java.io.BufferedWriter;
import java.io.IOException;

/**
 * Created by czopo on 1/3/16.
 */
public class WorkReservations {
    
    public static void generate(BufferedWriter writer) throws IOException {
        
        int el = Data.r.nextInt(Data.listOfWorkshops.size());
        Data.workResWorkId = Data.listOfWorkshops.get(el);
        Data.workResWorkSlots = Data.listOfWorkshopSlots.get(el);
        
        if(Data.confResSize <= Data.workResWorkSlots) {
            Data.workResId++;
            Data.mainBuilder.delete(0, Data.mainBuilder.length());
            Data.mainBuilder.append("      INSERT INTO WorkReservation VALUES (");
            Data.mainBuilder.append(Data.workResWorkId);
            Data.mainBuilder.append(", ");
            Data.mainBuilder.append(Data.currentResID);
            Data.mainBuilder.append(", '");
            Data.mainBuilder.append(Data.currentResDate);
            Data.mainBuilder.append("', ");
            Data.mainBuilder.append(Data.confResSize);
            Data.mainBuilder.append(", 0)");
            writer.write(Data.mainBuilder.toString());
            writer.newLine();
            writer.newLine();
            Data.listOfWorkshopSlots.set(el, Data.workResWorkSlots - Data.confResSize);
        }
    }
}
