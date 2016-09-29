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
    protected $dsn_read = \DbConfig::hotel_dsn_read;
    protected $dsn_write = \DbConfig::hotel_dsn_write;
    protected $table_key = 'company_id';

    public function getCompany($conditions, $hashKey = null){
        $cacheId = md5('getCompany' . json_encode($conditions) . $hashKey);
        $fileid = 'company_id, company_group, company_name, company_address, company_mobile, company_phone, company_fax, company_email, company_introduction, company_longitude, '
                 .'company_latitude, company_country, company_province, company_city, company_town, company_add_date, company_add_time';
        return $this->setDsnRead($this->dsn_read)->setTable($this->table)->getList($conditions, $fileid, $hashKey);//->DBCache($cacheId)
    }
}