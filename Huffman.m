%Codificacion de Huffman

clc;
clear all;
%s=input('Ingrese los simbolos: ') 
s=['A','B','C','D','E'];
%p=input('Ingrese las probabilidades: ')  
p = [1/2, 1/4, 1/8, 1/16, 1/16];

probini = p;  %probabilidades iniciales

S = sum(p); %Debe dar 100% 

 if S ~= 1
  S
  error('Las probabilidades deben sumar 100%') 
 end   

if length(s)~=length(p)
   error('La cantidad de simbolos no corresponde a la cantidad de probabilidades ') 
end   
i=1;
for m=1:length(p) %Ordena
   for n=1:length(p)
       if(p(m)>p(n))
         a=p(n);  a1=s(n);
         p(n)=p(m);s(n)=s(m);  
         p(m)=a;   s(m)=a1;
       end
   end
end

%Hacia adelante
display('Probabilidades ordenadas')
display(p)
sumarray=[];
w=length(p);
lengthp=[w];
b(i,:)=p; %Matriz que contiene la escalera 

while(length(p)>2) % (reduccion)
 tempsum=p(length(p))+p(length(p)-1); 
 sumarray=[sumarray,tempsum]; %sum en arrray
 p=[p(1:length(p)-2),tempsum];%Reemplaza los dos ultimos con +
 p=sort(p,'descend'); 
 i=i+1; %escalon
 b(i,:)=[p,zeros(1,w-length(p))]; %resto de 0's
 w1=0;
 lengthp=[lengthp,length(p)];
 display(p);
end

 %Etapa hacia atras
 sizeb(1:2)=size(b); %Guarda el tamaño de la matriz x=filas=5 y=columnas=6
 b;
 porigin=[];
 
 for i= 1:sizeb(2) 
  porigin=[porigin,b(1,i)] ;%vuelve al p de origen
 end 
 sumarray=[0,sumarray];
 e=1; L=0;
 for counter= 1:sizeb(2) 
 code=[s(counter),'->']; %Se toma el caracter para ser concatenado con su valor binario
    for i=1:sizeb(1) % x 
      tempdisplay=0; 
        
      for j=1:sizeb(2)  % y 
        if( b(i,j)==porigin(e))  %busca el valor de la probabilidad de toda la matriz y lo compara con su prob original
          tempdisplay=b(i,j); 
        end
        if(tempdisplay==0 && b(i,j)==sumarray(i)) %Este valor es compuesto
          tempdisplay=b(i,j);
        end
      end
      %Se asignan los 1 y 0
      if tempdisplay==b(i,lengthp(i))  %Si el valor es el mínimo se coloca un 1  (primera probabilidad)   
          code=[code,'1'];
      elseif tempdisplay==b(i,lengthp(i)-1) %Si no, es porque es el valor anterior, se coloca un 0 (Segunda prob)
          code=[code,'0'];
      end      
      porigin(e)=tempdisplay;
    end 
 if(code(end)=='0' && code(end-1)=='1') %limpia codigo
        code = code((1:end-1));
 end
 L = L+((length(code)-3)*probini(e)); %cantidad de bits por prob
 display(code); %Palabra codificada
 e=e+1;
end
%Eficiencia
H=0;
for cont=1:length(probini) %Calculo entropía
  H = H - (probini(cont) *log2(probini(cont)));
end
display('------|-----|------|------')
display(H)
display(L)
Eficiencia = H/L

