Table column_default2 is created successfully
table test.column_default2
(
  key:
    id uuid,
  value:
    a int DEFAULT '0',
    b char(16) DEFAULT 'b',
    bitv bit DEFAULT b'1',
    bitm bit DEFAULT b'0',
    tm1 timestamp DEFAULT CURRENT_TIMESTAMP,
    tm2 timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    tm3 timestamp ON UPDATE CURRENT_TIMESTAMP,
    spare_ char(36)
);

test.column_default2 contains 7 rows
id:[1] a:[0] b:[b] bitv:[1] bitm:[0] tm1:[2018-01-29 17:52:16.501124] tm2:[2018-01-29 17:52:16.501124] tm3:[1969-12-31 16:00:00.000000] 
id:[2] a:[1] b:[1] bitv:[1] bitm:[1] tm1:[1969-12-31 16:00:00.000001] tm2:[1969-12-31 16:00:00.000001] tm3:[1969-12-31 16:00:00.000001] 
id:[BsQwY6YHkidcDjoYAPNXRPmcarc5087110877136] a:[0] b:[b] bitv:[1] bitm:[0] tm1:[2018-01-29 17:52:16.500122] tm2:[2018-01-29 17:52:16.500122] tm3:[1969-12-31 16:00:00.000000] 
id:[FRaqbC8wSA1XvpFVjCRGryWtIIZ5087110877136] a:[0] b:[b] bitv:[1] bitm:[0] tm1:[2018-01-29 17:52:16.498223] tm2:[2018-01-29 17:52:16.498223] tm3:[1969-12-31 16:00:00.000000] 
id:[R4ZDgC81TbdkSmLAztxc1o8yfog5087110877136] a:[0] b:[b] bitv:[1] bitm:[0] tm1:[2018-01-29 17:52:16.501124] tm2:[2018-01-29 17:52:16.501124] tm3:[1969-12-31 16:00:00.000000] 
id:[S2TRqf69aZbLAX3cf3ednHM3SOl5087110877136] a:[0] b:[b] bitv:[1] bitm:[0] tm1:[2018-01-29 17:52:16.499121] tm2:[2018-01-29 17:52:16.499121] tm3:[1969-12-31 16:00:00.000000] 
id:[bpH71yEXUIEAOeIiGXix4A2DreB5087110877136] a:[0] b:[b] bitv:[1] bitm:[0] tm1:[2018-01-29 17:52:16.500122] tm2:[2018-01-29 17:52:16.500122] tm3:[1969-12-31 16:00:00.000000] 
