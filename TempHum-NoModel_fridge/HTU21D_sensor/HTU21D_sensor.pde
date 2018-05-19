import processing.serial.*;
Serial mySerial;
int t=0;
int DATASIZE = 5;
int counter = 0;
PrintWriter output,output2;
float tempdata[] = new float[DATASIZE];
float humdata[] = new float[DATASIZE];

void setup() {
   mySerial = new Serial( this, Serial.list()[0], 9600 );
  // output = createWriter( "../temp.txt" );
   //output2 = createWriter("../hum.txt");
}
void draw() {
    if (mySerial.available() > 0 ) { //<>//
         String value = mySerial.readString();
         if ( value != null ) {
             if(t==0){
               if(value.charAt(0)=='1')
                 t=1;
               else if(value.charAt(0)=='2')
                 t=2;
             }

             else if(t!=0){
               if(t==1){
                 tempdata[counter] = Float.parseFloat(value);
                 t=0;
               }
               else if(t==2){
                 humdata[counter] = Float.parseFloat(value);
                 t=0;
                 counter++;

               }
             }
        }
    }
    
    if (counter == DATASIZE){
       output = createWriter( "../temp.txt" );
      output2 = createWriter("../hum.txt");
      
      for(int i = 0; i<DATASIZE; i++){
        output.print(tempdata[i]);
        output.println();
        output2.print(humdata[i]);
        output2.println();
      }
      
      output.flush();  // Writes the remaining data to the file
      output.close();  // Finishes the file
      output2.flush();  // Writes the remaining data to the file
      output2.close();
      counter = 0;
    
    }
   delay(500);
}

void keyPressed() {
    output.flush();  // Writes the remaining data to the file
    output.close();  // Finishes the file
    output2.flush();  // Writes the remaining data to the file
    output2.close();
    exit();  // Stops the program
}
