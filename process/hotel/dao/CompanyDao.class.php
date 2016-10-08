<?php

/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2015/12/6
 * Time: 16:56
 */
namespace hotel;
class CompanyDao extends \BaseDao {
    protected $table = 'company';
    protected $table_key = 'company_id';

    public function getDsnRead() {
        // TODO: Implement getDsnRead() method.
        return DbConfig::dsnRead();
    }

    public function getDsnWrite() {
        // TODO: Implement getDsnWrite() method.
        return DbConfig::dsnWrite();
    }

    public function getCompany($conditions, $hashKey = null){
        $cacheId = md5('getCompany' . json_encode($conditions) . $hashKey);
        $fileid = 'company_id, company_group, company_name, company_address, company_mobile, company_phone, company_fax, company_email, company_introduction, company_longitude, '
                 .'company_latitude, company_country, company_province, company_city, company_town, company_add_date, company_add_time';
        return $this->setDsnRead($this->getDsnRead())->setTable($this->table)->getList($conditions, $fileid, $hashKey);//->DBCache($cacheId)
    }
}