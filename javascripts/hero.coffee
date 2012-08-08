class Hero
  constructor: (@selector, info, next, prev) ->
    @setupHero(@selector, info, next, prev)

  setupHero: (@selector, info, next, prev) ->
    @heroes = $(@selector)
    @hero = @heroes.first()
    @info = $(info)
    @setHero(@hero)
    $(next).on 'click', (e) =>
      e.preventDefault()
      @setHero(@nextHero(@hero))
    $(prev).on 'click', (e) =>
      e.preventDefault()
      @setHero(@prevHero(@hero))
    @hero

  setHero: (new_hero) ->
    @heroes.removeClass 'active prev'
    @hero = new_hero.addClass 'active'
    @prevHero(@hero).addClass 'prev'
    @info.html(@hero.attr('alt'))

  nextHero: (hero) ->
    next = if hero.next(@selector).length > 0 then hero.next(@selector) else @heroes.first()

  prevHero: (hero) ->
    prev = if hero.prev(@selector).length > 0 then hero.prev(@selector) else @heroes.last()

window.EL.Hero = Hero
