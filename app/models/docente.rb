class Docente < ActiveRecord::Base
  attr_accessible :centro, :docente, :email, :ramal
  validates_format_of :email, :with => /\A([^@\s]+)@(aluno\.ufabc\.edu\.br)|(ufabc\.edu\.br)\z/
  validates :docente, :presence => true
  validates :email, :uniqueness => true
end
