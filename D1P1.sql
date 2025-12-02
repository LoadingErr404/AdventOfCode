DECLARE 
  dialPossition INT := 50;
  zeroCounter INT := 0;
  v_line      varchar2(10);
  file_handle utl_file.file_type;
  motion varchar2(1);
  motionValue INT;
  
BEGIN
  
-- open file
      file_handle := utl_file.fopen(dir, file, 'r');
    
      loop
        begin
          utl_file.get_line(file_handle, v_line);
        exception
          when no_data_found then
            exit;
        end;
      
        if trim(v_line) is not null then
          motion := substr(v_line, 1, 1);
          v_line := substr(v_line, 2);
        
          
          while LENGTH(v_line) > 2
            loop
              v_line := substr(v_line, 2);
            end loop;
          
          motionValue := to_number(replace(v_line, motion, ''));
          
          if upper(motion) = 'L' then
            if dialPossition - motionValue < 0 then 
              dialPossition := 100 - abs(dialPossition - motionValue);
             else
               dialPossition := dialPossition - motionValue;
             end if;
             
          else
            if upper(motion) = 'R' then 
               if dialPossition + motionValue > 99 then
                 dialPossition := abs(100 - (dialPossition + motionValue));
                 
               else
                 dialPossition := dialPossition + motionValue;
               end if;
            end if;
          end if;
          
          
          if dialPossition = 0 then
            zeroCounter := zeroCounter + 1;
          end if;
          
            --dbms_output.put_line(dialPossition);
            
        end if;
      end loop;
    
      utl_file.fclose(file_handle);
      
      dbms_output.put_line(concat('Pass: ',zeroCounter));
  
END;

  
