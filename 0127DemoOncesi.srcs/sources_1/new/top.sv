


module topTester(input clk, //100Mhz on Basys3


	input logic executeScene,
    input logic resetTimer,
    input logic resetSystem,
    output a, b, c, d, e, f, g, dp, 
                    output [3:0] an,
    output logic [2:0] floor, // 15-14-13
    output logic [3:0] floor1, // 12-11-10-9
    output logic [3:0] floor2, // 8-7-6-5
    output logic [3:0] floor3 // 3-2-1-0
    
    

    );
    
logic [2:0] state = 3'b000;
logic [2:0] nextstate = 3'b000;

logic smth = 1'b1;

logic [3:0] floor1passangers = 4'd7;
logic [3:0] floor2passangers = 4'd9;
logic [3:0] floor3passangers = 4'd11;
logic [3:0] elPassangers = 4'd0;



logic systemStarted = 1'b0;

logic specialCase1 = 1'b0;
logic specialCase2 = 1'b0;
logic specialCase3 = 1'b0;
logic specialCase4 = 1'b0;


logic firstActivated = 1'b0;



logic [3:0] key_value;
logic [28:0] counter = {29{1'b0}};

logic  openDoor = 1'b1;
logic passBy = 1'b0;

logic [0:1][5:0] floor1passanger = {6'b000000 , 6'b000000}; // the 6'b 6'b array converted from the 4bit floor data
logic [0:1][5:0] floor2passanger = {6'b000000 , 6'b000000};
logic [0:1][5:0] floor3passanger = {6'b000000 , 6'b000000};
logic [0:1][1:0] elevatorPassangerRed = {2'b00 , 2'b00};
logic [0:1][1:0] elevatorPassangerBlue = {2'b11 , 2'b11};

logic [2:0] col_num;
logic [0:7] [7:0]  image_green = 
    {8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000};
    
    logic [0:7] [7:0] image_red = 
    {8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000};
    
    logic [0:7] [7:0]  image_blue = 
    {8'b00000011, 8'b00000011, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000};
    

logic [26:0] counter7Seg = {27{1'b0}};
logic [26:0] moveCounter = {27{1'b0}};
logic [1:0] stayUpDown = 2'b00; // staying at the floor -> 0     going up -> 1         going down -> 2

logic [3:0] in0 = 4'd0; // 1
logic [3:0] in1 = 4'd0; // 10
logic [3:0] in2 = 4'd0; // 100
logic [3:0] in3 = 4'd10;
logic timeRestarted = 1'b0; 


logic systemRestarted = 1'b0;

 /*always_ff@(posedge clk)
    begin
     if(executeScene) 
       systemStarted <= 1'b1;      
          
             
    else if(resetTimer)
        timeRestarted <= 1;
    
    else          
        begin
        systemStarted <= systemStarted;
        timeRestarted <= 0;        
        end            
        
    end*/
     
    


always@(posedge clk)

       begin   
       
       if(executeScene)
        begin     
        systemStarted <= 1'b1;
        if(floor1passangers + floor2passangers + floor3passangers > 0)
            stayUpDown <= 2'd1;
        end
       else if(resetTimer)
          timeRestarted <= 1;

       else if(resetSystem)
          begin
        //  systemRestarted <= 1;
          floor1passanger <= {6'b000000 , 6'b000000}; // the 6'b 6'b array converted from the 4bit floor data
          floor2passanger <= {6'b000000 , 6'b000000};
          floor3passanger <= {6'b000000 , 6'b000000};
          elevatorPassangerRed <= {2'b00 , 2'b00};
          elevatorPassangerBlue <= {2'b11 , 2'b11};
          systemStarted <= 1'b0;
          
          floor1passangers <= 4'd0;
          floor2passangers <= 4'd0;
          floor3passangers <= 4'd0;
          elPassangers <= 4'd0;
          state <= 2'b00;
          counter <= {29{1'b0}};             
          openDoor <= 1'b1;
          passBy <= 1'b0;
          smth <= 1'b1;
           in0 <= 4'd0; // 1
           in1 <= 4'd0; // 10
           in2 <= 4'd0; // 100
           in3 <= 4'd10;
          timeRestarted <= 1'b1;
          
          end
          
       else          
          begin
          
        systemStarted <= systemStarted;          
        floor1passanger <= floor1passanger; // the 6'b 6'b array converted from the 4bit floor data
        floor2passanger <= floor2passanger;
        floor3passanger <= floor3passanger;
        elevatorPassangerRed <= elevatorPassangerRed;
        elevatorPassangerBlue <= elevatorPassangerBlue;
        smth <= smth;
        floor1passangers <= floor1passangers;
        floor2passangers <= floor2passangers;
        floor3passangers <= floor3passangers;
        elPassangers <= elPassangers;
        state <= state;
        counter <= counter;           
        openDoor <= openDoor;
        passBy <= passBy;
        stayUpDown <= stayUpDown;
    
        systemRestarted <= systemRestarted;
        timeRestarted <= timeRestarted;
        in0 <= in0; // 1
        in1 <= in1; // 10
        in2 <= in2; // 100
        in3 <= in3;
          end  
                      
                      
                      
                      
     /*  if(resetSystem)
            systemRestarted <= 1'b1;
       else
            systemRestarted <= 1'b0;*/
            
    /*   if(systemRestarted == 1'b1)
            begin
              floor1passanger <= {6'b000000 , 6'b000000}; // the 6'b 6'b array converted from the 4bit floor data
              floor2passanger <= {6'b000000 , 6'b000000};
              floor3passanger <= {6'b000000 , 6'b000000};
              elevatorPassangerRed <= {2'b00 , 2'b00};
              elevatorPassangerBlue <= {2'b11 , 2'b11};
              goingUp <= 1'b1;
              floor1passangers <= 4'd0;
              floor2passangers <= 4'd0;
              floor3passangers <= 4'd0;
              elPassangers <= 4'd0;
              state <= 2'b00;
              counter <= {29{1'b0}};             
              openDoor <= 1'b0;
              passBy <= 1'b0;
              specialCase1 <= 1'b0;
              specialCase2 <= 1'b0;
              specialCase3 <= 1'b0;
              specialCase4 <= 1'b0;
              systemRestarted <= 1'b0;
              timeres <= 1'b1;
            end*/
 
        
        case(floor1passangers)
        0:   floor1passanger <= {6'b000000 , 6'b000000};
        1:   floor1passanger <= {6'b100000 , 6'b000000};
        2:   floor1passanger <= {6'b100000 , 6'b100000};
        3:   floor1passanger <= {6'b110000 , 6'b100000};
        4:   floor1passanger <= {6'b110000 , 6'b110000};
        5:   floor1passanger <= {6'b111000 , 6'b110000};
        6:   floor1passanger <= {6'b111000 , 6'b111000};
        7:   floor1passanger <= {6'b111100 , 6'b111000};
        8:   floor1passanger <= {6'b111100 , 6'b111100};
        9:   floor1passanger <= {6'b111110 , 6'b111100};
        10:  floor1passanger <= {6'b111110 , 6'b111110};
        11:  floor1passanger <= {6'b111111 , 6'b111110};
        12:  floor1passanger <= {6'b111111 , 6'b111111};
        
        endcase
        
       case(floor2passangers)
        0:   floor2passanger <= {6'b000000 , 6'b000000};
        1:   floor2passanger <= {6'b100000 , 6'b000000};
        2:   floor2passanger <= {6'b100000 , 6'b100000};
        3:   floor2passanger <= {6'b110000 , 6'b100000};
        4:   floor2passanger <= {6'b110000 , 6'b110000};
        5:   floor2passanger <= {6'b111000 , 6'b110000};
        6:   floor2passanger <= {6'b111000 , 6'b111000};
        7:   floor2passanger <= {6'b111100 , 6'b111000};
        8:   floor2passanger <= {6'b111100 , 6'b111100};
        9:   floor2passanger <= {6'b111110 , 6'b111100};
        10:  floor2passanger <= {6'b111110 , 6'b111110};
        11:  floor2passanger <= {6'b111111 , 6'b111110};
        12:  floor2passanger <= {6'b111111 , 6'b111111};   
        
        endcase
        
        
        case(floor3passangers)
        0:   floor3passanger <= {6'b000000 , 6'b000000};
        1:   floor3passanger <= {6'b100000 , 6'b000000};
        2:   floor3passanger <= {6'b100000 , 6'b100000};
        3:   floor3passanger <= {6'b110000 , 6'b100000};
        4:   floor3passanger <= {6'b110000 , 6'b110000};
        5:   floor3passanger <= {6'b111000 , 6'b110000};
        6:   floor3passanger <= {6'b111000 , 6'b111000};
        7:   floor3passanger <= {6'b111100 , 6'b111000};
        8:   floor3passanger <= {6'b111100 , 6'b111100};
        9:   floor3passanger <= {6'b111110 , 6'b111100};
        10:  floor3passanger <= {6'b111110 , 6'b111110};
        11:  floor3passanger <= {6'b111111 , 6'b111110};
        12:  floor3passanger <= {6'b111111 , 6'b111111};
               
        endcase
        
        
        case(elPassangers)
        0:
        begin
        elevatorPassangerRed <= {2'b00 , 2'b00};
        elevatorPassangerBlue <= {2'b11 , 2'b11};
        end
            
         1:   
         begin
         elevatorPassangerRed <= {2'b10 , 2'b00};
         elevatorPassangerBlue <= {2'b01 , 2'b11};
         end
         
        2:
        begin 
        elevatorPassangerRed <= {2'b11 , 2'b00};
        elevatorPassangerBlue <= {2'b00 , 2'b11};
        end
        
        3:
         begin
         elevatorPassangerRed <= {2'b11 , 2'b10};
         elevatorPassangerBlue <= {2'b00 , 2'b01};
        end
        
        4:
        begin
        elevatorPassangerRed <= {2'b11 , 2'b11};
        elevatorPassangerBlue <= {2'b00 , 2'b00};
        end
      endcase
          
       
       
       
   
         
         
         
/*
if(~systemStarted)
    if(key_valid ==  1'b1)
           
            
            case(key_value)
            
            4'd1 : floor1passangers <= floor1passangers + 4'd1;
                  
                  
            4'd2 : floor2passangers <= floor2passangers + 4'd1;
                  
            4'd3 : floor3passangers <= floor3passangers + 4'd1;
                    
            4'd5 :
                  if(floor1passangers != 4'd0)                     
                     floor1passangers <= floor1passangers - 1;             
                   
                   else                     
                      floor1passangers <= 4'd0;
                      
          4'd6 : 
                    if(floor2passangers != 4'd0)
                           
                           floor2passangers <= floor2passangers - 1;
                           
                         else                           
                            floor2passangers <= 4'd0;
                           
           
           4'd7 : 
                    if(floor3passangers != 4'd0)
                           floor3passangers <= floor3passangers - 1;
                           
                          else                             
                             floor3passangers <= 4'd0;
                          
        
        endcase
*/
case(state)

3'b000 :
         floor <= {1'b0,1'b0, 1'b1};


3'b010 : floor <= {1'b0,1'b1, 1'b0};
        


3'd4 : floor <= {1'b1,1'b0 , 1'b0}; 

        

3'b110 :  floor <= {1'b1,1'b1, 1'b0};


        
 endcase


case(floor1passangers)
4'd0: floor1 <= {1'b0, 1'b0 , 1'b0 , 1'b0};

4'd1: floor1 <= {1'b0, 1'b0 , 1'b0 , 1'b1};

4'd2: floor1 <= {1'b0, 1'b0 , 1'b1 , 1'b0};

4'd3: floor1 <= {1'b0, 1'b0 , 1'b1 , 1'b1};

4'd4: floor1 <= {1'b0, 1'b1 , 1'b0 , 1'b0};

4'd5: floor1 <= {1'b0, 1'b1 , 1'b0 , 1'b1};

4'd6: floor1 <= {1'b0, 1'b1 , 1'b1 , 1'b0};

4'd7: floor1 <= {1'b0, 1'b1 , 1'b1 , 1'b1};

4'd8: floor1 <= {1'b1, 1'b0 , 1'b0 , 1'b0};

4'd9: floor1 <= {1'b1, 1'b0 , 1'b0 , 1'b1};

4'd10: floor1 <= {1'b1 ,  1'b1 , 1'b0 , 1'b0};

4'd11: floor1 <= {1'b1, 1'b0 , 1'b1 , 1'b1};

4'd12: floor1 <= {1'b1, 1'b1 , 1'b0 , 1'b0};
endcase


case(floor2passangers)
4'd0: floor2 <= {1'b0, 1'b0 , 1'b0 , 1'b0};

4'd1: floor2 <= {1'b0, 1'b0 , 1'b0 , 1'b1};

4'd2: floor2 <= {1'b0, 1'b0 , 1'b1 , 1'b0};

4'd3: floor2 <= {1'b0, 1'b0 , 1'b1 , 1'b1};

4'd4: floor2 <= {1'b0, 1'b1 , 1'b0 , 1'b0};

4'd5: floor2 <= {1'b0, 1'b1 , 1'b0 , 1'b1};

4'd6: floor2 <= {1'b0, 1'b1 , 1'b1 , 1'b0};

4'd7: floor2 <= {1'b0, 1'b1 , 1'b1 , 1'b1};

4'd8: floor2 <= {1'b1, 1'b0 , 1'b0 , 1'b0};

4'd9: floor2 <= {1'b1, 1'b0 , 1'b0 , 1'b1};

4'd10: floor2 <= {1'b1 ,  1'b1 , 1'b0 , 1'b0};

4'd11: floor2 <= {1'b1, 1'b0 , 1'b1 , 1'b1};

4'd12: floor2 <= {1'b1, 1'b1 , 1'b0 , 1'b0};
endcase


case(floor3passangers)
4'd0: floor3 <= {1'b0, 1'b0 , 1'b0 , 1'b0};

4'd1: floor3 <= {1'b0, 1'b0 , 1'b0 , 1'b1};

4'd2: floor3 <= {1'b0, 1'b0 , 1'b1 , 1'b0};

4'd3: floor3 <= {1'b0, 1'b0 , 1'b1 , 1'b1};

4'd4: floor3 <= {1'b0, 1'b1 , 1'b0 , 1'b0};

4'd5: floor3 <= {1'b0, 1'b1 , 1'b0 , 1'b1};

4'd6: floor3 <= {1'b0, 1'b1 , 1'b1 , 1'b0};

4'd7: floor3 <= {1'b0, 1'b1 , 1'b1 , 1'b1};

4'd8: floor3 <= {1'b1, 1'b0 , 1'b0 , 1'b0};

4'd9: floor3 <= {1'b1, 1'b0 , 1'b0 , 1'b1};

4'd10: floor3 <= {1'b1 ,  1'b1 , 1'b0 , 1'b0};

4'd11: floor3 <= {1'b1, 1'b0 , 1'b1 , 1'b1};

4'd12: floor3 <= {1'b1, 1'b1 , 1'b0 , 1'b0};
endcase
    
    
    
    if(systemStarted)
           
            if(openDoor && ~passBy)
               begin
               state <= nextstate;
               counter <= counter + 1;
               if(counter == 29'd299_999_999)
                begin
                openDoor <= 1'b0;
                passBy <= 1'b0;
                counter <= 29'd0;             
              
                           
                           if(state == 3'b000) // floor 0
                                                 begin
                                                
                                                if(elPassangers != 0)
                                                    begin
                                                    nextstate <= 3'b001;
                                                    stayUpDown <= 2'd0;
                                                    smth <= 1'b1;
                                                    openDoor <= 1'b0;
                                                    passBy <= 1'b0;
                                                    end    
                                                    
                                                else if(elPassangers == 0 && (floor1passangers > 0 || floor2passangers > 0 || floor3passangers > 0))
                                                    begin
                                                    nextstate <= 3'b010;
                                                    openDoor <= 1'b1; 
                                                    passBy <= 1'b0;
                                                    smth <= 1'b0;
                                                    stayUpDown <= 2'd1;                                   
                                                    end
                                                    
                                                 end      
                                                    
                                        // check            
                                            
                                            else if(state == 3'b001) // waiting 0
                                                
                                                begin
                                                elPassangers <= 0;
                                                nextstate <= 3'b000;
                                                openDoor <= 1'b1;
                                                passBy <= 1'b1;
                                                smth <= 1'b0;
                                                stayUpDown <= 2'd0;
                                                              
                                                end // wait 1
                                                 
                                                 
                                                 
                                            
                                            // check
                                            
                                            
                                            else if(state == 3'b010) // floor1 
                                                    begin
                                                    
                                                    if(elPassangers == 0 && (floor2passangers > 0 || floor3passangers > 0 ) )
                                                        begin
                                                        nextstate <= 3'b100; // floor 2
                                                        openDoor <= 1;
                                                        passBy <= 0;
                                                        smth <= 1'b0; 
                                                        stayUpDown <= 2'd1;
                                                        end
                                            
                                                   else if(elPassangers < 4 && floor2passangers == 0 && floor3passangers == 0  && floor1passangers > 0)
                                                        begin           
                                                        nextstate <= 3'b011; // waiting 2 , get passenger from floor1
                                                        smth <= 1'b1;
                                                        stayUpDown <= 2'd0;
                                                        end
                                                         
                                                   else if(elPassangers == 4 || (floor1passangers == 0 && floor2passangers == 0 && floor3passangers == 0))
                                                        begin
                                                        openDoor <= 1; // going back
                                                        nextstate <= 2'b000;
                                                        passBy <= 0;
                                                        smth <= 1'b0;
                                                        stayUpDown <= 2'd2;
                                                        end   
                                                    end
                                              
                                              // check
                                                    
                                             else if(state == 3'b011)
                                                 
                                                 begin
                                                 if(elPassangers == 0)
                                                    begin
                                                    
                                                    if(floor1passangers == 1)
                                                    begin
                                                    elPassangers <=  1;
                                                    floor1passangers <= 0;
                                                    end
                                                    else if(floor1passangers == 2)
                                                        begin
                                                        elPassangers <=  2;
                                                        floor1passangers <= 0;
                                                        end
                                                    else if(floor1passangers == 3)
                                                        begin
                                                        elPassangers <= 3;
                                                        floor1passangers <= 0;
                                                        end
                                                    else if(floor1passangers > 3)
                                                        begin
                                                        elPassangers <= 4;
                                                        floor1passangers <= floor1passangers - 4;
                                                    
                                                         end
                                                    end
                                                 
                                                else if(elPassangers == 1)
                                                            begin
                                                            
                                                            if(floor1passangers == 1)
                                                            begin
                                                            elPassangers <=  2;
                                                            floor1passangers <= 0;
                                                            end
                                                            else if(floor1passangers == 2)
                                                                begin
                                                                elPassangers <=  3;
                                                                floor1passangers <= 0;
                                                                end
                                                            else if(floor1passangers == 3)
                                                                begin
                                                                elPassangers <= 4;
                                                                floor1passangers <= 0;
                                                                end
                                                            else if(floor1passangers > 3)
                                                                begin
                                                                elPassangers <= 4;
                                                                floor1passangers <= floor1passangers - 3;
                                                            
                                                            end
                                                      end
                                                  else if(elPassangers == 2)
                                                            begin
                                                            
                                                            if(floor1passangers == 1)
                                                            begin
                                                            elPassangers <=  3;
                                                            floor1passangers <= 0;
                                                            end
                                                            else if(floor1passangers == 2)
                                                                begin
                                                                elPassangers <=  4;
                                                                floor1passangers <= 0;
                                                                end
                                                            else if(floor1passangers == 3)
                                                                begin
                                                                elPassangers <= 4;
                                                                floor1passangers <= 1;
                                                                end
                                                            else if(floor1passangers > 3)
                                                                begin
                                                                elPassangers <= 4;
                                                                floor1passangers <= floor1passangers - 2;
                                                            
                                                            end
                                                          end  
                                                      else if(elPassangers == 3)
                                                            begin
                                                            
                                                            if(floor1passangers == 1)
                                                            begin
                                                            elPassangers <=  4;
                                                            floor1passangers <= 0;
                                                            end
                                                            else if(floor1passangers == 2)
                                                                begin
                                                                elPassangers <=  4;
                                                                floor1passangers <= 1;
                                                                end
                                                            else if(floor1passangers == 3)
                                                                begin
                                                                elPassangers <= 4;
                                                                floor1passangers <= 2;
                                                                end
                                                            else if(floor1passangers > 3)
                                                                begin
                                                                elPassangers <= 4;
                                                                floor1passangers <= floor1passangers - 1;
                                                            
                                                                end
                                                            end
                                                    
                                                 nextstate <= 3'b010;
                                                 openDoor <= 1'b1;
                                                 passBy <= 1'b1; 
                                                 smth <= 1'b0;
                                                 stayUpDown <= 2'd0; 
                                                 
                                                 end // end of wait 1
                                                 
                                                // check
                                                 
                                             
                                             else if(state == 3'b100)
                                                begin
                                                if(elPassangers == 0 && ( floor3passangers > 0 ) )
                                                    begin
                                                    nextstate <= 3'b110;
                                                    openDoor <= 1;
                                                    passBy <= 0;
                                                    smth <= 1'b0;
                                                    stayUpDown <= 2'd1;
                                                    end
                                                
                                                else if(elPassangers != 4 && floor3passangers == 0 && floor2passangers > 0)
                                                    begin
                                                    nextstate <= 3'b101;
                                                    smth <= 1'b1;
                                                    stayUpDown <= 2'd0;
                                                    end
                                                
                                                else if(elPassangers == 4 || (floor3passangers == 0 && floor2passangers == 0) )
                                                    
                                                    
                                                        begin
                                                        nextstate <= 3'b010;
                                                        openDoor <= 1;
                                                        passBy <= 0;
                                                        smth <= 1'b0;
                                                        stayUpDown <= 2'd2;
                                                        end
                                                    
                                                
                                                  end  
                                                 
                                                // check 
                                              
                                             else if(state == 3'b101)
                                                
                                                begin
                                                  if(elPassangers == 0)
                                                     begin
                                                     
                                                     if(floor2passangers == 1)
                                                     begin
                                                     elPassangers <=  1;
                                                     floor2passangers <= 0;
                                                     end
                                                     else if(floor2passangers == 2)
                                                         begin
                                                         elPassangers <=  2;
                                                         floor2passangers <= 0;
                                                         end
                                                     else if(floor2passangers == 3)
                                                         begin
                                                         elPassangers <= 3;
                                                         floor2passangers <= 0;
                                                        end
                                                     else if(floor2passangers > 3)
                                                         begin
                                                         elPassangers <= 4;
                                                         floor2passangers <= floor2passangers - 4;
                                                     
                                                        end
                                                    end 
                                                  
                                                 else if(elPassangers == 1)
                                                             begin
                                                             
                                                             if(floor2passangers == 1)
                                                             begin
                                                             elPassangers <=  2;
                                                             floor2passangers <= 0;
                                                             end
                                                             else if(floor2passangers == 2)
                                                                 begin
                                                                 elPassangers <=  3;
                                                                 floor2passangers <= 0;
                                                                 end
                                                             else if(floor2passangers == 3)
                                                                 begin
                                                                 elPassangers <= 4;
                                                                 floor2passangers <= 0;
                                                                end
                                                             else if(floor2passangers > 3)
                                                                 begin
                                                                 elPassangers <= 4;
                                                                 floor2passangers <= floor2passangers - 3;
                                                             
                                                             end
                                                   end
                                                   else if(elPassangers == 2)
                                                             begin
                                                             
                                                             if(floor2passangers == 1)
                                                             begin
                                                             elPassangers <=  3;
                                                             floor2passangers <= 0;
                                                             end
                                                             else if(floor2passangers == 2)
                                                                 begin
                                                                 elPassangers <=  4;
                                                                 floor2passangers <= 0;
                                                                 end
                                                             else if(floor2passangers == 3)
                                                                 begin
                                                                 elPassangers <= 4;
                                                                 floor2passangers <= 1;
                                                                 end
                                                             else if(floor2passangers > 3)
                                                                 begin
                                                                 elPassangers <= 4;
                                                                 floor2passangers <= floor2passangers - 2;
                                                                 
                                                             end
                                                         end    
                                                       else if(elPassangers == 3)
                                                             begin
                                                             
                                                             if(floor2passangers == 1)
                                                             begin
                                                             elPassangers <=  4;
                                                             floor2passangers <= 0;
                                                             end
                                                             else if(floor2passangers == 2)
                                                                 begin
                                                                 elPassangers <=  4;
                                                                 floor2passangers <= 1;
                                                                 end
                                                             else if(floor2passangers == 3)
                                                                 begin
                                                                 elPassangers <= 4;
                                                                 floor2passangers <= 2;
                                                                    end
                                                             else if(floor2passangers > 3)
                                                                 begin
                                                                 elPassangers <= 4;
                                                                 floor2passangers <= floor2passangers - 1;
                                                             
                                                                 end
                                                            end
                                                     
                                                  nextstate <= 3'b100;
                                                  openDoor <= 1'b1;
                                                  passBy <= 1'b1;  
                                                  smth <= 1'b0;  
                                                   stayUpDown <= 2'd0;
                                                  
                                                  end // end of wait 1
                                                
                                               //check
                                               
                                               
                                               else if(state == 3'b110)
                                                    
                                                    begin
                                                    if(elPassangers == 0 && (floor3passangers > 0))
                                                        begin
                                                        nextstate <= 3'b111;
                                                        stayUpDown <= 2'd0;
                                                        smth <= 1'b1;
                                                        end
                                                    else if(elPassangers == 4 || floor3passangers == 0)
                                                        begin
                                                        nextstate <= 3'b100;
                                                        openDoor <= 1;
                                                        passBy <= 0;
                                                        smth <= 1'b0;
                                                        stayUpDown <= 2'd2;
                                                        end
                                                    
                                                    end 
                                              
                                              //check
                                              
                                              
                                               else if(state == 3'b111)
                                                     begin
                                                    if(elPassangers == 0)
                                                       begin
                                                       
                                                       if(floor3passangers == 1)
                                                       begin
                                                       elPassangers <=  1;
                                                       floor3passangers <= 0;
                                                       end
                                                       else if(floor3passangers == 2)
                                                           begin
                                                           elPassangers <=  2;
                                                           floor3passangers <= 0;
                                                           end
                                                       else if(floor3passangers == 3)
                                                           begin
                                                           elPassangers <= 3;
                                                           floor3passangers <= 0;
                                                            end
                                                       else if(floor3passangers > 3)
                                                           begin
                                                           elPassangers <= 4;
                                                           floor3passangers <= floor3passangers - 4;
                                                            end
                                                       end
                                                      
                                                    
                                                   else if(elPassangers == 1)
                                                               begin
                                                               
                                                               if(floor3passangers == 1)
                                                               begin
                                                               elPassangers <=  2;
                                                               floor3passangers <= 0;
                                                               end
                                                               else if(floor3passangers == 2)
                                                                   begin
                                                                   elPassangers <=  3;
                                                                   floor3passangers <= 0;
                                                                   end
                                                               else if(floor3passangers == 3)
                                                                   begin
                                                                   elPassangers <= 4;
                                                                   floor3passangers <= 0;
                                                                    end
                                                               else if(floor3passangers > 3)
                                                                   begin
                                                                   elPassangers <= 4;
                                                                   floor3passangers <= floor3passangers - 3;
                                                                    end
                                                               end
                                                   
                                                     else if(elPassangers == 2)
                                                               begin
                                                               
                                                               if(floor3passangers == 1)
                                                               begin
                                                               elPassangers <=  3;
                                                               floor3passangers <= 0;
                                                               end
                                                               else if(floor3passangers == 2)
                                                                   begin
                                                                   elPassangers <=  4;
                                                                   floor3passangers <= 0;
                                                                   end
                                                               else if(floor3passangers == 3)
                                                                   begin
                                                                   elPassangers <= 4;
                                                                   floor3passangers <= 1;
                                                                end
                                                               else if(floor3passangers > 3)
                                                                   begin
                                                                   elPassangers <= 4;
                                                                   floor3passangers <= floor3passangers - 2;
                                                               
                                                               end
                                                              end 
                                                         else if(elPassangers == 3)
                                                               begin
                                                               
                                                               if(floor3passangers == 1)
                                                               begin
                                                               elPassangers <=  4;
                                                               floor3passangers <= 0;
                                                               end
                                                               else if(floor3passangers == 2)
                                                                   begin
                                                                   elPassangers <=  4;
                                                                   floor3passangers <= 1;
                                                                   end
                                                               else if(floor3passangers == 3)
                                                                   begin
                                                                   elPassangers <= 4;
                                                                   floor3passangers <= 2;
                                                                end
                                                               else if(floor3passangers > 3)
                                                                   begin
                                                                   elPassangers <= 4;
                                                                   floor3passangers <= floor3passangers - 1;
                                                               
                                                                   end
                                                    end
                                                       
                                                    nextstate <= 3'b110;
                                                    openDoor <= 1'b1;
                                                    passBy <= 1'b1;    
                                                    smth <= 1'b0;
                                                    stayUpDown <= 2'd0; 
                                                    
                                                    end // end of wait 1                
                                            
                                       
                                end 
                                end
                               
                

        else if(openDoor && passBy)
        
        
        
        
             begin
                      state <= nextstate;
                      counter <= counter + 1;
                      if(counter == 29'd199_999_999)
                       begin
                       counter <= 29'd0;             
                       openDoor <= 1'b0;
                                                                     
                
                                    
                                    if(state == 3'b000) // floor 0
                                                        begin
                                                       
                                                       if(elPassangers != 0)
                                                           begin
                                                           nextstate <= 3'b001;
                                                           stayUpDown <= 2'd0;
                                                           smth <= 1'b1;
                                                           openDoor <= 1'b0;
                                                           passBy <= 1'b0;
                                                           end    
                                                           
                                                       else if(elPassangers == 0 && (floor1passangers > 0 || floor2passangers > 0 || floor3passangers > 0))
                                                           begin
                                                           nextstate <= 3'b010;
                                                           openDoor <= 1'b1; 
                                                           passBy <= 1'b0;
                                                           smth <= 1'b0;
                                                           stayUpDown <= 2'd1;                                   
                                                           end
                                                           
                                                        end      
                                                           
                                               // check            
                                                   
                                                   else if(state == 3'b001) // waiting 0
                                                       
                                                       begin
                                                       elPassangers <= 0;
                                                       nextstate <= 3'b000;
                                                       openDoor <= 1'b1;
                                                       passBy <= 1'b1;
                                                       smth <= 1'b0;
                                                       stayUpDown <= 2'd0;
                                                                 
                                                       end // wait 1
                                                        
                                                        
                                                        
                                                   
                                                   // check
                                                   
                                                   
                                                   else if(state == 3'b010) // floor1 
                                                           begin
                                                           
                                                           if(elPassangers == 0 && (floor2passangers > 0 || floor3passangers > 0 ) )
                                                               begin
                                                               nextstate <= 3'b100; // floor 2
                                                               openDoor <= 1;
                                                               passBy <= 0;
                                                               smth <= 1'b0; 
                                                               stayUpDown <= 2'd1;
                                                               end
                                                   
                                                          else if(elPassangers < 4 && floor2passangers == 0 && floor3passangers == 0  && floor1passangers > 0)
                                                               begin           
                                                               nextstate <= 3'b011; // waiting 2 , get passenger from floor1
                                                               smth <= 1'b1;
                                                               stayUpDown <= 2'd0;
                                                               end
                                                                
                                                          else if(elPassangers == 4 || (floor1passangers == 0 && floor2passangers == 0 && floor3passangers == 0))
                                                               begin
                                                               openDoor <= 1; // going back
                                                               nextstate <= 2'b000;
                                                               passBy <= 0;
                                                               smth <= 1'b0;
                                                               stayUpDown <= 2'd2;
                                                               end   
                                                           end
                                                     
                                                     // check
                                                           
                                                    else if(state == 3'b011)
                                                        
                                                        begin
                                                        if(elPassangers == 0)
                                                           begin
                                                           
                                                           if(floor1passangers == 1)
                                                           begin
                                                           elPassangers <=  1;
                                                           floor1passangers <= 0;
                                                           end
                                                           else if(floor1passangers == 2)
                                                               begin
                                                               elPassangers <=  2;
                                                               floor1passangers <= 0;
                                                               end
                                                           else if(floor1passangers == 3)
                                                               begin
                                                               elPassangers <= 3;
                                                               floor1passangers <= 0;
                                                               end
                                                           else if(floor1passangers > 3)
                                                               begin
                                                               elPassangers <= 4;
                                                               floor1passangers <= floor1passangers - 4;
                                                           
                                                                end
                                                           end
                                                        
                                                       else if(elPassangers == 1)
                                                                   begin
                                                                   
                                                                   if(floor1passangers == 1)
                                                                   begin
                                                                   elPassangers <=  2;
                                                                   floor1passangers <= 0;
                                                                   end
                                                                   else if(floor1passangers == 2)
                                                                       begin
                                                                       elPassangers <=  3;
                                                                       floor1passangers <= 0;
                                                                       end
                                                                   else if(floor1passangers == 3)
                                                                       begin
                                                                       elPassangers <= 4;
                                                                       floor1passangers <= 0;
                                                                       end
                                                                   else if(floor1passangers > 3)
                                                                       begin
                                                                       elPassangers <= 4;
                                                                       floor1passangers <= floor1passangers - 3;
                                                                   
                                                                   end
                                                             end
                                                         else if(elPassangers == 2)
                                                                   begin
                                                                   
                                                                   if(floor1passangers == 1)
                                                                   begin
                                                                   elPassangers <=  3;
                                                                   floor1passangers <= 0;
                                                                   end
                                                                   else if(floor1passangers == 2)
                                                                       begin
                                                                       elPassangers <=  4;
                                                                       floor1passangers <= 0;
                                                                       end
                                                                   else if(floor1passangers == 3)
                                                                       begin
                                                                       elPassangers <= 4;
                                                                       floor1passangers <= 1;
                                                                       end
                                                                   else if(floor1passangers > 3)
                                                                       begin
                                                                       elPassangers <= 4;
                                                                       floor1passangers <= floor1passangers - 2;
                                                                   
                                                                   end
                                                                 end  
                                                             else if(elPassangers == 3)
                                                                   begin
                                                                   
                                                                   if(floor1passangers == 1)
                                                                   begin
                                                                   elPassangers <=  4;
                                                                   floor1passangers <= 0;
                                                                   end
                                                                   else if(floor1passangers == 2)
                                                                       begin
                                                                       elPassangers <=  4;
                                                                       floor1passangers <= 1;
                                                                       end
                                                                   else if(floor1passangers == 3)
                                                                       begin
                                                                       elPassangers <= 4;
                                                                       floor1passangers <= 2;
                                                                       end
                                                                   else if(floor1passangers > 3)
                                                                       begin
                                                                       elPassangers <= 4;
                                                                       floor1passangers <= floor1passangers - 1;
                                                                   
                                                                       end
                                                                   end
                                                           
                                                        nextstate <= 3'b010;
                                                        openDoor <= 1'b1;
                                                        passBy <= 1'b1; 
                                                        smth <= 1'b0;
                                                        stayUpDown <= 2'd0; 
                                                        
                                                        end // end of wait 1
                                                        
                                                       // check
                                                        
                                                    
                                                    else if(state == 3'b100)
                                                       begin
                                                       if(elPassangers == 0 && ( floor3passangers > 0 ) )
                                                           begin
                                                           nextstate <= 3'b110;
                                                           openDoor <= 1;
                                                           passBy <= 0;
                                                           smth <= 1'b0;
                                                           stayUpDown <= 2'd1;
                                                           end
                                                       
                                                       else if(elPassangers != 4 && floor3passangers == 0 && floor2passangers > 0)
                                                           begin
                                                           nextstate <= 3'b101;
                                                           smth <= 1'b1;
                                                           stayUpDown <= 2'd0;
                                                           end
                                                       
                                                       else if(elPassangers == 4 || (floor3passangers == 0 && floor2passangers == 0) )
                                                           
                                                           
                                                               begin
                                                               nextstate <= 3'b010;
                                                               openDoor <= 1;
                                                               passBy <= 0;
                                                               smth <= 1'b0;
                                                               stayUpDown <= 2'd2;
                                                               end
                                                           
                                                       
                                                         end  
                                                        
                                                       // check 
                                                     
                                                    else if(state == 3'b101)
                                                       
                                                       begin
                                                         if(elPassangers == 0)
                                                            begin
                                                            
                                                            if(floor2passangers == 1)
                                                            begin
                                                            elPassangers <=  1;
                                                            floor2passangers <= 0;
                                                            end
                                                            else if(floor2passangers == 2)
                                                                begin
                                                                elPassangers <=  2;
                                                                floor2passangers <= 0;
                                                                end
                                                            else if(floor2passangers == 3)
                                                                begin
                                                                elPassangers <= 3;
                                                                floor2passangers <= 0;
                                                               end
                                                            else if(floor2passangers > 3)
                                                                begin
                                                                elPassangers <= 4;
                                                                floor2passangers <= floor2passangers - 4;
                                                            
                                                               end
                                                           end 
                                                         
                                                        else if(elPassangers == 1)
                                                                    begin
                                                                    
                                                                    if(floor2passangers == 1)
                                                                    begin
                                                                    elPassangers <=  2;
                                                                    floor2passangers <= 0;
                                                                    end
                                                                    else if(floor2passangers == 2)
                                                                        begin
                                                                        elPassangers <=  3;
                                                                        floor2passangers <= 0;
                                                                        end
                                                                    else if(floor2passangers == 3)
                                                                        begin
                                                                        elPassangers <= 4;
                                                                        floor2passangers <= 0;
                                                                       end
                                                                    else if(floor2passangers > 3)
                                                                        begin
                                                                        elPassangers <= 4;
                                                                        floor2passangers <= floor2passangers - 3;
                                                                    
                                                                    end
                                                          end
                                                          else if(elPassangers == 2)
                                                                    begin
                                                                    
                                                                    if(floor2passangers == 1)
                                                                    begin
                                                                    elPassangers <=  3;
                                                                    floor2passangers <= 0;
                                                                    end
                                                                    else if(floor2passangers == 2)
                                                                        begin
                                                                        elPassangers <=  4;
                                                                        floor2passangers <= 0;
                                                                        end
                                                                    else if(floor2passangers == 3)
                                                                        begin
                                                                        elPassangers <= 4;
                                                                        floor2passangers <= 1;
                                                                        end
                                                                    else if(floor2passangers > 3)
                                                                        begin
                                                                        elPassangers <= 4;
                                                                        floor2passangers <= floor2passangers - 2;
                                                                        
                                                                    end
                                                                end    
                                                              else if(elPassangers == 3)
                                                                    begin
                                                                    
                                                                    if(floor2passangers == 1)
                                                                    begin
                                                                    elPassangers <=  4;
                                                                    floor2passangers <= 0;
                                                                    end
                                                                    else if(floor2passangers == 2)
                                                                        begin
                                                                        elPassangers <=  4;
                                                                        floor2passangers <= 1;
                                                                        end
                                                                    else if(floor2passangers == 3)
                                                                        begin
                                                                        elPassangers <= 4;
                                                                        floor2passangers <= 2;
                                                                           end
                                                                    else if(floor2passangers > 3)
                                                                        begin
                                                                        elPassangers <= 4;
                                                                        floor2passangers <= floor2passangers - 1;
                                                                    
                                                                        end
                                                                   end
                                                            
                                                         nextstate <= 3'b100;
                                                         openDoor <= 1'b1;
                                                         passBy <= 1'b1;  
                                                         smth <= 1'b0;  
                                                         stayUpDown <= 2'd0;
                                                         
                                                         end // end of wait 1
                                                       
                                                      //check
                                                      
                                                      
                                                      else if(state == 3'b110)
                                                           
                                                           begin
                                                           if(elPassangers == 0 && (floor3passangers > 0))
                                                               begin
                                                               nextstate <= 3'b111;
                                                               stayUpDown <= 2'd0;
                                                               smth <= 1'b1;
                                                               end
                                                           else if(elPassangers == 4 || floor3passangers == 0)
                                                               begin
                                                               nextstate <= 3'b100;
                                                               openDoor <= 1;
                                                               passBy <= 0;
                                                               smth <= 1'b0;
                                                               stayUpDown <= 2'd2;
                                                               end
                                                           
                                                           end 
                                                     
                                                     //check
                                                     
                                                     
                                                      else if(state == 3'b111)
                                                            begin
                                                           if(elPassangers == 0)
                                                              begin
                                                              
                                                              if(floor3passangers == 1)
                                                              begin
                                                              elPassangers <=  1;
                                                              floor3passangers <= 0;
                                                              end
                                                              else if(floor3passangers == 2)
                                                                  begin
                                                                  elPassangers <=  2;
                                                                  floor3passangers <= 0;
                                                                  end
                                                              else if(floor3passangers == 3)
                                                                  begin
                                                                  elPassangers <= 3;
                                                                  floor3passangers <= 0;
                                                                   end
                                                              else if(floor3passangers > 3)
                                                                  begin
                                                                  elPassangers <= 4;
                                                                  floor3passangers <= floor3passangers - 4;
                                                                   end
                                                              end
                                                             
                                                           
                                                          else if(elPassangers == 1)
                                                                      begin
                                                                      
                                                                      if(floor3passangers == 1)
                                                                      begin
                                                                      elPassangers <=  2;
                                                                      floor3passangers <= 0;
                                                                      end
                                                                      else if(floor3passangers == 2)
                                                                          begin
                                                                          elPassangers <=  3;
                                                                          floor3passangers <= 0;
                                                                          end
                                                                      else if(floor3passangers == 3)
                                                                          begin
                                                                          elPassangers <= 4;
                                                                          floor3passangers <= 0;
                                                                           end
                                                                      else if(floor3passangers > 3)
                                                                          begin
                                                                          elPassangers <= 4;
                                                                          floor3passangers <= floor3passangers - 3;
                                                                           end
                                                                      end
                                                          
                                                            else if(elPassangers == 2)
                                                                      begin
                                                                      
                                                                      if(floor3passangers == 1)
                                                                      begin
                                                                      elPassangers <=  3;
                                                                      floor3passangers <= 0;
                                                                      end
                                                                      else if(floor3passangers == 2)
                                                                          begin
                                                                          elPassangers <=  4;
                                                                          floor3passangers <= 0;
                                                                          end
                                                                      else if(floor3passangers == 3)
                                                                          begin
                                                                          elPassangers <= 4;
                                                                          floor3passangers <= 1;
                                                                       end
                                                                      else if(floor3passangers > 3)
                                                                          begin
                                                                          elPassangers <= 4;
                                                                          floor3passangers <= floor3passangers - 2;
                                                                      
                                                                      end
                                                                     end 
                                                                else if(elPassangers == 3)
                                                                      begin
                                                                      
                                                                      if(floor3passangers == 1)
                                                                      begin
                                                                      elPassangers <=  4;
                                                                      floor3passangers <= 0;
                                                                      end
                                                                      else if(floor3passangers == 2)
                                                                          begin
                                                                          elPassangers <=  4;
                                                                          floor3passangers <= 1;
                                                                          end
                                                                      else if(floor3passangers == 3)
                                                                          begin
                                                                          elPassangers <= 4;
                                                                          floor3passangers <= 2;
                                                                       end
                                                                      else if(floor3passangers > 3)
                                                                          begin
                                                                          elPassangers <= 4;
                                                                          floor3passangers <= floor3passangers - 1;
                                                                      
                                                                          end
                                                           end
                                                              
                                                           nextstate <= 3'b110;
                                                           openDoor <= 1'b1;
                                                           passBy <= 1'b1;    
                                                           smth <= 1'b0;
                                                           stayUpDown <= 2'd0; 
                                                           
                                                           end // end of wait 1                
                                                   
                                              
                                       end 
                                       end
                                    
                                    
                                    
                                    
                                    
                else if(smth)
                    begin
                    smth <= 1'b0;
                    state <= nextstate;
                    
                     
                     
                     if(state == 3'b000) // floor 0
                                                     begin
                                                    
                                                    if(elPassangers != 0)
                                                        begin
                                                        nextstate <= 3'b001;
                                                        stayUpDown <= 2'd0;
                                                        smth <= 1'b1;
                                                        openDoor <= 1'b0;
                                                        passBy <= 1'b0;
                                                        end    
                                                        
                                                    else if(elPassangers == 0 && (floor1passangers > 0 || floor2passangers > 0 || floor3passangers > 0))
                                                        begin
                                                        nextstate <= 3'b010;
                                                        openDoor <= 1'b1; 
                                                        passBy <= 1'b0;
                                                        smth <= 1'b0;
                                                        stayUpDown <= 2'd1;                                   
                                                        end
                                                        
                                                     end      
                                                        
                                            // check            
                                                
                                                else if(state == 3'b001) // waiting 0
                                                    
                                                    begin
                                                    elPassangers <= 0;
                                                    nextstate <= 3'b000;
                                                    openDoor <= 1'b1;
                                                    passBy <= 1'b1;
                                                    smth <= 1'b0;
                                                    stayUpDown <= 2'd0;
                                                               
                                                    end // wait 1
                                                     
                                                     
                                                     
                                                
                                                // check
                                                
                                                
                                                else if(state == 3'b010) // floor1 
                                                        begin
                                                        
                                                        if(elPassangers == 0 && (floor2passangers > 0 || floor3passangers > 0 ) )
                                                            begin
                                                            nextstate <= 3'b100; // floor 2
                                                            openDoor <= 1;
                                                            passBy <= 0;
                                                            smth <= 1'b0; 
                                                            stayUpDown <= 2'd1;
                                                            end
                                                
                                                       else if(elPassangers < 4 && floor2passangers == 0 && floor3passangers == 0  && floor1passangers > 0)
                                                            begin           
                                                            nextstate <= 3'b011; // waiting 2 , get passenger from floor1
                                                            smth <= 1'b1;
                                                            stayUpDown <= 2'd0;
                                                            end
                                                             
                                                       else if(elPassangers == 4 || (floor1passangers == 0 && floor2passangers == 0 && floor3passangers == 0))
                                                            begin
                                                            openDoor <= 1; // going back
                                                            nextstate <= 2'b000;
                                                            passBy <= 0;
                                                            smth <= 1'b0;
                                                            stayUpDown <= 2'd2;
                                                            end   
                                                        end
                                                  
                                                  // check
                                                        
                                                 else if(state == 3'b011)
                                                     
                                                     begin
                                                     if(elPassangers == 0)
                                                        begin
                                                        
                                                        if(floor1passangers == 1)
                                                        begin
                                                        elPassangers <=  1;
                                                        floor1passangers <= 0;
                                                        end
                                                        else if(floor1passangers == 2)
                                                            begin
                                                            elPassangers <=  2;
                                                            floor1passangers <= 0;
                                                            end
                                                        else if(floor1passangers == 3)
                                                            begin
                                                            elPassangers <= 3;
                                                            floor1passangers <= 0;
                                                            end
                                                        else if(floor1passangers > 3)
                                                            begin
                                                            elPassangers <= 4;
                                                            floor1passangers <= floor1passangers - 4;
                                                        
                                                             end
                                                        end
                                                     
                                                    else if(elPassangers == 1)
                                                                begin
                                                                
                                                                if(floor1passangers == 1)
                                                                begin
                                                                elPassangers <=  2;
                                                                floor1passangers <= 0;
                                                                end
                                                                else if(floor1passangers == 2)
                                                                    begin
                                                                    elPassangers <=  3;
                                                                    floor1passangers <= 0;
                                                                    end
                                                                else if(floor1passangers == 3)
                                                                    begin
                                                                    elPassangers <= 4;
                                                                    floor1passangers <= 0;
                                                                    end
                                                                else if(floor1passangers > 3)
                                                                    begin
                                                                    elPassangers <= 4;
                                                                    floor1passangers <= floor1passangers - 3;
                                                                
                                                                end
                                                          end
                                                      else if(elPassangers == 2)
                                                                begin
                                                                
                                                                if(floor1passangers == 1)
                                                                begin
                                                                elPassangers <=  3;
                                                                floor1passangers <= 0;
                                                                end
                                                                else if(floor1passangers == 2)
                                                                    begin
                                                                    elPassangers <=  4;
                                                                    floor1passangers <= 0;
                                                                    end
                                                                else if(floor1passangers == 3)
                                                                    begin
                                                                    elPassangers <= 4;
                                                                    floor1passangers <= 1;
                                                                    end
                                                                else if(floor1passangers > 3)
                                                                    begin
                                                                    elPassangers <= 4;
                                                                    floor1passangers <= floor1passangers - 2;
                                                                
                                                                end
                                                              end  
                                                          else if(elPassangers == 3)
                                                                begin
                                                                
                                                                if(floor1passangers == 1)
                                                                begin
                                                                elPassangers <=  4;
                                                                floor1passangers <= 0;
                                                                end
                                                                else if(floor1passangers == 2)
                                                                    begin
                                                                    elPassangers <=  4;
                                                                    floor1passangers <= 1;
                                                                    end
                                                                else if(floor1passangers == 3)
                                                                    begin
                                                                    elPassangers <= 4;
                                                                    floor1passangers <= 2;
                                                                    end
                                                                else if(floor1passangers > 3)
                                                                    begin
                                                                    elPassangers <= 4;
                                                                    floor1passangers <= floor1passangers - 1;
                                                                
                                                                    end
                                                                end
                                                        
                                                     nextstate <= 3'b010;
                                                     openDoor <= 1'b1;
                                                     passBy <= 1'b1; 
                                                     smth <= 1'b0;
                                                     stayUpDown <= 2'd0; 
                                                     
                                                     end // end of wait 1
                                                     
                                                    // check
                                                     
                                                 
                                                 else if(state == 3'b100)
                                                    begin
                                                    if(elPassangers == 0 && ( floor3passangers > 0 ) )
                                                        begin
                                                        nextstate <= 3'b110;
                                                        openDoor <= 1;
                                                        passBy <= 0;
                                                        smth <= 1'b0;
                                                        stayUpDown <= 2'd1;
                                                        end
                                                    
                                                    else if(elPassangers != 4 && floor3passangers == 0 && floor2passangers > 0)
                                                        begin
                                                        nextstate <= 3'b101;
                                                        smth <= 1'b1;
                                                        stayUpDown <= 2'd0;
                                                        end
                                                    
                                                    else if(elPassangers == 4 || (floor3passangers == 0 && floor2passangers == 0) )
                                                        
                                                        
                                                            begin
                                                            nextstate <= 3'b010;
                                                            openDoor <= 1;
                                                            passBy <= 0;
                                                            smth <= 1'b0;
                                                            stayUpDown <= 2'd2;
                                                            end
                                                        
                                                    
                                                      end  
                                                     
                                                    // check 
                                                  
                                                 else if(state == 3'b101)
                                                    
                                                    begin
                                                      if(elPassangers == 0)
                                                         begin
                                                         
                                                         if(floor2passangers == 1)
                                                         begin
                                                         elPassangers <=  1;
                                                         floor2passangers <= 0;
                                                         end
                                                         else if(floor2passangers == 2)
                                                             begin
                                                             elPassangers <=  2;
                                                             floor2passangers <= 0;
                                                             end
                                                         else if(floor2passangers == 3)
                                                             begin
                                                             elPassangers <= 3;
                                                             floor2passangers <= 0;
                                                            end
                                                         else if(floor2passangers > 3)
                                                             begin
                                                             elPassangers <= 4;
                                                             floor2passangers <= floor2passangers - 4;
                                                         
                                                            end
                                                        end 
                                                      
                                                     else if(elPassangers == 1)
                                                                 begin
                                                                 
                                                                 if(floor2passangers == 1)
                                                                 begin
                                                                 elPassangers <=  2;
                                                                 floor2passangers <= 0;
                                                                 end
                                                                 else if(floor2passangers == 2)
                                                                     begin
                                                                     elPassangers <=  3;
                                                                     floor2passangers <= 0;
                                                                     end
                                                                 else if(floor2passangers == 3)
                                                                     begin
                                                                     elPassangers <= 4;
                                                                     floor2passangers <= 0;
                                                                    end
                                                                 else if(floor2passangers > 3)
                                                                     begin
                                                                     elPassangers <= 4;
                                                                     floor2passangers <= floor2passangers - 3;
                                                                 
                                                                 end
                                                       end
                                                       else if(elPassangers == 2)
                                                                 begin
                                                                 
                                                                 if(floor2passangers == 1)
                                                                 begin
                                                                 elPassangers <=  3;
                                                                 floor2passangers <= 0;
                                                                 end
                                                                 else if(floor2passangers == 2)
                                                                     begin
                                                                     elPassangers <=  4;
                                                                     floor2passangers <= 0;
                                                                     end
                                                                 else if(floor2passangers == 3)
                                                                     begin
                                                                     elPassangers <= 4;
                                                                     floor2passangers <= 1;
                                                                     end
                                                                 else if(floor2passangers > 3)
                                                                     begin
                                                                     elPassangers <= 4;
                                                                     floor2passangers <= floor2passangers - 2;
                                                                     
                                                                 end
                                                             end    
                                                           else if(elPassangers == 3)
                                                                 begin
                                                                 
                                                                 if(floor2passangers == 1)
                                                                 begin
                                                                 elPassangers <=  4;
                                                                 floor2passangers <= 0;
                                                                 end
                                                                 else if(floor2passangers == 2)
                                                                     begin
                                                                     elPassangers <=  4;
                                                                     floor2passangers <= 1;
                                                                     end
                                                                 else if(floor2passangers == 3)
                                                                     begin
                                                                     elPassangers <= 4;
                                                                     floor2passangers <= 2;
                                                                        end
                                                                 else if(floor2passangers > 3)
                                                                     begin
                                                                     elPassangers <= 4;
                                                                     floor2passangers <= floor2passangers - 1;
                                                                 
                                                                     end
                                                                end
                                                         
                                                      nextstate <= 3'b100;
                                                      openDoor <= 1'b1;
                                                      passBy <= 1'b1;  
                                                      smth <= 1'b0;  
                                                       stayUpDown <= 2'd0;
                                                      
                                                      end // end of wait 1
                                                    
                                                   //check
                                                   
                                                   
                                                   else if(state == 3'b110)
                                                        
                                                        begin
                                                        if(elPassangers == 0 && (floor3passangers > 0))
                                                            begin
                                                            nextstate <= 3'b111;
                                                            stayUpDown <= 2'd0;
                                                            smth <= 1'b1;
                                                            end
                                                        else if(elPassangers == 4 || floor3passangers == 0)
                                                            begin
                                                            nextstate <= 3'b100;
                                                            openDoor <= 1;
                                                            passBy <= 0;
                                                            smth <= 1'b0;
                                                            stayUpDown <= 2'd2;
                                                            end
                                                        
                                                        end 
                                                  
                                                  //check
                                                  
                                                  
                                                   else if(state == 3'b111)
                                                         begin
                                                        if(elPassangers == 0)
                                                           begin
                                                           
                                                           if(floor3passangers == 1)
                                                           begin
                                                           elPassangers <=  1;
                                                           floor3passangers <= 0;
                                                           end
                                                           else if(floor3passangers == 2)
                                                               begin
                                                               elPassangers <=  2;
                                                               floor3passangers <= 0;
                                                               end
                                                           else if(floor3passangers == 3)
                                                               begin
                                                               elPassangers <= 3;
                                                               floor3passangers <= 0;
                                                                end
                                                           else if(floor3passangers > 3)
                                                               begin
                                                               elPassangers <= 4;
                                                               floor3passangers <= floor3passangers - 4;
                                                                end
                                                           end
                                                          
                                                        
                                                       else if(elPassangers == 1)
                                                                   begin
                                                                   
                                                                   if(floor3passangers == 1)
                                                                   begin
                                                                   elPassangers <=  2;
                                                                   floor3passangers <= 0;
                                                                   end
                                                                   else if(floor3passangers == 2)
                                                                       begin
                                                                       elPassangers <=  3;
                                                                       floor3passangers <= 0;
                                                                       end
                                                                   else if(floor3passangers == 3)
                                                                       begin
                                                                       elPassangers <= 4;
                                                                       floor3passangers <= 0;
                                                                        end
                                                                   else if(floor3passangers > 3)
                                                                       begin
                                                                       elPassangers <= 4;
                                                                       floor3passangers <= floor3passangers - 3;
                                                                        end
                                                                   end
                                                       
                                                         else if(elPassangers == 2)
                                                                   begin
                                                                   
                                                                   if(floor3passangers == 1)
                                                                   begin
                                                                   elPassangers <=  3;
                                                                   floor3passangers <= 0;
                                                                   end
                                                                   else if(floor3passangers == 2)
                                                                       begin
                                                                       elPassangers <=  4;
                                                                       floor3passangers <= 0;
                                                                       end
                                                                   else if(floor3passangers == 3)
                                                                       begin
                                                                       elPassangers <= 4;
                                                                       floor3passangers <= 1;
                                                                    end
                                                                   else if(floor3passangers > 3)
                                                                       begin
                                                                       elPassangers <= 4;
                                                                       floor3passangers <= floor3passangers - 2;
                                                                   
                                                                   end
                                                                  end 
                                                             else if(elPassangers == 3)
                                                                   begin
                                                                   
                                                                   if(floor3passangers == 1)
                                                                   begin
                                                                   elPassangers <=  4;
                                                                   floor3passangers <= 0;
                                                                   end
                                                                   else if(floor3passangers == 2)
                                                                       begin
                                                                       elPassangers <=  4;
                                                                       floor3passangers <= 1;
                                                                       end
                                                                   else if(floor3passangers == 3)
                                                                       begin
                                                                       elPassangers <= 4;
                                                                       floor3passangers <= 2;
                                                                    end
                                                                   else if(floor3passangers > 3)
                                                                       begin
                                                                       elPassangers <= 4;
                                                                       floor3passangers <= floor3passangers - 1;
                                                                   
                                                                       end
                                                        end
                                                           
                                                        nextstate <= 3'b110;
                                                        openDoor <= 1'b1;
                                                        passBy <= 1'b1;    
                                                        smth <= 1'b0;
                                                        stayUpDown <= 2'd0; 
                                                        
                                                        end // end of wait 1                
                                                
                                           
                                    end 
                                    



counter7Seg <= counter7Seg + 1;                
  
  if(systemStarted)
   begin
  if(timeRestarted)
    begin
    // goingUp = something
    in0 <= 0;
    in1 <= 0;
    in2 <= 0;
    in3 <= 10;
    counter7Seg <= {27{1'b0}};
    moveCounter <= {27{1'b0}};
    stayUpDown <= 2'd0;
    timeRestarted <= 1'b0;
    
    
    end
    
  else if(floor1passangers + floor2passangers + floor3passangers > 0 || elPassangers > 0)
    begin
    moveCounter <= moveCounter + 1;
    
    if(moveCounter == 27'd24_999_999)
        begin
        moveCounter <= {27{1'b0}};
           if(stayUpDown == 2'd0)
                in3 <= in3;
           
           else if(stayUpDown == 2'd1)
                begin
                if(in3 == 4'd15)
                    in3 <= 4'd10;
                else
                    in3 <= in3 + 1;
                end
           else if(stayUpDown == 2'd2)
                begin
                if(in3 == 4'd10)
                    in3 <= 4'd15;
                else
                    in3 <= in3 - 1;
                end                          
        end  
        
          
    if( counter7Seg == 27'd99_999_999 )
        begin
        counter7Seg <= {27{1'b0}};
        
        if(in0 == 4'd9)
                        if(in1 == 4'd9)
                            if(in2 == 4'd9)
                                begin
                                in0 <= 4'd0;
                                in1 <= 4'd0;
                                in2 <= 4'd0;
                                end
                             else
                                begin
                                in2 <= in2 + 4'd1;
                                in1 <= 4'd0;
                                end
                         else
                            begin
                            in1 <= in1 + 1;
                            in0 <= 4'd0;
                            end
                   else
                        in0 <= in0 + 1;                                  
                    
                    
                    
                  
                  end // end else 
               end
        end



end // end of always@



   

 SevSeg_4digit SevSeg_4digit_inst0(
	.clk(clk),
	.in3(in3), .in2(in2), .in1(in1), .in0(in0), //user inputs for each digit (hexadecimal)
	.a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .dp(dp), // just connect them to FPGA pins (individual LEDs).
	.an(an)   // just connect them to FPGA pins (enable vector for 4 digits active low) 
); 

                        
                        
endmodule


