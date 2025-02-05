CREATE TABLE students (
    id SERIAL PRIMARY KEY,           
    surname VARCHAR(100) NOT NULL,   
    firstname VARCHAR(100) NOT NULL,      
    lastname VARCHAR(100) NOT NULL,        
    birthdate DATE NOT NULL,                  
    phone_number VARCHAR(15),               
    telegram VARCHAR(50),            
    email VARCHAR(255),              
    git VARCHAR(255)                 
);