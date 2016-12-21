isbns = Isbn.find_by_sql("SELECT * FROM isbns where ebook_id is not NULL LIMIT 1")
isbn = isbns[0]
isbn.ebook.direct_download_url

#isbn.rb update_isbn_provider


isbns = Isbn.last(
    :conditions => Isbn.update_isbn_provider_conditions,
    :include => [:ebook, {:guts => { :book => { :project => :distribution_entries }}}]
)

def direct_download_url(opts = {})
  if opts[:kf8] == true || opts[:kf8] == "true"
    fixed_layout_kf8_url(opts)
  elsif download_ready?
    bbf2_project = Bbf2Project.find_selected_by_guts_id(guts.id)

    if bbf2_project
      api_bbf2_project = Api::Bbf2Project.find_by_id(bbf2_project.project_id)

      api_bbf2_project.epub_url
    end
  else
    public_gluster_download_file
  end
rescue
  # If download_status indicates :ready but this returns nil, it should be considered an unexpected error case
  # I put this rescue block here to avoid errors in test environments with data issues (missing storage system files)
  nil
end

def test1
  puts "test1"
end

def test2
  puts "test2"
  not_found = ::Isnb.find("asd")
end

def test
  test1
  test2
  not_found = ::Isnb.find("asd")
rescue => e
  Rails.logger.error "#{e.message}"
  Rails.logger.error "MissingIsbnInfo Please pay your attention to error message: #{e.message} and backtrace: #{e.backtrace}"
  Rails.logger.error "#{e.inspect}"
  puts "#{e.message}"
  puts "#{e.backtrace}"
  nil
end

raise ::IsbnProvider::MissingIsbnInfo if test.blank?

isbn = Isbn.find_by_number_text '9781367644670'
raise ::IsbnProvider::MissingIsbnInfo unless isbn.ebook.direct_download_url.present?
















