module LazyFind
  module ActiveRecord
    module FinderMethods

    MAPPING = {:first => 0, :last => -1}
    # Find the first record (or first N records if a parameter is supplied).
    # If no order is defined it will order by primary key.
    #
    #   Person.first # returns the first object fetched by SELECT * FROM people ORDER BY people.id LIMIT 1
    #   Person.where(["user_name = ?", user_name]).first
    #   Person.where(["user_name = :u", { u: user_name }]).first
    #   Person.order("created_on DESC").offset(5).first
    #   Person.first(:email => "jenorish@gmail") # returns the first three objects fetched by SELECT * FROM people WHERE email= 'jenorish@gmail.com'  ORDER BY people.id LIMIT 3
 
      def first(attr = nil)
         return super(attr) if attr.blank? || attr.class == Fixnum 
         lazy_find(attr,:first)
      end


    # Find the last record (or last N records if a parameter is supplied).
    # If no order is defined it will order by primary key.
    #
    #   Person.last # returns the last object fetched by SELECT * FROM people
    #   Person.where(["user_name = ?", user_name]).last
    #   Person.order("created_on DESC").offset(5).last
    #   Person.last({:email => "jenorish@gmail"}) # returns the last three objects fetched by SELECT * FROM people WHERE email= 'jenorish@gmail.com' .
    #
    # Take note that in that last case, the results are sorted in ascending order:
    #
    #   [#<Person id:2>, #<Person id:3>, #<Person id:4>]
    #
    # and not:
    #
    #   [#<Person id:4>, #<Person id:3>, #<Person id:2>]  


      def last(attr = nil)
        return super(attr) if attr.blank? || attr.class == Fixnum 
        lazy_find(attr,:last)
      end
    
    # Gives a record (or N records if a parameter is supplied) without any implied
    # order. The order will depend on the database implementation.
    # If an order is supplied it will be respected.
    #
    #   Person.take # returns an object fetched by SELECT * FROM people LIMIT 1
    #   Person.take({:email => "jenorish@gmail"}) # returns matched objects fetched by SELECT * FROM people WHERE email= 'jenorish@gmail.com' LIMIT 5
    #   Person.where(["name LIKE '%?'", name]).take

      def take(attr = nil)
        return super(attr) if attr.blank? || attr.class == Fixnum 
        lazy_find(attr,:take)
      end

    # posts = Post.all
    # posts.size # Fires "select count(*) from  posts" and returns the count    
    # posts.each {|p| puts p.name } # Fires "select * from posts" and loads post objects
   
    def lazy_all(attr = nil)
      return all if attr.blank?
      lazy_find(attr,:all)
    end

    alias_method :lazy_where, :lazy_all

 private

     	def lazy_find(attr,filter)
    	  if [Hash, Array, String].include?(attr.class)
          sort_val   = extract_order(attr)
          select_val = extract_select(attr) 
          if select_val
            where(attr).order(sort_val).select(select_val).send(filter)
          else
    		    where(attr).order(sort_val).send(filter)
          end
    		else
    		 send(filter,nil)
    		end
      end

      def extract_order(attr)
        return "id" unless attr.class == Hash
        attr.symbolize_keys!
        order = attr.delete(:order) 
        order ? order : "id"
      end
      def extract_select(attr)
        return nil unless attr.class == Hash
        attr.delete(:select) 
      end
    end
  end
end