// util for the test app
//
//
var $notification,
    $notification__wrap,
    init;

var notification = function(message)
{
    var initFirst = function() {
        $notification = $notification || $('.notification');
        $notification__wrap = $notification__wrap || $('.notification__wrap');
        $notification.on('click', hide);
        return true;
    }

    var hide = function(e) {
        e && e.stopPropagation();
        $notification__wrap.addClass('notification__wrap--hiding');
        setTimeout(function(){
            $notification.text('');
            $notification__wrap.addClass('notification__wrap--hidden');
            $notification__wrap.removeClass('notification__wrap--hiding');
        }, 1500);
    }

    init = init || initFirst();

    $notification.text(message);
    $notification__wrap.removeClass('notification__wrap--hidden');
    setTimeout(function() {
        hide()
    }, 3000);
}
