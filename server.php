<?php
define('MAX_USER_COUNT', 100);
define("DATA_DIR", __DIR__);

if (!is_dir(DATA_DIR)) {
    die("no data dir");
}

if ($_SERVER['REQUEST_METHOD'] == "POST") {

    $user_count = countFolder(DATA_DIR);

    $body = file_get_contents("php://input");
    // var_dump($body);
    $lines = preg_split("/\t/", $body);
    if (count($lines) < 4) {
        die("not enough lines");
    }

    $date = date('c');
    $to = $lines[1];
    // var_dump($to);
    if (!good_id($to)) {
        die("name not good format");
    }

    //$from=array_shift($lines);
    //$digest=array_shift($lines);
    //$sign=array_shift($lines);

    $file = DATA_DIR . "/$to";
    if (!is_file($file)) {
        if ($user_count >= MAX_USER_COUNT) {
            die("too many users");
        }

        touch($file);
    }
    $f = fopen($file, "a");
    fwrite($f, "$date\t$body\n");
    fclose($f);
    echo "OK";
}

function good_id($id)
{
    return preg_match('/^[-\da-z]/', $id);
}
function countFolder($dir)
{
    return (count(scandir($dir)) - 2);
}
