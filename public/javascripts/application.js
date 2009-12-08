var Glacier = {};

Glacier.Utilities = {

	Error: {
      show: function(message) {
          var container = $('main_error_message');

          if (container == null) {
              container = new Element(
                  'div',
                  {
                      id: 'main_error_message'
                  }
              ).addClassName('error_message').setStyle(
                  {
                      display: 'none'
                  }
              );

              var main = $('main_container');
              if (main.getElementsByTagName('h1').length > 0) {
                  $(main.getElementsByTagName('h1')[0]).insert({after: container});
              } else {
                  main.insert({top: container});
              }
          }
          container.update(message);

          if (container.style.display == 'none') {
              new Effect.Appear(container);
          } else {
              new Effect.Highlight(container, {startcolor: "#CC0000", endcolor: "#ffcccc"});
          }
      },
      hide: function() {
          var container = $('main_error_message');
          if (container != null) {
              container.hide();
          }
      }
  }
}

Glacier.Popup = {
    options: null,

    init: function(url, options) {
        var dim = this.getWindowDimensions();

        $(document.body).insert(
            new Element(
                'div',
                {
                    id: 'popup_overlay'   
                }
            ).addClassName('popup_overlay')
        );

        $(document.body).insert(
            new Element('div', {id: 'popup_container'}).addClassName('dialog').insert(
                new Element('div').addClassName('content').insert(
                    new Element('div').addClassName('t')
                ).insert(
                    new Element('a', {id: 'close_link', 'onclick': 'Glacier.Popup.close(); return false;', 'onmouseover': "$('popup_container').setOpacity(0.7);", 'onmouseout': "$('popup_container').setOpacity(1.0);"}).addClassName('close_link').update('x')        
                ).insert(
                    new Element('div').addClassName('clear').update('&nbsp;')        
                ).insert(
                    new Element('div', { id: 'popup_content' }).setStyle({ paddingTop: "12px" }).insert(
                        new Element(
                            'img',
                            {
                                src: '/images/layout/loading_45.gif',
                                width: 45,
                                height: 45,
                                border: 0,
                                alt: '...'
                            }
                        )
                    )
                )
            ).insert(
                new Element('div').addClassName('b').insert(new Element('div'))
            )
        );

        this.rearrange(45, false);

        this.update(url, options);
    },

    update: function(url, options) {
        if (options == null) options = {};

        options.width = options.width || 500;
        options.height = options.height || 300;
        options.params = options.params || '';
        options.method = options.method || 'get';
        options.evalScripts = options.evalScripts || true;

        this.options = options;

        new Ajax.Updater(
            'popup_content',
            url,
            {
                parameters: options.params,
                encoding: 'UTF-8',
                method: options.method,
                evalScripts: options.evalScripts,
                onComplete: function() { Glacier.Popup.rearrange(options.width) },
                onFailure: function(t) { Glacier.Utilities.Error.show(t.statusText); }
            }
        );
    },

    close: function() {
        try {
            $('popup_container').fade({
              duration: 0.5,
              afterFinish: function () { $('popup_container').remove(); }
            });
            $('popup_overlay').fade({
              duration: 0.3,
              afterFinish: function () { $('popup_overlay').remove(); }
            });
            this.options = null;
        } catch(e) {}
    },

    rearrange: function(width, showLink) {

        width = width || this.options.width;
        showLink = ((showLink == null) ? true : false);

        if (showLink) {
            $('close_link').show();
        } else {
            $('close_link').hide();
        }

        $('popup_content').setStyle({paddingTop: '12px', width: width+'px'});

        var container = $('popup_container');
        container.style.width = (width + 24)+'px';
        
        $('popup_container').setStyle({
          marginLeft: '-'+(Math.ceil(container.getWidth() / 2))+'px',
          top: document.viewport.getScrollOffsets().top + Math.ceil(document.viewport.getHeight() / 2)+'px',
          marginTop: '-'+(Math.ceil($('popup_container').getHeight() / 2))+'px'
        });
    },

    showError: function(message) {
        var div =  $('popup_error_message');
        if (div == null) {
            div = new Element('div', {id : 'popup_error_message'}).addClassName('popup_error_message');
            $('popup_content').insert({top: div});
        }
        div.update(message);
        div.show();
    },

    hideError: function() {
        try { $('popup_error_message').hide(); } catch(e) {}
    },

    getWindowDimensions: function(w) {
        var dim = {page: {}, window: {}, offset: {}};
        var temp = {};

        if (document.body.scrollHeight > document.body.offsetHeight){
            temp.xScroll = document.body.scrollWidth;
            temp.yScroll = document.body.scrollHeight;
        } else if (window.innerHeight && window.scrollMaxY) {
            temp.xScroll = document.body.scrollWidth;
            temp.yScroll = window.innerHeight + window.scrollMaxY;
        } else {
            temp.xScroll = document.body.offsetWidth;
            temp.yScroll = document.body.offsetHeight;
        }

        if (self.innerHeight) {
            dim.window.width = self.innerWidth;
            dim.window.height = self.innerHeight;
        } else if (document.documentElement && document.documentElement.clientHeight) {
            dim.window.width = document.documentElement.clientWidth;
            dim.window.height = document.documentElement.clientHeight;
        } else if (document.body) {
            dim.window.width = document.body.clientWidth;
            dim.window.height = document.body.clientHeight;
        }

        if (self.pageYOffset) {
            dim.offset.x = self.pageXOffset;
            dim.offset.y = self.pageYOffset;
        } else if (document.documentElement && document.documentElement.scrollTop){
            dim.offset.x = document.documentElement.scrollLeft;
            dim.offset.y = document.documentElement.scrollTop;
        } else if (document.body) {
            dim.offset.x = document.body.scrollLeft;
            dim.offset.y = document.body.scrollTop;
        }

        dim.page.height = (temp.yScroll < dim.window.height) ? dim.window.height : temp.yScroll;
        dim.page.width = (temp.xScroll < dim.window.width) ? dim.window.width : temp.xScroll;

        return dim;
    }

};