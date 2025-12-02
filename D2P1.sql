DECLARE 
  v_line      varchar2(400);
  file_handle utl_file.file_type;
  
  tmpHalf varchar2(40);
  minVal INT;
  maxVal INT;
  cantMatch INT;
  splitPossition INT;
  sumBad INT := 0;
  
  
BEGIN
  
      -- open file
      file_handle := utl_file.fopen('HUJER_DIR','test', 'r');
    
      loop
        begin
          utl_file.get_line(file_handle, v_line);
        exception
          when no_data_found then
            exit;
        end;
        
        splitPossition := instr(v_line, '-');
       
        maxVal := to_number(substr(v_line, splitPossition + 1));
        minVal := to_number(substr(v_line, 1, splitPossition-1));
        
        while minVal <= maxVal
          loop
              tmpHalf := substr(to_char(minVal), 1, ceil(length(minVal)/2));
              cantMatch := to_number(concat(tmpHalf, tmpHalf));
              
              if minVal = cantMatch then
                sumBad := sumBad + minVal;
              end if;
              
          
              minVal := minVal + 1;
          end loop;
        
      end loop;
      
      dbms_output.put_line(sumBad);
      utl_file.fclose(file_handle);
      
      
  
END;
  