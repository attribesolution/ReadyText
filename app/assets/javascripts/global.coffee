##########################################################
## All the regular experession validators will be
## defined in this method: FormValidators
## Scope: Globally used throughout the jobseeker theme
## Author: Sarwan Kumar
App.formValidators = ->
  $.validator.addMethod 'phoneCheck', ((phone_number, element) ->
    this.optional(element) or phone_number.match /^[+]{0,1}(?:[0-9]●?){6,14}[0-9]$/
  ), 'Please enter a valid phone number'

############# END OF Method: FormValidators ##############
##########################################################

#### signup form validations ####
App.signUpFormValidator = ->
  $("#signup_form").validate
    errorClass: 'text-danger'
    validClass: 'valid'
    errorPlacement: (error, element) ->
      error.insertAfter $(element)

    rules:
      "restaurant_name":
        required: true
      "user[name]":
        required: true
      "user[email]":
        required: true
        email: true
      "user[phone]":
        phoneCheck: true
      "user[password]":
        minlength: 8
        required: true

      "user[password_confirmation]":
        required: true
        minlength: 8
        equalTo: "#user_password_confirmation"
    messages:
      "restaurant_name":
        required: "Restaurant Name is required."
      "user[name]":
        required: "Name is required."
      "user[email]":
        required: "Email is required."
        email: "Please enter a valid email address."

      "user[password]":
        required: "Password is required."

      "user[password_confirmation]":
        required: "Confirm password is required."
        equalTo: "Password and Confirm Password does not match."