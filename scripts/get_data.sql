create table if not exists bank_heap
(
    iban            text,
    foundation_date text,
    bank_name       text,
    address         text,
    capitalization  text
);
ALTER TABLE bank_heap
    ADD CONSTRAINT unique_iban_bank_name_address UNIQUE (iban, bank_name, address);

COPY bank_heap (iban, foundation_date, bank_name, address, capitalization) FROM 'D:/sql/bank_short.csv' DELIMITER ',' CSV HEADER;

INSERT INTO bank_heap
SELECT *
FROM temp_banks_heap
WHERE iban IS NOT NULL
  AND foundation_date IS NOT NULL
  AND bank_name IS NOT NULL
  AND address IS NOT NULL
  AND capitalization IS NOT NULL
ON CONFLICT (iban, bank_name, address) DO NOTHING;

INSERT INTO "Bank" ("name", "iban", "foundation_date", "address", "capitalization")
SELECT bank_name, iban, to_date(foundation_date, 'MM/DD/YYYY'), address, capitalization
FROM bank_heap
on conflict do nothing;


CREATE TABLE IF NOT EXISTS customer_heap
(
    bank_name                text,
    borrower_code            text,
    date                     text,
    period_start             text,
    percent                  integer,
    loan_amount              integer,
    loan_purpose_title       text,
    loan_purpose_description text,
    loan_type                text,
    Name                     text,
    email                    text,
    sex                      text,
    gender                   text,
    birth_date               text,
    is_citizen               text
);


COPY customer_heap (bank_name, borrower_code, date, period_start, percent, loan_amount, loan_purpose_title,
                    loan_purpose_description, loan_type, name, email, sex, gender, birth_date, is_citizen)
    FROM 'D:\sql\customer_short.csv'
    DELIMITER ','
    CSV HEADER;

INSERT INTO "Loan_type" ("type")
SELECT DISTINCT loan_type
FROM customer_heap
WHERE loan_type IS NOT NULL;

INSERT INTO "Customer" ("name", "email", "sex", "gender", "birth_date", "personal _code")
SELECT Name, email, sex, gender, TO_DATE(birth_date, 'MM/DD/YYYY'), borrower_code
FROM customer_heap;

insert into "Loan_details" ("purpose_title", "description", "type")
SELECT loan_purpose_title, loan_purpose_description, (SELECT id FROM "Loan_type" WHERE type = loan_type)
FROM customer_heap
WHERE loan_purpose_description IS NOT NULL
  AND loan_purpose_title IS NOT NULL
  AND loan_type IS NOT NULL;

INSERT INTO "Loan" ("provider", "borrower", "percent", "loan_amount", "details", "period_start")
SELECT (SELECT id FROM "Bank" WHERE name = bank_name LIMIT 1),
       (SELECT id FROM "Customer" WHERE "personal _code" = borrower_code LIMIT 1),
       percent,
       loan_amount,
       (SELECT id FROM "Loan_details" WHERE purpose_title = loan_purpose_title LIMIT 1),
       TO_DATE(period_start, 'MM/DD/YYYY')
FROM customer_heap
WHERE bank_name IS NOT NULL
  AND borrower_code IS NOT NULL
  AND percent IS NOT NULL
  AND loan_amount IS NOT NULL
  AND loan_purpose_description IS NOT NULL
  AND period_start IS NOT NULL
on conflict do nothing;
