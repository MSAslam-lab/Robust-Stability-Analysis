
function [sys,x0,str,ts] =ffunction_mode31(t,x,u,flag,h,pai,state )
switch flag,
   case 0,
sizes=simsizes;
sizes.NumContStates=0;
sizes.NumDiscStates=0;
sizes.NumOutputs=1;
sizes.NumInputs=0;
sizes.DirFeedthrough=0;
sizes.NumSampleTimes=1;
sys=simsizes(sizes);
x0=[];str=[];ts=[0.01 0];
    case 3,
%pai=[-1.7 0.5 1.2;0.6 -0.8 0.2;0.1 0.5 -0.6] ;
%pai=0.9*[-1.7 0.5 1.2;0.6 -0.8 0.2;0.1 0.5 -0.6] ;
pai=[0 0 0;0 -1 1;0 1 -1] ;
Current_state=1; 
state(1)=1;
h=0.01; % step
timinal=10/h;
t(1)=1;
for i=1:1:(timinal-1) 
    Old_state=Current_state;
    if Old_state==1
        prob(1,1)=1+pai(1,1)*h;
         prob(1,2)=pai(1,2)*h;
         prob(1,3)=pai(1,3)*h;
    else 
        if Old_state==2              
        prob(2,2)=1+pai(2,2)*h;
         prob(2,1)=pai(2,1)*h;
        prob(2,3)=pai(2,3)*h;
        else  
        prob(3,3)=1+pai(3,3)*h;
         prob(3,1)=pai(3,1)*h;
         prob(3,2)=pai(3,2)*h;
        end 
    end
    rr=rand(1);
    if Old_state==1
        if rr<prob(1,1)
            Current_state=1;
            state(i+1)=1;
        else
            if prob(1,3)<prob(1,2)
            Current_state=2;
            state(i+1)=2;
            else
            Current_state=3;
            state(i+1)=3; 
            end
        end
    else
        if   Old_state==2     
                                 
             if rr<prob(2,2)
                Current_state=2;
                state(i+1)=2;
             else
                 if prob(2,3)<prob(2,1)
                  Current_state=1;
                  state(i+1)=1;
                 else
                    Current_state=3;
                     state(i+1)=3;   
                 end      
             end
        else
                     
             
               if rr<prob(3,3)
                  Current_state=3;
                  state(i+1)=3;
               else
                  if  prob(3,2)<prob(3,1)
                      Current_state=1;
                       state(i+1)=1;
                  else
                       Current_state=2;
                      state(i+1)=2;
                  end
               end
            end
        
    end
   
end
sys=state(i);
    case {1, 2, 4, 9}, sys=[];
    otherwise, error(['Unhandled flag= ',num2str(flag)]);

end