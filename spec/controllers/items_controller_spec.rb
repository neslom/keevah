require 'rails_helper'

RSpec.describe ItemsController, :type => :controller do

  let(:valid_attributes) {
    { title: 'Carnitas', description: "Hot and porky", price: 3, food_group: "Meat"}
  }

  let(:invalid_attributes) {
    { title: nil, description: nil, price: nil, food_group: nil }
  }
  
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all items as @items" do
      item = Item.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:items)).to eq([item])
    end
  end

  describe "GET show" do
    it "assigns the requested item as @item" do
      item = Item.create! valid_attributes
      get :show, {:id => item.to_param}, valid_session
      expect(assigns(:item)).to eq(item)
    end
  end

  describe "GET new" do
    it "assigns a new item as @item" do
      get :new, {}, valid_session
      expect(assigns(:item)).to be_a_new(Item)
    end
  end

  describe "GET edit" do
    it "assigns the requested item as @item" do
      item = Item.create! valid_attributes
      get :edit, {:id => item.to_param}, valid_session
      expect(assigns(:item)).to eq(item)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new item" do
        expect {
          post :create, {:item => valid_attributes}, valid_session
        }.to change(Item, :count).by(1)
      end

      it "assigns a newly created item as @item" do
        post :create, {:item => valid_attributes}, valid_session
        expect(assigns(:item)).to be_a(Item)
        expect(assigns(:item)).to be_persisted
      end

      it "redirects to the created item" do
        post :create, {:item => valid_attributes}, valid_session
        expect(response).to redirect_to(Item.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved item as @item" do
        post :create, {:item => invalid_attributes}, valid_session
        expect(assigns(:item)).to be_a_new(Item)
      end

      it "re-renders the 'new' template" do
        post :create, {:item => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        {title: "NewTitle", description: "NewDescription", price: 3, food_group: "NewGroup" }
      }

      it "updates the requested item" do
        item = Item.create! valid_attributes
        put :update, {:id => item.to_param, :item => new_attributes}, valid_session
        item.reload
        expect(item.title).to eq("NewTitle")
        expect(item.description).to eq("NewDescription")
        expect(item.price).to eq(3)
        expect(item.food_group).to eq("NewGroup")
      end

      it "assigns the requested item as @item" do
        item = Item.create! valid_attributes
        put :update, {:id => item.to_param, :item => valid_attributes}, valid_session
        expect(assigns(:item)).to eq(item)
      end

      it "redirects to the item" do
        item = Item.create! valid_attributes
        put :update, {:id => item.to_param, :item => valid_attributes}, valid_session
        expect(response).to redirect_to(item)
      end
    end

    describe "with invalid params" do
      it "assigns the item as @item" do
        item = Item.create! valid_attributes
        put :update, {:id => item.to_param, :item => invalid_attributes}, valid_session
        expect(assigns(:item)).to eq(item)
      end

      it "re-renders the 'edit' template" do
        item = Item.create! valid_attributes
        put :update, {:id => item.to_param, :item => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested item" do
      item = Item.create! valid_attributes
      expect {
        delete :destroy, {:id => item.to_param}, valid_session
      }.to change(Item, :count).by(-1)
    end

    it "redirects to the items list" do
      item = Item.create! valid_attributes
      delete :destroy, {:id => item.to_param}, valid_session
      expect(response).to redirect_to(items_url)
    end
  end

end