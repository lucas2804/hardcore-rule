isbns = Isbn.find_by_sql("SELECT * FROM isbns where ebook_id != NULL")

