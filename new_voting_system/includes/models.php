<?php
require 'db.php';

function getVoter(\) {
    global \;
    \ = \->prepare('SELECT * FROM voters WHERE phone_number = :phone_number');
    \->execute(['phone_number' => \]);
    return \->fetch(PDO::FETCH_ASSOC);
}

function createVoter(\, \, \) {
    global \;
    \ = \->prepare('INSERT INTO voters (phone_number, name, pin) VALUES (:phone_number, :name, :pin)');
    return \->execute(['phone_number' => \, 'name' => \, 'pin' => \]);
}

function getCandidates() {
    global \;
    \ = \->query('SELECT * FROM candidates');
    return \->fetchAll(PDO::FETCH_ASSOC);
}

function createVote(\, \, \) {
    global \;
    \ = \->prepare('INSERT INTO votes (voter_id, candidate_id, position) VALUES (:voter_id, :candidate_id, :position)');
    return \->execute(['voter_id' => \, 'candidate_id' => \, 'position' => \]);
}

function getVotes() {
    global \;
    \ = \->query('SELECT * FROM votes');
    return \->fetchAll(PDO::FETCH_ASSOC);
}
?>
