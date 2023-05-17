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
    constraint fk_patients_medical_history foreign key(patients_id) references patients(id)
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

create table treatments (
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
    constraint fk_invoice_items_treatment foreign key(treatment_id) references treatments(id)
)

 create table medical_treatments (
    id int primary key generated always as  identity,
    medical_history_id int,
    treatment_id,
    constraint fk_medical_treatment_history foreign key(medical_history_id) references medical_histories(id),
    constraint fk_medical_treatment_treatment foreign key(treatment_id) references treatments(id)
);

--------INDEX-------------
CREATE index medical_treatments_medical_treatment_history_idx ON medical_treatments(medical_treatment_history asc);
CREATE index medical_treatments_medical_treatment_treatment_idx ON medical_treatments(medical_treatment asc);
CREATE index invoice_items_invoice_items_invoice_idx ON invoice_items(invoice_items_invoice);
CREATE index invoice_items_invoice_items_treatment_idx ON invoice_items(invoice_items_treatment,DESC);
CREATE index invoices_invoices_medical_history_idx ON invoices(invoices_medical_history,ASC);
CREATE index medical_histories_patients_medical_history ON medical_histories(patients_medical_history);

