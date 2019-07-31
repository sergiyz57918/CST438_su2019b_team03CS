require 'httparty'

class CRJ

	include HTTParty
	
	# default_options.update(verify: false) # Turn off SSL
    base_uri "http://localhost:8080"
    format :json
    
    def CRJ.new(email, firstName, lastName)
        obj = {"email"=>email,"firstName"=>firstName,"lastName"=>lastName}
        response = post '/customers',
            body: obj.to_json,
            headers: { 'Content-Type' => 'application/json',
            'ACCEPT' => 'application/json' }
        response
    end

    def CRJ.id(id)
        get('http://localhost:8080/customers?id='+id)
    end
    
    def CRJ.email(email)
        get('http://localhost:8080/customers?email='+email)
    end

end



menu=''
while menu!="quit"
    if menu=="register"
        puts "enter lastName, firstName and email for new customer"
        ent = gets.chomp!
        ent=ent.split(" ")
        lastName = ent[0]
        firstName = ent[1]
        email = ent[2]
        puts ent.inspect
        puts "Hello #{firstName} #{lastName} email:#{email}"
        puts CRJ.new(email, firstName, lastName)
    end

    if menu=="email"
        puts "enter email"
        email = gets.chomp!
        puts CRJ.email(email)
    end        
    if menu=="id"
        puts "enter id"
        id = gets.chomp!
        puts CRJ.id(id)
    end

puts 'What do you want to do: register, email, id or quit'
menu = gets.chomp!
end