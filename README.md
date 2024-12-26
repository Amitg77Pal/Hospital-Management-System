
<img width="904" alt="image" src="https://github.com/user-attachments/assets/56ce3412-84dd-4840-8921-9e1aa4cb1a53" />
![Screenshot 2024-10-11 015306](https://github.com/user-attachments/assets/6ebd2cca-e3d6-46cc-a588-5724cf7beb28)
![Screenshot 2024-10-11 022720](https://github.com/user-attachments/assets/c89d0d6f-c1ec-482a-8bf8-0a0e852c0d8f)
![Screenshot 2024-10-11 015831](https://github.com/user-attachments/assets/9dfebe85-4267-4383-a2b6-4eda69e90d1d)
![Screenshot 2024-10-11 015856](https://github.com/user-attachments/assets/6fd9e59b-59d5-49e7-90c2-0d2b3d4e8de1)
![Screenshot 2024-10-11 020001](https://github.com/user-attachments/assets/bcacbfab-b3c5-49af-9b49-ff6cf4782b9e)
![Screenshot 2024-10-11 022932](https://github.com/user-attachments/assets/0318ca5f-c404-4dd4-8305-37f2b81cd0c2)
![Screenshot 2024-10-11 020041](https://github.com/user-attachments/assets/646cd1e6-9644-4a2b-be73-5e77734109d4)
create database hospital;
use hospital;
CREATE TABLE signup (
    email VARCHAR(255) NOT NULL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT NOT NULL CHECK (Age > 0),
    ContactNumber VARCHAR(10) NOT NULL CHECK (LENGTH(ContactNumber) = 10),
    password VARCHAR(255) NOT NULL
);






