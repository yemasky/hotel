<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/24
 * Time: 0:04
 */
namespace hotel;
class CommonService extends \BaseService {
    public static function getRoleMenu($employee_id) {
        $arrayUserModels = NULL;
        $arrayAuthorize = self::getEmployeeRole($employee_id);
        if(!empty($arrayAuthorize)) {
            $arrayMc_id = array();
            foreach($arrayAuthorize as $k => $v) {
                $arrayMc_id[] = $v['mc_id'];
            }
            $objModulesAuthorizeDao = new ModulesAuthorizeDao();
            $arrayUserModels = $objModulesAuthorizeDao->DBCache(1800)->getMerchantUserModules($arrayMc_id);
        }
        return $arrayUserModels;
    }


}