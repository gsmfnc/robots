/*
 *  This function writes texts into the screen.
*/
int table_width = 400;
int table_height = 70;

void write_text()
{
    int final_coordinates_x = 800;
    int final_coordinates_y = 600;

    textSize(15);
    fill(0, 0, 0);
    stroke(126);

    //drawing a table
    line(0,          height - table_height, 0,
         table_width, height - table_height, 0);
    line(0,          height - table_height / 2, 0,
         table_width, height - table_height / 2, 0);
    line(table_width / 4, height - table_height, 0,
         table_width / 4, height,               0);
    line(2 * table_width / 4, height - table_height, 0,
         2 * table_width / 4, height,               0);
    line(3 * table_width / 4, height - table_height, 0,
         3 * table_width / 4, height,               0);
    line(table_width, height - table_height, 0,
         table_width, height,               0);

    //filling table
    q1Lbl.setText(Double.toString(Math.floor(q1*180/PI*100)/100));
    q2Lbl.setText(Double.toString(Math.floor(q2*180/PI*100)/100));
    q3Lbl.setText(Double.toString(Math.floor(q3*180/PI*100)/100));
    q1REFLbl.setText(Double.toString(Math.floor(q1REF*180/PI*100)/100));
    q2REFLbl.setText(Double.toString(Math.floor(q2REF*180/PI*100)/100));
    q3REFLbl.setText(Double.toString(Math.floor(q3REF*180/PI*100)/100));

    //end-effector coordinates writing
    text("Coordinate pinza rispetto s.d.r. default:", final_coordinates_x,
        final_coordinates_y - 30);
    text("x = " + Math.floor(finalX * 100) / 100 +
       ", y = " + Math.floor(finalY * 100) / 100 +
       ", z = " + Math.floor(finalZ * 100)/ 100,
       final_coordinates_x, final_coordinates_y);
    text("Coordinate pinza rispetto base robot:", final_coordinates_x,
        final_coordinates_y + 30);
    text("x = " + Math.floor((finalX - 1.5 * width / 4)* 100) / 100 +
       ", y = " + -Math.floor((finalY - height / 2) * 100) / 100 +
       ", z = " + Math.floor((finalZ) * 100) / 100,
       final_coordinates_x, final_coordinates_y + 60);
}
