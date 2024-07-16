<?php
require 'includes/models.php';

 = ['sessionId'];
 = ['serviceCode'];
 = ['phoneNumber'];
 = ['text'];

 = '';

if ( == '') {
     = 'CON Welcome to the Voting System. Please enter your PIN:';
} else {
     = getVoter();
    if () {
        if ( == ['pin']) {
             = 'CON Please select a candidate:\\n';
             = getCandidates();
            foreach ( as ) {
                 .= ['id'] . '. ' . ['name'] . '\\n';
            }
        } else {
             = 'END Invalid PIN. Please try again.';
        }
    } else {
         = 'END You are not registered.';
    }
}

header('Content-type: text/plain');
echo ;
?>
