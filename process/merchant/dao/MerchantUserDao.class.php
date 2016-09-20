<?php

/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2015/12/6
 * Time: 16:56
 */
namespace merchant;
class MerchantUserDao extends \BaseDao {

	public function getLoginUser($arrayLoginInfo){
		return \DBQuery::instance(\DbConfig::merchant_dsn)->setTable('merchant_user')->getRow($arrayLoginInfo, 'mu_id, m_id, mu_nickname');
	}
}