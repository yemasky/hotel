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
	    'hotel'          => array('edit'=>26, 'delete'=>27, 'add'=>29),
        'roomsSetting'   => array('edit'=>34, 'delete'=>35, 'add'=>32, 'view'=>18,
                                  'room_type'=>array('room','office','store','varia','dining','restaurant')),
        'roomsAttribute' => array('edit'=>000, 'delete'=>000, 'add'=>33)
    );

    public static $cacheKey = array(
        'company' => array('company_default_id'=>'company_default_id_'),
	    'hotel'   => array('hotel_default_id'=>'hotel_default_id_','hotel_attribute'=>'hotel_attribute_',
                           'room_attribute'=>'room_attribute_')
    );

}