class Guestnote < ActiveRecord::Base
  validates_presence_of :note
  validates_presence_of :author
  
  def validate_token(expected, actual)
    if expected != actual
      errors.add("Resultat", "wurde falsch eingegeben")
      result = false
    else
      result = true
    end
    result
  end
  
end
