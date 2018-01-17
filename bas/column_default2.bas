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
id:[1] a:[0] b:[b] bitv:[1] bitm:[0] tm1:[2018-01-16 20:38:16.648905] tm2:[2018-01-16 20:38:16.648905] tm3:[1969-12-31 16:00:00.000000] 
id:[2] a:[1] b:[1] bitv:[1] bitm:[1] tm1:[1969-12-31 16:00:00.000001] tm2:[1969-12-31 16:00:00.000001] tm3:[1969-12-31 16:00:00.000001] 
id:[95xmJRH53QaYJ857SZalVfENaGX5696672063896] a:[0] b:[b] bitv:[1] bitm:[0] tm1:[2018-01-16 20:38:16.648883] tm2:[2018-01-16 20:38:16.648883] tm3:[1969-12-31 16:00:00.000000] 
id:[Dkmob94XTY7qMW3vW4jSX1bwGG95696672063896] a:[0] b:[b] bitv:[1] bitm:[0] tm1:[2018-01-16 20:38:16.648863] tm2:[2018-01-16 20:38:16.648863] tm3:[1969-12-31 16:00:00.000000] 
id:[Fgh1AleJsNqQ5TqRJHXhbmBXHVU5696672063896] a:[0] b:[b] bitv:[1] bitm:[0] tm1:[2018-01-16 20:38:16.648781] tm2:[2018-01-16 20:38:16.648781] tm3:[1969-12-31 16:00:00.000000] 
id:[ROGLKVczQPDJ23PYTIjzFuFurqf5696672063896] a:[0] b:[b] bitv:[1] bitm:[0] tm1:[2018-01-16 20:38:16.648842] tm2:[2018-01-16 20:38:16.648842] tm3:[1969-12-31 16:00:00.000000] 
id:[VfqPUF6Vdp8WSTmIYd6PXNLeW7N5696672063896] a:[0] b:[b] bitv:[1] bitm:[0] tm1:[2018-01-16 20:38:16.648818] tm2:[2018-01-16 20:38:16.648818] tm3:[1969-12-31 16:00:00.000000] 
