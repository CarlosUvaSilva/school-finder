class AddTsVectorToSchool < ActiveRecord::Migration[8.0]
  def up
    add_column :schools, :tsv_accented, :tsvector
    add_index :schools, :tsv_accented, using: "gin"

    execute <<-SQL
      CREATE OR REPLACE FUNCTION fill_search_vector_for_school() RETURNS trigger LANGUAGE plpgsql AS $$
      declare
        name varchar;
        parish varchar;
        city varchar;
        phone_number varchar;
        email_name varchar;
        email_domain varchar;

      begin
        SELECT new.name into name;
        SELECT new.parish into parish;
        SELECT new.city into city;
        SELECT new.phone_number into phone_number;
        SELECT REPLACE (substring(new.email from '(.*)@'), '.', ' ') into email_name;
        SELECT substring(new.email from '(?<=@)[^.]+(?=\.)') into email_domain;

        new.tsv_accented :=
          setweight(to_tsvector('public.f_unaccent', coalesce(name, '')), 'A') ||
          setweight(to_tsvector('public.f_unaccent', coalesce(parish, '')), 'A') ||
          setweight(to_tsvector('public.f_unaccent', coalesce(city, '')), 'A') ||
          setweight(to_tsvector('public.f_unaccent', coalesce(phone_number, '')), 'A') ||
          setweight(to_tsvector('public.f_unaccent', coalesce(email_name, '')), 'A') ||
          setweight(to_tsvector('public.f_unaccent', coalesce(email_domain, '')), 'B');
        return new;
      end
      $$;

      CREATE TRIGGER unaccentedtrigger BEFORE INSERT OR UPDATE
        ON schools FOR EACH ROW EXECUTE PROCEDURE fill_search_vector_for_school();
    SQL

    now = Time.current.to_fs(:db)
    update("UPDATE schools SET updated_at = '#{now}'")
  end

  def down
    execute <<-SQL
      DROP TRIGGER unaccentedtrigger
      ON schools;
    SQL

    remove_index :schools, :tsv_accented
    remove_column :schools, :tsv_accented
  end
end
