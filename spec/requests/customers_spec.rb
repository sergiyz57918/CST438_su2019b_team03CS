require 'rails_helper'

RSpec.describe 'CustomersController', type: :request  do

  # Test suite for GET /customers
  describe 'GET /customers' do
    # make HTTP get request before each example
    before { get '/customers' }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for POST /customers
  describe 'POST /customers' do
    # valid payload
    let(:valid_attributes) {{ email: 'iam@test.me', lastName: 'SkyWlaker', firstName: 'Luke' } }

    context 'when the request is valid' do
      before { post '/customers', params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
      
      it 'returns valid JSON' do
       customer = JSON.parse(response.body) 
       expect(customer.keys).to contain_exactly( 
         'id',
        'email',
        'lastName',
        'firstName',
        'lastOrder',
        'lastOrder2',
        'lastOrder3',
        'award',
        'created_at',
        'updated_at')
      end
      
      it 'returns valid customer' do
       customer = JSON.parse(response.body) 
       expect(customer['id']).to eq 1
       expect(customer['email']).to eq 'iam@test.me'
       expect(customer['lastName']).to eq 'SkyWlaker'
       expect(customer['firstName']).to eq 'Luke'
      end      
    end

    #TODO Expend to check email, lastName, firstName
    context 'when the request has invalid email' do
      before { post '/customers', params: { email: 'Foobar',lastName: 'SkyWlaker', firstName: 'Luke' } }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        email = JSON.parse(response.body)
        expect(email['email'][0]).to eq('is invalid')
      end
    end

    #TODO Expend to check email, lastName, firstName
    context 'when the request is empty' do
      before { post '/customers', params: { email: '',lastName: '', firstName: '' } }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        validation = JSON.parse(response.body)
        #puts validation
        expect(validation['email'][0]).to eq("can't be blank")
        expect(validation['email'][1]).to eq('is invalid')
        expect(validation['lastName'][0]).to eq("can't be blank")
        expect(validation['firstName'][0]).to eq("can't be blank")
      end
    end
    
    #TODO Expend to check email, lastName, firstName
    context 'when the email is not uniquey' do
      before { post '/customers', params: { email: 'elliott@schulist.net',lastName: 'Turcotte', firstName: 'Gregory' } }
      before { post '/customers', params: { email: 'elliott@schulist.net',lastName: 'Turcotte', firstName: 'Gregory' } }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        validation = JSON.parse(response.body)
        #puts validation
        expect(validation['email'][0]).to eq("must be unique")

      end
    end
  end
    
  # Test suite for GET /customers?id
  describe 'GET /customers?id=:id' do
    # make HTTP get request before each example
    before { post '/customers', params: { email: 'elliott@schulist.net',lastName: 'Turcotte', firstName: 'Gregory' } }
    before { get '/customers?id=1' }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
    
    it 'returns status code 404' do
      get '/customers?id=10'
      expect(response).to have_http_status(404)
    end
    
  end
  
  
  # Test suite for GET /customers?email
  describe 'GET /customers?email=:email' do
    # make HTTP get request before each example
    before { post '/customers', params: { email: 'elliott@schulist.net',lastName: 'Turcotte', firstName: 'Gregory' } }
    before { get '/customers?email=elliott@schulist.net' }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
    
    it 'returns status code 404' do
      get '/customers?id=ildadach@labadie.com'
      expect(response).to have_http_status(404)
    end
  end
  
  
  # Test suite for PUT /customers
  describe 'PUT /customers/order' do
    # valid payload
    let(:valid_attributes) {{ itemId: '1', description: 'SkyWlaker', customerId: 2, price: '999.99' ,award: '0' ,total:'999.99'   } }
    let(:valid_attributes2) {{ itemId: '1', description: 'SkyWlaker', customerId: 2, price: '999.99' ,award: '9.99' ,total:'990.00'   } }
    
    #invalid payload
    let(:invalid_attributes) {{ itemId: '1', description: 'SkyWlaker', customerId: 2, price: '999.99' ,award: '0' ,total:'-999.99'   } }
    let(:invalid_attributes2) {{ itemId: '1', description: 'SkyWlaker', customerId: 10, price: '999.99' ,award: '9.99' ,total:'-990.00'   } }
    
    context 'when the request is valid' do
      before { post '/customers', params: { email: 'elliot1@schulist.net',lastName: 'SkyWlaker', firstName: 'Luke' } }
      before { post '/customers', params: { email: 'elliot2@schulist.net',lastName: 'SkyWlaker', firstName: 'Luke' } }
      before { put '/customers/order', params: valid_attributes }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
        #puts JSON.parse(response.body)
        #get '/customers?id=1'
        #puts JSON.parse(response.body)
        
      end
      
      it 'returns customer populated lastOrder and lastOrder2 ' do
        put '/customers/order', params: valid_attributes
        get '/customers?id=2'
        customer = JSON.parse(response.body)
        expect(customer['lastOrder']).to eq "999.99"
        expect(customer['lastOrder2']).to eq "999.99"
        
      end
      it 'returns customer populated lastOrder and lastOrder2 and lastOrder3' do
        put '/customers/order', params: valid_attributes
        put '/customers/order', params: valid_attributes
        get '/customers?id=2'
        customer = JSON.parse(response.body)
        expect(customer['lastOrder']).to eq "999.99"
        expect(customer['lastOrder2']).to eq "999.99"
        expect(customer['lastOrder3']).to eq "999.99"
        
      end
      
      it 'returns customer populated with award after 4 purchases' do
        put '/customers/order', params: valid_attributes
        put '/customers/order', params: valid_attributes
        put '/customers/order', params: valid_attributes2
        get '/customers?id=2'
        customer = JSON.parse(response.body)
        expect(customer['lastOrder']).to eq "999.99"
        expect(customer['lastOrder2']).to eq "999.99"
        expect(customer['lastOrder3']).to eq "999.99"
        expect(customer['award']).to eq "9.99"
        
      end      
      
      it 'returns customer award cleared after 5th purchase' do
        put '/customers/order', params: valid_attributes
        put '/customers/order', params: valid_attributes
        put '/customers/order', params: valid_attributes2
        put '/customers/order', params: valid_attributes
        get '/customers?id=2'
        customer = JSON.parse(response.body)
        expect(customer['lastOrder']).to eq "999.99"
        expect(customer['lastOrder2']).to eq "0.0"
        expect(customer['lastOrder3']).to eq "0.0"
        expect(customer['award']).to eq "0.0"
        
      end 
    end
    context 'when the request is not valid' do  
      before { post '/customers', params: { email: 'elliot1@schulist.net',lastName: 'SkyWlaker', firstName: 'Luke' } }
      before { post '/customers', params: { email: 'elliot2@schulist.net',lastName: 'SkyWlaker', firstName: 'Luke' } }
      before { put '/customers/order', params: invalid_attributes }
      
      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
      
    end


  end
    
  
  
end
