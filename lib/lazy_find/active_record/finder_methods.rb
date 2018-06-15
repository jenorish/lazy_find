module LazyFind
  module ActiveRecord
    module FinderMethods


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

 private

     	def lazy_find(attr,filter)
     	  case attr.class		    
    	    when Hash, Array, String
    		  where(attr).send(filter,nil)
    		else
    		  send(filter,nil)
    		end
    	end

    end
  end
end