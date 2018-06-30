class Backoffice::CategoryController < BackofficeController
  before_action :authenticate_admin!
  before_action :set_category, only: [:destroy]
  
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to backoffice_category_index_path
    else
      render :new
    end
  end
  
  def destroy
    if @category.destroy
      redirect_to backoffice_category_index_path, notice: 'Categoria excluída com sucesso!'
    else
      redirect_to backoffice_category_index_path, alert: 'Não foi possível realizar esta ação.'
    end
  end
  
  
  private
  
  def category_params
    params.require(:category).permit(:description, :avatar)
  end
  
  def set_category
    @category = Category.find params[:id]
  end

end