Table function1 is created successfully
table test.function1
(
  key:
    id_num char(32),
    random1 double(30,28),
    random2 double(30,28),
    random3 double(30,28),
    random4 double(30,28),
    random5 double(30,28),
  value:
    spare_ char(57)
);

test.function1 contains 10000 rows
sum(random1):[501299.554972] 
sum_random1:[501299.554972] 
avg(random1):[50.129947] 
min(random1):[0.005230] 
max(random1):[99.981040] 
count(random1):[10000.000000] 
stddev(random1):[29.010637] 
first(random1):[8904908050580959200.000000] 
last(random1):[1602531316693833500.000000] 
abs(random1):[89.490805] 
abs(random1):[25.568762] 
abs(random1):[0.881132] 
acos(random1):[-1.000000] 
acos(random1):[-1.000000] 
acos(random1):[0.492546] 
substring(random1,1 ,3 ):[89.000000] 
substring(random1,1 ,3 ):[25.000000] 
substring(random1,1 ,3 ):[0.000000] 
date(random1 ):[8.000000] 
date(random1 ):[87.000000] 
date(random1 ):[11.000000] 
cos(random1):[0.044571] sin(random2):[0.901479] 
cos(random1):[0.906440] sin(random2):[-0.997798] 
cos(random1):[0.636278] sin(random2):[0.565867] 
ceil(random1):[90.000000] 
ceil(random1):[26.000000] 
ceil(random1):[1.000000] 
cos(random1):[0.044571] 
cos(random1):[0.906440] 
cos(random1):[0.636278] 
floor(random1):[89.000000] 
floor(random1):[25.000000] 
floor(random1):[0.000000] 
log(random1):[4.494136] 
log(random1):[3.241371] 
log(random1):[-0.126548] 
log2(random1):[6.483668] 
log2(random1):[4.676310] 
log2(random1):[-0.182570] 
log10(random1):[1.951778] 
log10(random1):[1.407710] 
log10(random1):[-0.054959] 
ln(random1):[4.494136] 
ln(random1):[3.241371] 
ln(random1):[-0.126548] 
mod(random1, random2):[0.403035] 
mod(random1, random2):[25.568762] 
mod(random1, random2):[0.881132] 
radians(random1):[1.561909] 
radians(random1):[0.446259] 
radians(random1):[0.015379] 
degrees(random1):[5127.445435] 
degrees(random1):[1464.982130] 
degrees(random1):[50.485136] 
sin(random2):[0.901479] 
sin(random2):[-0.997798] 
sin(random2):[0.565867] 
sqrt(random1):[9.459958] 
sqrt(random1):[5.056556] 
sqrt(random1):[0.938686] 
tan(random1):[22.413918] 
tan(random1):[0.465928] 
tan(random1):[1.212456] 
substr(random1, 2, 4):[89.400000] 
substr(random1, 2, 4):[25.500000] 
substr(random1, 2, 4):[0.800000] 
substring(random1, 2, 4):[89.400000] 
substring(random1, 2, 4):[25.500000] 
substring(random1, 2, 4):[0.800000] 
upper(id_num):[ID1] 
upper(id_num):[ID10] 
upper(id_num):[ID100] 
lower(id_num):[id1] 
lower(id_num):[id10] 
lower(id_num):[id100] 
ltrim(id_num):[ID1] 
ltrim(id_num):[ID10] 
ltrim(id_num):[ID100] 
rtrim(id_num):[ID1] 
rtrim(id_num):[ID10] 
rtrim(id_num):[ID100] 
trim(id_num):[ID1] 
trim(id_num):[ID10] 
trim(id_num):[ID100] 
length(random5):[9.000000] 
length(random5):[9.000000] 
length(random5):[9.000000] 
length(id_num):[32.000000] 
length(id_num):[32.000000] 
length(id_num):[32.000000] 
Table function1_pow is created successfully
table test.function1_pow
(
  key:
    id_num char(32),
    random1 double(30,28),
    random2 double(30,28),
    random3 double(30,28),
  value:
    spare_ char(38)
);

id_num:[ID67] random1:[2.000000] random2:[4.000000] random3:[16.000000] 
pow(random1, random2):[16.000000] 
pow(random1, random3):[65536.000000] 
