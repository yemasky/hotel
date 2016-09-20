<?php

/**
 * Created by PhpStorm.
 * User: CooC
 * Date: 2015/12/8
 * Time: 17:07
 */
namespace merchant;

class ModulesAuthorizeDao extends \BaseDao {
    public function getMerchantUserAuthorize($mu_id) {
        $fileid = 'ma_id, mu_id, mc_id, ma_field_authorize, ma_action_right';
        return \DBQuery::instance(\DbConfig::merchant_dsn)->setTable('modules_authorize')->getList(array('mu_id'=>$mu_id), $fileid);
    }

    public function getMerchantUserModules($arrayMc_id) {
        $fileid = 'mc_id, mc_father_id, mc_name, mc_module, mc_module_action, mc_module_action_field, mc_ico, mc_new';
        $conditions = 'mc_id in(' . implode(',', $arrayMc_id) .') AND mc_show = \'1\'';
        return \DBQuery::instance(\DbConfig::merchant_dsn)->setTable('modules_config')->getList($conditions, $fileid);
    }
}