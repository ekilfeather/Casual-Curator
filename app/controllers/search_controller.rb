require 'rubygems'
require 'rdf/raptor'

class SearchController < ApplicationController

  def home
  end

  def results
    @search_term = params[:q]
    @artist_name = params[:term]
    # lowercase everything and convert spaces to underscores
    converted_search_term = @search_term.downcase.gsub(/ +/,'_')
    rdf_url = "http://rdf.freebase.com/rdf/en.#{@search_term}"
    # rdf_url = "http://rdf.freebase.com/rdf/en.#{converted_search_term}"
    @core_topic = converted_search_term
    
    @influenced = []
    @influenced_by = []
    
    begin
          
      RDF::Reader.open(rdf_url) do |reader|
        reader.each_statement do |statement| 
          if statement.predicate == 'http://rdf.freebase.com/ns/common.topic.article'
            @bio = statement.object.to_s
          end
          
          if statement.predicate == 'http://rdf.freebase.com/ns/common.topic.image'
            @image = statement.object.to_s.split('.').last
          end
          
          if statement.predicate == 'http://rdf.freebase.com/ns/people.person.place_of_birth'
            @place_of_birth = statement.object.to_s.split('.').last.capitalize
          end
          if statement.predicate == 'http://rdf.freebase.com/ns/people.person.date_of_birth'
            @dob = statement.object.to_s.split('.')
          end
          if statement.predicate == 'http://rdf.freebase.com/ns/people.deceased_person.date_of_death'
            @dod = statement.object.to_s.split('.')
          end
          if statement.predicate == 'http://rdf.freebase.com/ns/influence.influence_node.influenced'
            @influenced << statement.object
          end
          if statement.predicate == 'http://rdf.freebase.com/ns/influence.influence_node.influenced_by'
            @influenced_by << statement.object
          end
          # if statement.predicate == 'http://rdf.freebase.com/ns/type.value.value'
          #   @type = statement.object.to_s.split('.').last.capitalize
          # end     
          @cookie = cookies['_search_app_session']
          # cookies['topic'] = converted_search_term
          @europeana_url = "http://api.europeana.eu/api/opensearch.rss?searchTerms=#{@artist_name}&enrichment_place_label:#{@place_of_birth}&wskey=TPEKSEHABK"
        end # close reader do
      end
      
      # render :xml => @results, :layout => false
      respond_to do |format|
        format.html
        format.xml { render :layout => false }
      end

    rescue
      # flash[:notice] = "We're sorry but there is insufficient RDF data. Please try another artist."
      # redirect_to(:controller => :search, :action => :home)

      respond_to do |format|
        format.html { redirect_to('/search/home', :notice => "We're sorry but there is insufficient RDF data. Please try another artist.") }
        format.xml { render :layout => false }
      end
    end
    
  end
  
  

end