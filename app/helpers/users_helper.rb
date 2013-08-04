# encoding: UTF-8

module UsersHelper
	def translate(error)
		dict = {
			"Name can't be blank" => "Имя не должно отсутствовать",
			"Name is invalid" => "Имя должно состоять из двух или трех слов, начинающихся с большой буквы",
			"Email can't be blank" => "Электронная почта обязательна",
			"Email is invalid" => "Адрес электронной почты записан неверно",
			"Password is too short (minimum is 6 characters)" => "Пароль слишком короткий (должен быть не короче 6 символов)",
			"Password can't be blank" => "Пароль не может быть пустым",
			"Password confirmation doesn't match Password" => "Подтверждение пароля введено неверно"
		}

		return dict[error]
	end
end
