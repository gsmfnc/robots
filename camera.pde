float angoloY = 0;
float angoloX = 0;
float angoloYpartenza = 0;
float angoloXpartenza = 0;

void mousePressed()
{
    angoloYpartenza = angoloY + 3.14 * mouseX / float(500);
    angoloXpartenza = angoloX + 3.14 * mouseY / float(500);
}

void mouseDragged()
{
    angoloY = angoloYpartenza - 3.14 * mouseX / float(500);
    angoloX = angoloXpartenza - 3.14 * mouseY / float(500);
}
