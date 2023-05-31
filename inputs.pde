/*
 *  Reads Textfields contents and according to variablesIndex value applies
 *  forward or inverse kinematics (see gui.pde)
*/

int variablesIndex = 0;

void analyzeInput()
{
    //reads Textfields contents as a String
    String firstParameterText = firstParameterTF.getText();
    String secondParameterText = secondParameterTF.getText();
    String thirdParameterText = thirdParameterTF.getText();

    float firstValue = q1REF;
    float secondValue = q2REF;
    float thirdValue = q3REF;

    try {
        //tries to convert to float
        firstValue = Float.parseFloat(firstParameterText);
        secondValue = Float.parseFloat(secondParameterText);
        thirdValue = Float.parseFloat(thirdParameterText);
    } catch(Exception e) {
        e.printStackTrace();
    }

    if (variablesIndex == 0) {
        //forward kinematics
        q1REF = firstValue * PI / 180;
        q2REF = secondValue * PI / 180;
        q3REF = thirdValue  * PI / 180;
    }
    if (variablesIndex == 1)
        //inverse kinematics (see inverse.pde)
        inverse();
}
