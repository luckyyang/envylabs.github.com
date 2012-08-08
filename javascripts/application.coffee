window.EL = {
  teamHover: (collection) ->
    $(collection).on 'hover', (e) ->
      $(@).siblings('a').toggleClass('inactive')
}
