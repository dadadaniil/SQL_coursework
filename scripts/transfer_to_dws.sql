CREATE OR REPLACE FUNCTION transfer_data_to_dws() RETURNS VOID AS $$
DECLARE
    bank_data RECORD;
    public_information_id BIGINT;
    capitalization_id BIGINT;
BEGIN
    FOR bank_data IN SELECT name, iban, foundation_date, address, capitalization FROM postgres.public.Bank
    LOOP
        -- Insert into public_information table and get the id
        INSERT INTO bank_dws.public.public_information (foundation_date, address, iban)
        VALUES (bank_data.foundation_date, bank_data.address, bank_data.iban)
        RETURNING id INTO public_information_id;

        -- Insert into capitalization table and get the id
        INSERT INTO bank_dws.public.capitalization (capitalization)
        VALUES (bank_data.capitalization)
        RETURNING id INTO capitalization_id;

        -- Insert into bank table
        INSERT INTO bank_dws.public.bank (public_information, accounting)
        VALUES (public_information_id, capitalization_id);
    END LOOP;
END;
$$ LANGUAGE plpgsql;