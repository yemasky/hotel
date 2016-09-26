<?php

/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2015/12/6
 * Time: 16:56
 */
namespace hotel;
class LaguageDao extends \BaseDao {

    public function getPageModuleLaguage($conditions){
        $cacheId = md5('getPageModuleLaguage' . json_encode($conditions));
        $fileid = 'laguage, page_module, page_laguage_key, page_laguage_value';
        return $this->setDsnRead(\DbConfig::hotel_dsn_read)->setTable('multi_laguage_page')->getList($conditions, $fileid, 'page_laguage_key');//->DBCache($cacheId)
    }
}