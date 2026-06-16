class BooksController < ApplicationController
    
    def index
        @books = Book.all
    end    

   def show
    @book = Book.find(params[:id])

    respond_to do |format|
        format.html
        format.json do
        render json: {
            id: @book.id,
            book_title: @book.book_title,
            authors: @book.authors.select(:id, :first_name, :last_name)
        }
        end
      end
    end

    def new
        @book = Book.new
        @authors = Author.all
    end

    def create
        @book = Book.new(book_params)

        if @book.save
            redirect_to books_path
        else
            @authors = Author.all
            render :new
        end        
    end

   def edit
        @book = Book.find(params[:id])

        selected_authors = @book.authors
        unselected_authors = Author.where.not(id: selected_authors.pluck(:id))

        @authors = selected_authors + unselected_authors
   end  

    def update
        @book = Book.find(params[:id])

        if @book.update(book_params)
            redirect_to books_path
        else
            selected_authors = @book.authors
            unselected_authors = Author.where.not(id: selected_authors.pluck(:id))

            @authors = selected_authors + unselected_authors

            render :edit
        end   
    end

    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to books_path
    end   

    private

    def book_params
        params.require(:book)
              .permit(:book_title, author_ids: [])
    end          


end
