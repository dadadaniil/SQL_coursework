CREATE TABLE "Loan_details"(
    "id" BIGSERIAL NOT NULL,
    "purpose_title" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255) NOT NULL,
    "type" BIGINT NOT NULL
);
ALTER TABLE
    "Loan_details" ADD PRIMARY KEY("id");
CREATE TABLE "Customer"(
    "id" BIGSERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "sex" VARCHAR(255) NOT NULL,
    "gender" VARCHAR(255) NOT NULL,
    "birth_date" DATE NOT NULL,
    "personal _code" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "Customer" ADD PRIMARY KEY("id");
ALTER TABLE
    "Customer" ADD CONSTRAINT "customer_email_unique" UNIQUE("email");
CREATE TABLE "Loan_type"(
    "id" BIGSERIAL NOT NULL,
    "type" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "Loan_type" ADD PRIMARY KEY("id");
ALTER TABLE
    "Loan_type" ADD CONSTRAINT "loan_type_type_unique" UNIQUE("type");
CREATE TABLE "Bank"(
    "id" BIGSERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "iban" VARCHAR(255) NOT NULL,
    "foundation_date" DATE NOT NULL,
    "address" VARCHAR(255) NOT NULL,
    "capitalization" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "Bank" ADD PRIMARY KEY("id");
ALTER TABLE
    "Bank" ADD CONSTRAINT "bank_name_unique" UNIQUE("name");
ALTER TABLE
    "Bank" ADD CONSTRAINT "bank_iban_unique" UNIQUE("iban");
ALTER TABLE
    "Bank" ADD CONSTRAINT "bank_address_unique" UNIQUE("address");
CREATE TABLE "Loan"(
    "id" BIGSERIAL NOT NULL,
    "provider" BIGINT NOT NULL,
    "borrower" BIGINT NOT NULL,
    "percent" BIGINT NOT NULL,
    "loan_amount" BIGINT NOT NULL,
    "details" BIGINT NOT NULL,
    "period_start" DATE NOT NULL
);
ALTER TABLE
    "Loan" ADD PRIMARY KEY("id");
ALTER TABLE
    "Loan" ADD CONSTRAINT "loan_borrower_unique" UNIQUE("borrower");
ALTER TABLE
    "Loan" ADD CONSTRAINT "loan_provider_foreign" FOREIGN KEY("provider") REFERENCES "Bank"("id");
ALTER TABLE
    "Loan" ADD CONSTRAINT "loan_borrower_foreign" FOREIGN KEY("borrower") REFERENCES "Customer"("id");
ALTER TABLE
    "Loan_details" ADD CONSTRAINT "loan_details_type_foreign" FOREIGN KEY("type") REFERENCES "Loan_type"("id");