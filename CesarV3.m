clc
clear all
texto=input('INGRESAR EL TEXTO: ','s');
encript=input('DESEA ENCRIPTAR (1) O DESENCRIPTAR (0): ');
clave=input('INGRESA LA CLAVE: ');


if encript==0
    encript = -1;  
end

x=double(texto);

for i=1:length(x)
    y(i)=x(i)+clave*encript;
end

cesar=char(y);
fprintf('Código ');
display(cesar);

k=1;
entropia = 0;
for i=32:225 %codigo ASCII
    dat=char(i); %convierte el codigo ASCII en caracter
    total=length(strfind(texto,dat));
    prob(k)=total/length(texto);
    if (total~=0)
        caracteres(k)=total;
        fprintf('Caracter:\t%c se repitió:\t%d veces ',dat,total);
        fprintf('con probabilidad\t%f',prob(k));
        fprintf('\tInformación propia\t%f\n',-log2(prob(k))');
        entropia = entropia + prob(k)*log2(prob(k));
        k=k+1;
    end
end

fprintf('\nEntropía del texto es: \t%f bits por simbolo \n',-entropia);
sym=1:length(prob)-1;   
p=prob(1:length(sym)); %Probabilidad de cada caracter