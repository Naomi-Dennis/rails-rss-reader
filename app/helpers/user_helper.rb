module UserHelper
    def username_field 
        text_field_tag "username", nil, placeholder: "Username", required: true
    end 

    def email_field
        text_field_tag "email", nil, placeholder: "Email", required: true
    end 

    def password_field 
        text_field_tag "password", nil, placeholder: "Password", required: true, type: "password"
    end 

    def password_confirm_field 
        text_field_tag "password_confirmation" ,nil, placeholder: "Password Confirmation", required: true, type: "password"
    end 

    def submit_button(value)
        submit_tag value 
    end 
end 