<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/23
 * Time: 19:17
 */

namespace hotel;


class CompanyAction extends \BaseAction {
    protected function check($objRequest, $objResponse) {
        $objResponse -> navigation = 'hotelSetting';
        $objResponse -> setTplValue('navigation', 'hotelSetting');
    }

    protected function service($objRequest, $objResponse) {
        switch($objRequest->getAction()) {
            default:
                $this->doDefault($objRequest, $objResponse);
                break;
        }
    }

    /**
     * 首页显示
     */
    protected function doDefault($objRequest, $objResponse) {
        //$pn = empty($objRequest->pn) ? 1 : $objRequest->pn;
        $arrayCompanyId = EmployeeService::getEmployeeCompany($objResponse->arrayLoginEmployeeInfo['employee_id']);
        $conditions = \DbConfig::$db_query_conditions;
        $arrayCompany = null;
        if(!empty($arrayCompanyId)) {
            $stringCompanyId = '';
            foreach($arrayCompanyId as $k => $v) {
                $stringCompanyId .= $v['company_id'] . ',';
            }
            $stringCompanyId = trim($stringCompanyId, ',');
            $conditions['where'] = array('IN'=>array('company_id'=>$stringCompanyId));
            $arrayCompany = CompanyService::getCompany($conditions);
        }

        //设置类别

        //赋值
        $objResponse -> setTplValue("arrayCompany", $arrayCompany);
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
    }
}