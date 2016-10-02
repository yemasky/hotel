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
            case 'edit':
                $this->doEdit($objRequest, $objResponse);
                break;
            case 'add':
                $this->doAdd($objRequest, $objResponse);
                break;
            case 'delete':
                $this->doDelete($objRequest, $objResponse);
                break;
            default:
                $this->doDefault($objRequest, $objResponse);
                break;
        }
    }

    /**
     * 首页显示
     */
    protected function doDefault($objRequest, $objResponse) {
        if(decode($objRequest->company_id) > 0) {
            $this->view($objRequest, $objResponse);
            return;
        }
        $pn = empty($objRequest->pn) ? 1 : $objRequest->pn;
        $pn_rows = $objRequest->pn_rows;

        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('employee_id'=>$objResponse->arrayLoginEmployeeInfo['employee_id']);
        $parameters['module'] = encode(decode($objRequest->module));
        $arrayPageCompanyId = EmployeeService::pageEmployeeCompany($conditions, $pn, $pn_rows, $parameters);

        $arrayCompany = null;
        if(!empty($arrayPageCompanyId['list_data'])) {
            $stringCompanyId = '';
            foreach($arrayPageCompanyId['list_data'] as $k => $v) {
                $stringCompanyId .= $v['company_id'] . "','";
            }
            $stringCompanyId = trim($stringCompanyId, ",'");
            $conditions['where'] = array('IN'=>array('company_id'=>$stringCompanyId));
            $arrayCompany = CompanyService::getCompany($conditions);
            foreach ($arrayCompany as $k => $v) {
                //\BaseUrlUtil::Url(array('module'=>encode($arrayHotelModules[$i]['modules_id'])));
                $arrayCompany[$k]['view_url'] = \BaseUrlUtil::Url(array('module'=>encode(decode($objRequest->module)), 'company_id'=>encode($arrayCompany[$k]['company_id'])));
                $arrayCompany[$k]['edit_url'] = \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesCompany['edit']), 'company_id'=>encode($arrayCompany[$k]['company_id'])));
                $arrayCompany[$k]['delete_url'] = \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesCompany['delete']), 'company_id'=>encode($arrayCompany[$k]['company_id'])));
            }
        }
        //设置类别
        //赋值
        $objResponse -> setTplValue("addCompanyPermission", $objResponse->arrayRoleModulesEmployeePermissions[ModulesConfig::$modulesCompany['add']]);
        $objResponse -> setTplValue("addCompanyUrl", \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesCompany['add']))));
        $objResponse -> setTplValue("arrayCompany", $arrayCompany);
        $objResponse -> setTplValue("page", $arrayPageCompanyId['page']);
        $objResponse -> setTplValue("pn", $pn);
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
    }

    protected function view($objRequest, $objResponse) {
        $this->doEdit($objRequest, $objResponse);
        $objResponse->view = 1;
        $objResponse->setTplName("hotel/modules_company_edit");
    }

    protected function doDelete($objRequest, $objResponse) {
        $this->setDisplay();
        $company_id = decode($objRequest->company_id);
        if(empty($company_id)) {
            return $this->errorResponse('操作失败，公司ID不正确！');
        }
        CompanyService::updateCompany(array('company_id'=>$company_id), array('company_is_delet'=>true));
        return $this->successResponse('删除公司成功');
    }

    protected function doEdit($objRequest, $objResponse) {
        $company_id = decode($objRequest->company_id);
        $arrayPostValue= $objRequest->getPost();
        if(!empty($arrayPostValue) && is_array($arrayPostValue) && $company_id > 0) {
            CompanyService::updateCompany(array('company_id'=>$company_id), $arrayPostValue);
        }

        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('company_id'=>$company_id);
        $arrayCompany = CompanyService::getCompany($conditions);
        //赋值
        $objResponse->view = 0;
        $objResponse -> setTplValue("arrayCompany", $arrayCompany[0]);
        $objResponse -> setTplValue("location_province", $arrayCompany[0]['company_province']);
        $objResponse -> setTplValue("location_city", $arrayCompany[0]['company_city']);
        $objResponse -> setTplValue("location_town", $arrayCompany[0]['company_town']);
        $objResponse -> setTplValue("company_update_url", \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesCompany['edit']), 'company_id'=>encode($company_id))));
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
    }

    protected function doAdd($objRequest, $objResponse) {
        $arrayPostValue= $objRequest->getPost();
        if(!empty($arrayPostValue) && is_array($arrayPostValue)) {
            $arrayPostValue['company_add_date'] = date("Y-m-d");
            $arrayPostValue['company_add_time'] = getTime();
            $company_id = CompanyService::saveCompany($arrayPostValue);
            if($company_id > 0) {
                EmployeeService::saveEmployeeDepartment(array('company_id'=>$company_id, 'employee_id'=>$objResponse->arrayLoginEmployeeInfo['employee_id']));
                //CompanyService::updateCompany(array('company_id'=>$company_id), array(''));
            } else {
                throw new \Exception('添加失败！');
            }
            $url = 'index.php?action=excute_success&success_id=' . encode($company_id);
            redirect($url);
        }

        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('company_id'=>0);
        $arrayCompany = CompanyService::instance('\hotel\CompanyService')->DBcache(ModulesConfig::$modulesCompanyCacheKey['company_default_id'])->getCompany($conditions);
        //赋值
        $objResponse -> setTplValue("arrayCompany", $arrayCompany[0]);
        $objResponse -> setTplValue("company_update_url", \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesCompany['add']))));
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
        //更改tpl
    }
}