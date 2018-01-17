Table column_default is created successfully
table test.column_default
(
  key:
    emp_id int,
  value:
    first_name char(10),
    last_name char(10),
    zip_code char(5),
    age int DEFAULT '9',
    sex char(2) DEFAULT 'M',
    category bit DEFAULT b'1',
    uuid uuid,
    spare_ char(27)
);

emp_id:[101] first_name:[Jason] last_name:[Zhang] zip_code:[94588] age:[20] sex:[M] category:[1] uuid:[Fgh1AleJsNqQ5TqRJHXhbmBXHVU5696692057703] 
emp_id:[102] first_name:[Andrew] last_name:[Zhang] zip_code:[94588] age:[9] sex:[M] category:[1] uuid:[ROGLKVczQPDJ23PYTIjzFuFurqf5696692057703] 
emp_id:[103] first_name:[Sherry] last_name:[] zip_code:[94588] age:[9] sex:[F] category:[1] uuid:[Dkmob94XTY7qMW3vW4jSX1bwGG95696692057703] 
emp_id:[104] first_name:[Jerry] last_name:[] zip_code:[94588] age:[23] sex:[h] category:[0] uuid:[95xmJRH53QaYJ857SZalVfENaGX5696692057703] 
emp_id:[105] first_name:[Kevein] last_name:[] zip_code:[94588] age:[9] sex:[M] category:[0] uuid:[HkDOtGmOpdvvelDc2Jf9BchW5uz5696692057703] 
emp_id:[106] first_name:[Kevein] last_name:[] zip_code:[94588] age:[9] sex:[M] category:[0] uuid:[TFdOkxp8Z5uNtGgWSBz3BgiKRvZ5696692057703] 
emp_id:[107] first_name:[Kevein] last_name:[] zip_code:[94588] age:[9] sex:[M] category:[0] uuid:[Lyukr9xdt5CB2G4N9I35ACEDdUU5696692057703] 
emp_id:[108] first_name:[Kevein] last_name:[] zip_code:[94588] age:[9] sex:[M] category:[1] uuid:[VJnUuVoNlvkyYn9ynPCaYkd1UPD5696692057703] 
emp_id:[109] first_name:[Kevein] last_name:[] zip_code:[94588] age:[9] sex:[M] category:[1] uuid:[w0vqVeLOGGctZIMyE9HcxuOFs6T5696692057703] 
emp_id:[1011] first_name:[Mike] last_name:[] zip_code:[94588] age:[40] sex:[m1] category:[0] uuid:[VfqPUF6Vdp8WSTmIYd6PXNLeW7N5696692057703] 
emp_id:[1012] first_name:[Vinod] last_name:[] zip_code:[94588] age:[40] sex:[zz] category:[1] uuid:[tZG6vHBTANCotizVifHOTOt4jXQ5696692057703] 
