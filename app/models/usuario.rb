class Usuario < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable#, :trackable, :validatable,
         #:confirmable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :nome, :tipo, :ra, :centro, :telefone
  
  # attr_accessible :title, :body
  
  validates_size_of :ra, :is => 8, :if => :eh_aluno?, :on => :create
  validates_format_of :email, :with => /\A([^@\s]+)@(aluno\.ufabc\.edu\.br)|(ufabc\.edu\.br)\z/
  validates :telefone, :presence => true
  validates :ra, :uniqueness => true, :if => :eh_aluno?
  
  def eh_aluno?
    tipo == 'Aluno'
  end
end
