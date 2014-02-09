module SignInHelpers
  def sign_in_as(teacher)
    login_as(teacher, scope: :teacher)
  end
end
