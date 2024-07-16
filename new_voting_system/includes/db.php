<?php
\ = 'sqlite:/var/www/new_voting_system/new_voting_system.db';
try {
    \ = new PDO(\);
    \->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException \) {
    die('Connection failed: ' . \->getMessage());
}
?>
