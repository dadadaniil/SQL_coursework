CREATE TABLE "loan_purpose_dws"(
    "id" bigserial NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "loan_purpose_dws" ADD PRIMARY KEY("id");
CREATE TABLE "bank_dws"(
    "id" bigserial NOT NULL,
    "public_information" BIGINT NOT NULL,
    "accounting" BIGINT NOT NULL,
    "valid_from" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "valid_to" TIMESTAMP(0) WITHOUT TIME ZONE NULL
);
ALTER TABLE
    "bank_dws" ADD PRIMARY KEY("id");
CREATE TABLE "person_dws"(
    "id" bigserial NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "sex" VARCHAR(255) NOT NULL,
    "birth_date" DATE NOT NULL,
    "gender" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "person_dws" ADD PRIMARY KEY("id");
CREATE TABLE "public_information_dws"(
    "id" bigserial NOT NULL,
    "foundation_date" DATE NOT NULL,
    "address" VARCHAR(255) NOT NULL,
    "iban" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "public_information_dws" ADD PRIMARY KEY("id");
CREATE TABLE "loan_dws"(
    "id" bigserial NOT NULL,
    "details" BIGINT NOT NULL,
    "justification" BIGINT NOT NULL,
    "provider" BIGINT NOT NULL,
    "borrower" BIGINT NOT NULL,
    "type" BIGINT NOT NULL,
    "valid_from" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "valid_to" TIMESTAMP(0) WITHOUT TIME ZONE NULL
);
ALTER TABLE
    "loan_dws" ADD PRIMARY KEY("id");
CREATE TABLE "loan_details_dws"(
    "id" bigserial NOT NULL,
    "percent" VARCHAR(255) NOT NULL,
    "loan_amount" VARCHAR(255) NOT NULL,
    "period_start" DATE NOT NULL
);
ALTER TABLE
    "loan_details_dws" ADD PRIMARY KEY("id");
CREATE TABLE "type_dws"(
    "id" bigserial NOT NULL,
    "type" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "type_dws" ADD PRIMARY KEY("id");
ALTER TABLE
    "type_dws" ADD CONSTRAINT "type_dws_type_unique" UNIQUE("type");
CREATE TABLE "customer_dws"(
    "id" bigserial NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "personal_code" VARCHAR(255) NOT NULL,
    "person" BIGINT NOT NULL
);
ALTER TABLE
    "customer_dws" ADD PRIMARY KEY("id");
CREATE TABLE "capitalization_dws"(
    "id" bigserial NOT NULL,
    "capitalization" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "capitalization_dws" ADD PRIMARY KEY("id");
ALTER TABLE
    "bank_dws" ADD CONSTRAINT "bank_dws_accounting_foreign" FOREIGN KEY("accounting") REFERENCES "capitalization_dws"("id");
ALTER TABLE
    "bank_dws" ADD CONSTRAINT "bank_dws_public_information_foreign" FOREIGN KEY("public_information") REFERENCES "public_information_dws"("id");
ALTER TABLE
    "loan_dws" ADD CONSTRAINT "loan_dws_justification_foreign" FOREIGN KEY("justification") REFERENCES "loan_purpose_dws"("id");
ALTER TABLE
    "customer_dws" ADD CONSTRAINT "customer_dws_person_foreign" FOREIGN KEY("person") REFERENCES "person_dws"("id");
ALTER TABLE
    "loan_dws" ADD CONSTRAINT "loan_dws_borrower_foreign" FOREIGN KEY("borrower") REFERENCES "customer_dws"("id");
ALTER TABLE
    "loan_dws" ADD CONSTRAINT "loan_dws_type_foreign" FOREIGN KEY("type") REFERENCES "type_dws"("id");
ALTER TABLE
    "loan_dws" ADD CONSTRAINT "loan_dws_details_foreign" FOREIGN KEY("details") REFERENCES "loan_details_dws"("id");