<?php
ini_set("display_errors", 1);
require_once '../vendor/autoload.php';

$imagine = new Imagine\Gd\Imagine();

$palette = new Imagine\Image\Palette\RGB();
$size  = new Imagine\Image\Box(32, 10);
$color_black = $palette->color('#000');
$font = new Imagine\Gd\Font('./fonts/Roboto-Regular.ttf', 8, $color_black);


$postalCodes = array(
    '08001',
    '08002',
    '08003',
    '08004',
    '08005',
    '08006',
    '08007',
    '08008',
    '08009',
    '08010'
);

for($i=0; $i<count($postalCodes); $i++) {
    $image = $imagine->create($size, $color_black);
    $image->draw()
        ->text($postalCodes[$i], $font, new Imagine\Image\Point(1,1));

    $image->save('./images/' . $postalCodes[$i] . '.png');
}

print "done!";
