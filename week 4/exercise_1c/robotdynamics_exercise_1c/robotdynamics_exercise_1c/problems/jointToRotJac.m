function J_R = jointToRotJac(q)
  % Input: vector of generalized coordinates (joint angles)
  % Output: Jacobian of the end-effector orientation which maps joint
  % velocities to end-effector angular velocities in I frame.

%   Individual transformation matrices 
  T01 = jointToTransform01(q) ;
  T12 = jointToTransform12(q) ;
  T23 = jointToTransform23(q) ;
  T34 = jointToTransform34(q) ;
  T45 = jointToTransform45(q) ;
  T56 = jointToTransform56(q) ;
  
%   Total trnasformation matrices 
  T02 = T01*T12 ;
  T03 = T02*T23 ;
  T04 = T03*T34 ;
  T05 = T04*T45 ;
  T06 = T05*T56 ;
  
%   Rotation matrices
  C01 = T01(1:3,1:3) ;
  C02 = T02(1:3,1:3) ;
  C03 = T03(1:3,1:3) ;
  C04 = T04(1:3,1:3) ;
  C05 = T05(1:3,1:3) ;
  C06 = T06(1:3,1:3) ;

%   for transformation form 
  x = [1;0;0] ;
  y = [0;1;0] ;
  z = [0;0;1] ;
  
%   all the rotations axis in inertial frame 
  n1 = C01*z ; 
  n2 = C02*y ; 
  n3 = C03*y ; 
  n4 = C04*x ; 
  n5 = C05*y ; 
  n6 = C06*x ; 
  
  %Jacobian (rotation) solution
  J_R = [n1 n2 n3 n4 n5 n6] ;
end
