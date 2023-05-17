CREATE TABLE patients(
  id int PRIMARY KEY,
    name VARCHAR(255),
    date_of_birth DATE,
)

-------------------------------
CREATE TABLE medical_histories(
    id int PRIMARY KEY,
    admitted_at timestamp,
    patients_id int,
    status VARCHAR
)

----------------------------

CREATE TABLE invoices(
    id int PRIMARY KEY,
    total_amount decimal,
    generated_at timestamp,
    payed_at timestamp,
    medical_history_id int,
    constraint fk_invoices_medical_history foreign key(medical_history_id) references medical_histories(id)
)

create table treatment (
    id int generated always as identity,
    type VARCHAR(255),
    name varchar(255)
)

-----------------------------
CREATE TABLE invoice_items(
  id int PRIMARY KEY,
  unit_price decimal,
  quantity int,
  total_price decimal,
    invoice_id int,
    treatment_id int,
    constraint fk_invoice_items_invoice foreign key(invoice_id) references invoices(id),
    constraint fk_invoice_items_treatment foreign key(treatment_id) references treatment(id)
)



