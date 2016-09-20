<?php

/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2015/12/6
 * Time: 16:56
 */
namespace merchant;
class MerchantDao extends \BaseDao {

	public function getMerchant($conditions, $fileid = NULL) {
		if(empty($fileid)) {
			$fileid = 'm_id, m_name, m_mobile, m_phone, m_country_id, m_state_id, m_city_id, m_county_id, m_address, m_rate_tourism, m_rate_hotel, m_rate_air ticket, m_update_date, m_add_date';
		}
		return \DBQuery::instance(\DbConfig::merchant_dsn)->setTable('merchant')->setKey('m_id')->order($conditions['order'])->limit($conditions['limit'])->getList($conditions['where'], $fileid);
	}

	public function getMerchantRate($m_id) {
		$conditions = \DbConfig::$db_query_conditions;
		$conditions['where']['m_id'] = $m_id;
		$fileid = 'm_rate_tourism, m_rate_hotel, m_rate_air_ticket, m_rate_tourism_sell, m_rate_hotel_sell, m_rate_air_ticket_sell';
		$arrayRates = $this->DBCache(0)->getMerchant($conditions, $fileid);
		return $arrayRates;
	}
}