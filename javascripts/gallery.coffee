class Gallery
  constructor: (photos, lightbox, close, prev, next) ->
    @lightbox = $(lightbox)
    @photos = $(photos).on('click', (e) =>
      e.preventDefault()
      @show($(e.currentTarget), close, prev, next)
    )

  show: (photo, close, prev, next) ->
    @lightbox.addClass('active')
    @load(photo)
    $(document).on('keydown.gallery', (e) =>
      switch e.which
        when 27 then @close()
        when 37 then photo = @load(@prev(photo))
        when 39 then photo = @load(@next(photo))
    ).on('click.gallery', @lightbox.selector, (e) =>
      @close()
    ).on('click.gallery', @lightbox.selector + ' img', (e) =>
      e.stopPropagation()
    ).on('click.gallery', close, (e) =>
      @close()
      false
    ).on('click.gallery', prev, (e) =>
      photo = @load(@prev(photo))
      false
    ).on('click.gallery', next, (e) =>
      photo = @load(@next(photo))
      false
    )

  load: (photo) ->
    @lightbox.find('img').before($('<img />').attr(
      alt: photo.find('img').attr('alt')
      src: photo.data('large')
    )).remove()
    photo

  close: ->
    @lightbox.removeClass('active')
    $(document).off('.gallery')

  next: (photo) ->
    next = if photo.next().length > 0 then photo.next() else @photos.first()

  prev: (photo) ->
    prev = if photo.prev().length > 0 then photo.prev() else @photos.last()

window.EL.Gallery = Gallery
