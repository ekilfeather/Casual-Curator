xml.eurohack do
  
  xml.core_topic do
    xml.url("http://rdf.freebase.com/rdf/en.#{@core_topic}")
    xml.euro_search_narrow_url("http://api.europeana.eu/api/opensearch.rss?searchTerms=#{@core_topic}&wskey=TPEKSEHABK")
    xml.euro_search_broad_url("http://api.europeana.eu/api/opensearch.rss?searchTerms=#{@core_topic}+enrichment_place_broader_label:#{@place_of_birth}&wskey=TPEKSEHABK")
  end

  @influenced_by.each do |person|
    @influencer = person.to_s.split('.').last  
    xml.influencer_topic do
      xml.url("http://rdf.freebase.com/rdf/en.#{@influencer}")
      xml.euro_search_narrow_url("http://api.europeana.eu/api/opensearch.rss?searchTerms=#{@influencer}&wskey=TPEKSEHABK")
    end
  end
  
  @influenced.each do |person|
    @influenced_artist = person.to_s.split('.').last  
    xml.influenced_topic do
      xml.url("http://rdf.freebase.com/rdf/en.#{@influenced_artist}")
      xml.euro_search_narrow_url("http://api.europeana.eu/api/opensearch.rss?searchTerms=#{@influenced_artist}&wskey=TPEKSEHABK")
    end
  end
    
end

# curl -i -H "Accept: application/xml" http://localhost:3000/search/results?utf8=%E2%9C%93&q=Gabriel+Metsu&commit=Search
# curl http://localhost:3000/search/results?utf8=%E2%9C%93&q=Gabriel+Metsu&commit=Search
# johannes++vermeer
# curl http://localhost:3000/search/results?utf8=%E2%9C%93&q=johannes++vermeer&commit=Search

# curl -H "Accept: application/xml" http://localhost:3000/search/results?q=Johannes+Vermeer