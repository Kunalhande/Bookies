class AuthorsController < ApplicationController

  def index
    @authors = Author.all
  end

  def show
    @author = Author.find(params[:id])

    render json:{
      id:@author.id,
      first_name:@author.first_name,
      last_name:@author.last_name
      books:@author.book
    }


  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    
    if @author.save
      redirect_to authors_path
    else
      render :new
    end  
  end  

  def edit
    @author = Author.find(params[:id])
  end

  def update
    @author = Author.find(params[:id])

    if @author.update(author_params)
      redirect_to authors_path
    else 
      render :edit
    end  
  end

  def destroy
    @author = Author.find(params[:id])
    @author.destroy
    redirect_to authors_path
  end

  private 

  def author_params
    params.require(:author)
          .permit(:first_name, :last_name, :date_of_birth)
  end        

end
