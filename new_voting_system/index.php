<?php
\ = parse_url(\['REQUEST_URI'], PHP_URL_PATH);

if (\ == '/register') {
    require 'views/register.php';
} elseif (\ == '/vote') {
    require 'views/vote.php';
} elseif (\ == '/results') {
    require 'views/results.php';
} elseif (\ == '/ussd') {
    require 'views/ussd.php';
} else {
    echo '404 Not Found';
}
?>
