function sort_im(image, ita)

dest_dir = 'C:\Users\umaru\Documents\COOP1 - BC Cancer - RA\darkskin_ai_open_dataset';

if(ita >55)
    copyfile(image, strcat(dest_dir,'\very_lt'))
    disp(ita)
elseif(ita < 55 && ita > 41)
    copyfile(image, strcat(dest_dir,'\lt'))
    disp(ita)
elseif(ita < 41 && ita > 28)
    copyfile(image, strcat(dest_dir,'\int1'))
    disp(ita)
elseif(ita < 28 && ita > 10)
    copyfile(image, strcat(dest_dir,'\int2'))
    disp(ita)
elseif(ita < 10 && ita > -15)
    copyfile(image, strcat(dest_dir,'\tan1'))
    disp(ita)
elseif(ita < -15 && ita > -30)
    copyfile(image, strcat(dest_dir,'\tan2'))
    disp(ita)
elseif(ita < -30)
    copyfile(image, strcat(dest_dir,'\dark'))
    disp(ita)
else
    copyfile(image, strcat(dest_dir,'\nan'))
    disp(ita)
    
end

end