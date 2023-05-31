/*
 *  This sketch defines a GUI using G4P library:
 *      -   Droplist to select the robot type
 *      -   Droplist to select forward or inverse kinematics 
 *      -   Textfields to insert forward/inverse kinematics values
 *      -   Button to apply forward or inverse kinematics
*/

int w = 1000;
int h = 700;

//every widget's placed related to these coordinates
int textfieldx = w / 2;
int textfieldy = h - 30;

//labels text
String firstParameterTxt[] = {"q1REF", "x"};
String secondParameterTxt[] = {"q2REF", "y"};
String thirdParameterTxt[] = {"q3REF", "z"};

public void firstParameterTF_change1(GTextField source, GEvent event)
{

}

public void secondParameterTF_change1(GTextField source, GEvent event)
{

}

public void thirdParameterTF_change1(GTextField source, GEvent event)
{

}

public void modeDP_click1(GDropList source, GEvent event)
/*
 *  Modifies variablesIndex: this variable is used in inputs.pde to
 *  determine if given parameters are related to forward or inverse kinematics.
 *  It also changes labels text to x, y, z if inverse kinematics, or q1REF,
 *  q2REF, q3REF if forward kinematics.
*/
{
    if (modeDP.getSelectedText().equals("Cinematica Diretta"))
        variablesIndex = 0;
    if (modeDP.getSelectedText().equals("Cinematica Inversa"))
        variablesIndex = 1;

    firstParameterLbl.setText(firstParameterTxt[variablesIndex]);
    secondParameterLbl.setText(secondParameterTxt[variablesIndex]);
    thirdParameterLbl.setText(thirdParameterTxt[variablesIndex]);
}

public void confirmBtn_click1(GButton source, GEvent event)
/*
 *  Calls analyzeInput(): this function is defined in inputs.pde. It parses
 *  input and then applies forward or inverse kinematics.
*/
{
    analyzeInput();
}

public void robotsDP_click1(GDropList source, GEvent event)
/*
 *  Changes robotNo: this variable is used in robots.pde to determine what D-H's
 *  table draw. Sets q1, q2 and q3 to a specific rest position.
*/
{
    if (robotsDP.getSelectedText().equals("Cilindrico"))
        robotNo = CILINDRICO;
    if (robotsDP.getSelectedText().equals("Cartesiano"))
        robotNo = CARTESIANO;
    if (robotsDP.getSelectedText().equals("SCARA"))
        robotNo = SCARA;
    if (robotsDP.getSelectedText().equals("Sferico"))
        robotNo = SFERICO;
    if (robotsDP.getSelectedText().equals("Sferico Stanford"))
        robotNo = SFERICO_STANFORD;
    if (robotsDP.getSelectedText().equals("Antropomorfo"))
        robotNo = ANTROPOMORFO;
    if (robotsDP.getSelectedText().equals("Polso sferico"))
        robotNo = POLSO_SFERICO;

    setRestPosition();
}

public void createGUI()
{
    G4P.messagesEnabled(false);
    G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
    G4P.setCursor(ARROW);

    firstParameterTF = new GTextField(this, textfieldx, textfieldy,
            50, 20, G4P.SCROLLBARS_NONE);
    firstParameterTF.setOpaque(true);
    firstParameterTF.addEventHandler(this, "firstParameterTF_change1");

    firstParameterLbl = new GLabel(this, textfieldx, textfieldy - 20,
        80, 20);
    firstParameterLbl.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
    firstParameterLbl.setText(firstParameterTxt[variablesIndex]);
    firstParameterLbl.setOpaque(false);

    secondParameterTF = new GTextField(this, textfieldx + 55, textfieldy,
            50, 20, G4P.SCROLLBARS_NONE);
    secondParameterTF.setOpaque(true);
    secondParameterTF.addEventHandler(this, "secondParameterTF_change1");

    secondParameterLbl = new GLabel(this, textfieldx + 55, textfieldy - 20,
        80, 20);
    secondParameterLbl.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
    secondParameterLbl.setText(secondParameterTxt[variablesIndex]);
    secondParameterLbl.setOpaque(false);

    thirdParameterTF = new GTextField(this, textfieldx + 110, textfieldy,
            50, 20, G4P.SCROLLBARS_NONE);
    thirdParameterTF.setOpaque(true);
    thirdParameterTF.addEventHandler(this, "thirdParameterTF_change1");

    thirdParameterLbl = new GLabel(this, textfieldx + 110, textfieldy - 20,
        80, 20);
    thirdParameterLbl.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
    thirdParameterLbl.setText(thirdParameterTxt[variablesIndex]);
    thirdParameterLbl.setOpaque(false);

    modeDP = new GDropList(this, textfieldx, textfieldy - 45, 130, 50, 2);
    modeDP.setItems(loadStrings("modeDPList"), 0);
    modeDP.addEventHandler(this, "modeDP_click1");

    confirmBtn = new GButton(this, textfieldx + 165, textfieldy - 6.5, 80, 30);
    confirmBtn.setText("Set");
    confirmBtn.addEventHandler(this, "confirmBtn_click1");

    robotsDP = new GDropList(this, 10, 10, 130, 150, 6);
    robotsDP.setItems(loadStrings("robotsDPList"), 0);
    robotsDP.addEventHandler(this, "robotsDP_click1");

    qxLbl = new GLabel(this, 0, height - table_height, table_width/4,
            table_height/2);
    qxLbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    qxLbl.setText("qX");
    qxLbl.setOpaque(false);

    qxREFLbl = new GLabel(this, 0, height - table_height/2, table_width/4,
            table_height/2);
    qxREFLbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    qxREFLbl.setText("qXREF");
    qxREFLbl.setOpaque(true);

    q1Lbl = new GLabel(this, table_width/4, height - table_height,
            table_width/4, table_height/2);
    q1Lbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    q1Lbl.setText("");
    q1Lbl.setOpaque(true);

    q1REFLbl = new GLabel(this, table_width/4, height - table_height/2,
            table_width/4, table_height/2);
    q1REFLbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    q1REFLbl.setText("");
    q1REFLbl.setOpaque(false);

    q2Lbl = new GLabel(this, table_width/2, height - table_height,
            table_width/4, table_height/2);
    q2Lbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    q2Lbl.setText("");
    q2Lbl.setOpaque(false);
    q2REFLbl = new GLabel(this, table_width/2, height - table_height/2,
            table_width/4, table_height/2);
    q2REFLbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    q2REFLbl.setText("");
    q2REFLbl.setOpaque(true);

    q3Lbl = new GLabel(this, 3*table_width/4, height - table_height,
            table_width/4, table_height/2);
    q3Lbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    q3Lbl.setText("");
    q3Lbl.setOpaque(true);
    q3REFLbl = new GLabel(this, 3*table_width/4, height - table_height/2,
            table_width/4, table_height/2);
    q3REFLbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    q3REFLbl.setText("");
    q3REFLbl.setOpaque(false);
}

GTextField firstParameterTF;
GTextField secondParameterTF;
GTextField thirdParameterTF;

GDropList modeDP;
GDropList robotsDP;

GButton confirmBtn;

GLabel firstParameterLbl;
GLabel secondParameterLbl;
GLabel thirdParameterLbl;

GLabel qxLbl;
GLabel qxREFLbl;
GLabel q1Lbl;
GLabel q1REFLbl;
GLabel q2Lbl;
GLabel q2REFLbl;
GLabel q3Lbl;
GLabel q3REFLbl;
