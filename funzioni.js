$(document).ready(function () {
    $('.toggle-btn').click(function () {
        var targetClass = $(this).data('target');
        $('.' + targetClass).toggle();
    });
});
