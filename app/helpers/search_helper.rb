module SearchHelper
  # delegates to link_to, but reusing the current search params
  def link_to_search_with(name, hash)
    link_to name, {:query => hash[:query] || params[:query],
                   :page => hash[:page] || params[:page],
                   :per_page => hash[:per_page] || params[:per_page]}
  end
end
