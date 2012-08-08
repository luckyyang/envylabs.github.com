class Faces
  constructor: (container, info, next, prev) ->
    @setupFaces(container, info, next, prev)

  setupFaces: (container, info, next, prev) ->
    @root = $(container)
    @info = $(info)
    faces = @root.children('li')
    @index = Math.floor(faces.length) / 2 - 2
    @face = faces.eq(@index)
    @setFace(@face)
    @repositionFaces()
    setTimeout ( => @root.removeClass 'inactive' ), 1

    $(next).on 'click', (e) =>
      e.preventDefault()
      @setFace(@face.next())
    $(prev).on 'click', (e) =>
      e.preventDefault()
      @setFace(@face.prev())
    $('.icn-profile').on 'click', (e) =>
      e.preventDefault()
      @setFace(faces.eq(Math.floor(Math.random() * (faces.length))))
    $(document).on 'keydown', (e) =>
      switch e.which
        when 39 then @setFace(@face.next())
        when 37 then @setFace(@face.prev())
    faces.on 'click', (e) =>
      if !$(e.currentTarget).hasClass('active')
        e.preventDefault()
        @setFace($(e.currentTarget))

  setFace: (new_face) ->
    faces = @root.children('li').removeClass 'active'
    old_index = faces.index(@face)
    @face = new_face.addClass 'active'
    @index = faces.index(@face)
    @repositionFaces() if @reorderFaces(@index - old_index)
    @info.find('.faces-name').html(@face.data('name')).attr('href', @face.find('a').attr('href'))
    @info.find('b').html(@face.data('title'))

  reorderFaces: (offset) ->
    faces = @root.children('li')
    if offset > 1 || offset < -1
      @root.addClass 'animating'
      setTimeout ( => @root.removeClass 'animating' ), 300
    if offset > 0
      faces.slice(0, offset).appendTo @root
      true
    else if offset < 0
      faces.slice(offset).prependTo @root
      true
    else
      false

  repositionFaces: ->
    faces = @root.children('li')
    faces.each (i) =>
      faces.eq(i).css 'left', (i - faces.index(@face)) * 130

window.EL.Faces = Faces
