window.App ||= {}
class App.Pages extends App.Base

  beforeAction: (action) =>
    return


  afterAction: (action) =>
    return


  pricing: =>
    
    $(document).on "click",".subscription_lnk", (event) ->
      if $(this).hasClass('disabled')
        event.preventDefault()
        return false
      lnk = $(this).attr('lnk')
      method = $(this).data('method')
      plan_id = $(this).attr("plan_id")
      $("#subscription_form #plan_id").val(plan_id)
      $(this).addClass('btn-default')
      $(this).addClass('disabled')
      event.preventDefault()
      $.ajax
        url: lnk
        type: method
        data: $("#subscription_form").serialize()
        beforeSend: ->
          show_loader(plan_id)

    
    hide_loader =  ->
      $("html, body").animate
        scrollTop: $($alert).offset().top
      , 200
      $(".pre-loader").addClass('hide')

    show_loader = (plan_id) ->
      $(".plan-content[plan_id=#{plan_id}] .pre-loader").removeClass('hide')  
    return
