module SearchHelper
  # delegates to link_to, but reusing the current search params
  def link_to_search_with(name, hash)
    link_to name, {:query      => hash[:query]      || params[:query],
                   :page       => hash[:page]       || params[:page],
                   :per_page   => hash[:per_page]   || params[:per_page],
                   :sort_by    => hash[:sort_by]    || params[:sort_by],
                   :language   => hash[:language]   || params[:language],
                   :sort_order => hash[:sort_order] || params[:sort_order]}
  end

  # same as above, but just a shortcut to link to a specific page of results
  def link_to_search_page(name, page)
    link_to_search_with name, :page => page
  end
end
