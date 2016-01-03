package com.czopekartur;

import java.io.BufferedWriter;
import java.io.IOException;

/**
 * Created by czopo on 1/3/16.
 */
public class Cancel {
    
    public static void generate(BufferedWriter writer) throws IOException {
        declareValues();
        Data.mainBuilder.delete(0, Data.mainBuilder.length());
        writer.newLine();
        writer.write("--MAYBE CANCEL SOMETHING?");
        writer.newLine();
        writer.newLine();
        cancelConfs(writer);
        cancelConfRess(writer);
        cancelWorks(writer);
        cancelWorkRess(writer);
    }
    
    private static void declareValues() {
        Data.confsToCancel = Data.currentConfId /Data.CONF_CANCEL;
        Data.confRessToCancel = Data.currentResID / Data.CONF_RES_CANCEL;
        Data.worksToCancel = Data.currentWorkshopID /Data.WORK_CANCEL;
        Data.workRessToCancel = Data.workResId / Data.WORK_RES_CANCEL;
    }
    
    private static void cancelConfs(BufferedWriter writer) throws IOException {
        
        writer.newLine();
        writer.write("--CONFERENCES:");
        writer.newLine();
        
        for(int i = 0; i < Data.confsToCancel; i++) {
            Data.mainBuilder.delete(0, Data.mainBuilder.length());
            Data.mainBuilder.append("EXEC Anuluj_konferencja ");
            Data.mainBuilder.append(Data.r.nextInt(Data.currentConfId));
            Data.mainBuilder.append(";");
            writer.write(Data.mainBuilder.toString());
            writer.newLine();
        }
        
        writer.newLine();
    }

    private static void cancelConfRess(BufferedWriter writer) throws IOException {

        writer.newLine();
        writer.write("--CONFERENCE RESERVATIONS:");
        writer.newLine();

        for(int i = 0; i < Data.confRessToCancel; i++) {
            Data.mainBuilder.delete(0, Data.mainBuilder.length());
            Data.mainBuilder.append("EXEC Anuluj_rezerwacja_konf ");
            Data.mainBuilder.append(Data.r.nextInt(Data.currentResID));
            Data.mainBuilder.append(";");
            writer.write(Data.mainBuilder.toString());
            writer.newLine();
        }

        writer.newLine();
    }

    private static void cancelWorks(BufferedWriter writer) throws IOException {

        writer.newLine();
        writer.write("--WORKSHOPS:");
        writer.newLine();

        for(int i = 0; i < Data.worksToCancel; i++) {
            Data.mainBuilder.delete(0, Data.mainBuilder.length());
            Data.mainBuilder.append("EXEC Anuluj_warsztat ");
            Data.mainBuilder.append(Data.r.nextInt(Data.currentWorkshopID));
            Data.mainBuilder.append(";");
            writer.write(Data.mainBuilder.toString());
            writer.newLine();
        }

        writer.newLine();
    }

    private static void cancelWorkRess(BufferedWriter writer) throws IOException {

        writer.newLine();
        writer.write("--WORKSHOP RESERVATIONS:");
        writer.newLine();

        for(int i = 0; i < Data.workRessToCancel; i++) {
            Data.mainBuilder.delete(0, Data.mainBuilder.length());
            Data.mainBuilder.append("EXEC Anuluj_rezerwacja_warsztat ");
            Data.mainBuilder.append(Data.r.nextInt(Data.workResId));
            Data.mainBuilder.append(";");
            writer.write(Data.mainBuilder.toString());
            writer.newLine();
        }

        writer.newLine();
    }
}
