class CreateUnaccentSearchConfig < ActiveRecord::Migration[8.0]
  def up
    execute <<-SQL
    CREATE TEXT SEARCH CONFIGURATION f_unaccent ( COPY = simple );
    ALTER TEXT SEARCH CONFIGURATION f_unaccent
      ALTER MAPPING FOR hword, hword_part, word
      WITH unaccent, simple;
    SQL
  end

  def down
    execute <<-SQL
    DROP TEXT SEARCH CONFIGURATION f_unaccent;
    SQL
  end
end
