class MenuItemsController < ApplicationController
  before_action :set_menu_item, only: [:show, :edit, :update, :destroy]
  # GET /menu_items
  # GET /menu_items.json
  def index
    @menu_items = MenuItem.all
  end

  # GET /menu_items/1
  # GET /menu_items/1.json
  def show
  end

  # GET /menu_items/new
  def new
    @menu_item = MenuItem.new
  end

  # GET /menu_items/1/edit
  def edit
  end

  # POST /menu_items
  # POST /menu_items.json
  def create
    @menu_item = MenuItem.new(menu_item_params)

    respond_to do |format|
      if @menu_item.save
        format.html { redirect_to @menu_item, notice: 'Menu item was successfully created.' }
        format.json { render :show, status: :created, location: @menu_item }
      else
        format.html { render :new }
        format.json { render json: @menu_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menu_items/1
  # PATCH/PUT /menu_items/1.json
  def update
    respond_to do |format|
      if @menu_item.update(menu_item_params)
        format.html { redirect_to @menu_item, notice: 'Menu item was successfully updated.' }
        format.json { render :show, status: :ok, location: @menu_item }
      else
        format.html { render :edit }
        format.json { render json: @menu_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_items/1
  # DELETE /menu_items/1.json
  def destroy
    @menu_item.destroy
    respond_to do |format|
      format.html { redirect_to menu_items_url, notice: 'Menu item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def api
    if params[:method] == "1"
      get_whole_menu();
    elsif params[:method] == "2" 
      get_menu_with_condition();
    end
  end

  def get_whole_menu
    menu_items = MenuItem.all
    puts "Whole menu #{@menu_items}"
    @respond_data = menu_items.as_json
    menu_appetizer = []
    menu_main = []
    menu_desert = []  
    
    menu_items.each do |f|
      if f.category.downcase == "appetizer"
        menu_appetizer.push f
      elsif f.category.downcase == "main"
        menu_main.push f
      elsif f.category.downcase == "desert"
        menu_desert.push f
      end
    end
    json = JSONBuilder::Compiler.generate do
      array ["appetizer", "main", "desert"] do |f|
        if f == "appetizer"
          category "appetizer"
          items menu_appetizer do |item|
            item_name item.name
            item_description item.description
            item_category item.category
            hated "1"
            loved "1"
          end
        elsif  f == "main"
          category "main"
          items menu_main do |item|
            item_name item.name
            item_description item.description
            item_category item.category
            hated "1"
            loved "1"
          end
          
        elsif f == "desert"
          category "desert"
          items menu_desert do |item|
            item_name item.name
            item_description item.description
            item_category item.category
            hated "1"
            loved "1"
          end
        end
      end
    end
    respond_to do |format|
      format.json { render json: json}
      format.html { render json: json}
    end
  end
  
  
  def get_menu_with_condition
    #input A list of email invitation
    email_list = ["a@gmail.com", "b@gmail.com", "c@gmail.com"] #INPUT
    #find a list of customer based on the email
    customers = Customer.where(:email => email_list)
    #output a list of available menu
    #A list of hating ingredients
    loving_taste = Hash.new
    hating_ingredient = Hash.new
    #Return an array of hash [:sweet => "1",:salt => "22"]
    customers.each do |customer|
      tastes = customer.loving_taste.split(",")
      tastes.each do |f|
        f = f.strip.downcase
        if loving_taste[f] == nil
          loving_taste[f] = 1
        else 
          loving_taste[f] = loving_taste[f] + 1
        end
      end
      ingredient = customer.hating_ingredient.split(",")
      ingredient.each do |f|
        f = f.strip.downcase 
        if hating_ingredient[f] == nil
          hating_ingredient[f] = 1
        else
          hating_ingredient[f] = hating_ingredient[f] + 1
        end
      end
      puts "DEBUG::menu_item_contr::customer_email: #{customer.email}, loving_taste: #{customer.loving_taste}, hating_ingredient: #{customer.hating_ingredient}"
    end

    
    puts "DEBUG::menu_item_contr:: #{loving_taste}"
    puts "DEBUG::menu_item_contr::  #{hating_ingredient}"
    
    menu_items = MenuItem.all
    menu_appetizer = []
    menu_main = []
    menu_desert = []  
    
    menu_items.each do |f|
      if f.category.downcase == "appetizer"
        menu_appetizer.push f
      elsif f.category.downcase == "main"
        menu_main.push f
      elsif f.category.downcase == "desert"
        menu_desert.push f
      end
    end

    json = JSONBuilder::Compiler.generate do
      number_people email_list.size
      category_type = ["appetizer", "main", "desert"]
      meals category_type do |f|
        if f == "appetizer"
          category "Appetizer"
          items menu_appetizer do |app_item|
            item_name app_item.name
            item_description app_item.description
            item_category app_item.category
            hating_ingredient_number = 0
            loving_taste_number = 0
            item_ingredient_array = app_item.ingredient.split(",")
            item_ingredient_array.each do  |i|
              i = i.strip.downcase
              if hating_ingredient[i] != nil
                if hating_ingredient_number < hating_ingredient[i]
                  hating_ingredient_number = hating_ingredient[i]
                end
              end
            end
            item_taste_array = app_item.taste.split(",")
            item_taste_array.each do |i|
              i = i.strip.downcase
              if loving_taste[i] != nil
                if loving_taste_number < loving_taste[i]
                  loving_taste_number = loving_taste[i]
                end
              end
            end
            hated hating_ingredient_number
            loved loving_taste_number
            
          end
        elsif f == "main"
          category "Main"
          items menu_main do |main_item|
            item_name main_item.name
            item_description main_item.description
            item_category main_item.category
            hating_ingredient_number = 0
            loving_taste_number = 0
            item_ingredient_array = main_item.ingredient.split(",")
            item_ingredient_array.each do  |i|
              i = i.strip.downcase
              if hating_ingredient[i] != nil
                if hating_ingredient_number < hating_ingredient[i]
                  hating_ingredient_number = hating_ingredient[i]
                end
              end
            end
            item_taste_array = main_item.taste.split(",")
            item_taste_array.each do |i|
              i = i.strip.downcase
              if loving_taste[i] != nil
                if loving_taste_number < loving_taste[i]
                  loving_taste_number = loving_taste[i]
                end
              end
            end
            hated hating_ingredient_number
            loved loving_taste_number
          end
        elsif f == "desert"
           category "Desert"
          items menu_desert do |desert_item|
            item_name desert_item.name
            item_description desert_item.description
            item_category desert_item.category
            hating_ingredient_number = 0
            loving_taste_number = 0
            item_ingredient_array = desert_item.ingredient.split(",")
            item_ingredient_array.each do  |i|
              i = i.strip.downcase
              if hating_ingredient[i] != nil
                if hating_ingredient_number < hating_ingredient[i]
                  hating_ingredient_number = hating_ingredient[i]
                end
              end
            end
            item_taste_array = desert_item.taste.split(",")
            item_taste_array.each do |i|
              i = i.strip.downcase
              if loving_taste[i] != nil
                if loving_taste_number < loving_taste[i]
                  loving_taste_number = loving_taste[i]
                end
              end
            end
            hated hating_ingredient_number
            loved loving_taste_number
          end
        end
      end
    end    
    respond_to do |f|
      f.html {render json: json}
      f.json {render json: json}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu_item
      @menu_item = MenuItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_item_params
      params.require(:menu_item).permit(:name, :description, :category, :ingredient, :taste)
    end
end
