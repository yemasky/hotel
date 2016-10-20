<?php

/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2015/12/6
 * Time: 17:00
 */
namespace hotel;

class ModulesConfig extends \ModulesConfig {
	public static $modulesConfig = array(
	    'company'        => array('edit'=>24, 'delete'=>25, 'add'=>28),
	    'hotel'          => array('edit'=>26, 'delete'=>27, 'add'=>29, 'view'=>16, 'saveAttrValue'=>46,
                                  'upload_type'=>'hotel'),
        'hotelAttribute' => array('edit'=>00, 'delete'=>45, 'add'=>44),
        'roomsSetting'   => array('edit'=>34, 'delete'=>35, 'add'=>32, 'view'=>18,
                                  'room_type'=>array('room'=>1,'office'=>0,'store'=>0,'varia'=>0,'dining'=>0,'restaurant'=>1)),
        'roomsAttribute' => array('edit'=>000,'delete'=>43, 'add'=>33, 'view'=>19),
        'roomsLayout'    => array('edit'=>38, 'delete'=>39, 'add'=>37, 'view'=>36, 'saveAttrValue'=>41,
                                  'orientations'=>array('east','south','west','north','southeast','northeast','southwest','northwest'),
                                  'upload_type'=>'rooms_layout'),
        'upload'         => array('uploadImages'=>42),
        'book'    => array('edit'=>50, 'delete'=>51, 'add'=>49, 'view'=>48),
    );

    public static $cacheKey = array(
        'company' => array('company_default_id'=>'company_default_id_'),
	    'hotel'   => array('hotel_default_id'=>'hotel_default_id_','hotel_attribute'=>'hotel_attribute_',
                           'room_attribute'=>'room_attribute_')
    );

    public static $idCardType = array('id_card', 'passport', 'certificate_officers', 'other');

}