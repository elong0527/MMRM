%macro import_csv(data,file);
PROC IMPORT OUT= &data 
            DATAFILE= "&file"
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
%mend import_csv;

%import_csv(tmp, &path\db_chg_missing_long.csv);

proc mixed data=tmp ;
   class trt time id;
   model value= time basval*time trt*time / cl;
   repeated time/type=un subject=id;
   lsmeans time trt*time/cl pdiff;
run;
