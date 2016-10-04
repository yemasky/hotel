<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/23
 * Time: 19:17
 */

namespace hotel;


class HotelAction extends \BaseAction {
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
        $pn = empty($objRequest->pn) ? 1 : $objRequest->pn;
        $pn_rows = $objRequest->pn_rows;

        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('employee_id'=>$objResponse->arrayLoginEmployeeInfo['employee_id']);
        $parameters['module'] = encode(decode($objRequest->module));
        $arrayPageHotelId = EmployeeService::pageEmployeeHotel($conditions, $pn, $pn_rows, $parameters);

        $arrayHotel = null;
        if(!empty($arrayPageHotelId['list_data'])) {
            $stringHotelId = '';
            foreach($arrayPageHotelId['list_data'] as $k => $v) {
                $stringHotelId .= $v['hotel_id'] . ',';
            }
            $stringHotelId = trim($stringHotelId, ',');
            $conditions['where'] = array('IN'=>array('hotel_id'=>$stringHotelId));
            $arrayHotel = HotelService::getHotel($conditions);
            foreach ($arrayHotel as $k => $v) {
                //\BaseUrlUtil::Url(array('module'=>encode($arrayHotelModules[$i]['modules_id'])));
                $arrayHotel[$k]['edit_url'] = \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesHotel['edit']), 'hotel_id'=>encode($arrayHotel[$k]['hotel_id'])));
                $arrayHotel[$k]['delete_url'] = \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesHotel['delete']), 'hotel_id'=>encode($arrayHotel[$k]['hotel_id'])));;
            }
        }

        //赋值
        $objResponse -> setTplValue("addHotelUrl", \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesHotel['add']))));
        $objResponse -> setTplValue("arrayHotel", $arrayHotel);
        $objResponse -> setTplValue("page", $arrayPageHotelId['page']);
        $objResponse -> setTplValue("pn", $pn);
        //设置类别

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
        $hotel_id = decode($objRequest->hotel_id);
        $arrayPostValue= $objRequest->getPost();
        if(!empty($arrayPostValue) && is_array($arrayPostValue) && $hotel_id > 0) {
            HotelService::updateHotel(array('hotel_id'=>$hotel_id), $arrayPostValue);
        }

        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('hotel_id'=>$hotel_id);
        $arrayHotel = HotelService::getHotel($conditions);
        //赋值
        $objResponse->view = 0;
        $objResponse -> setTplValue("arrayDataInfo", $arrayHotel[0]);
        $objResponse -> setTplValue("location_province", $arrayHotel[0]['hotel_province']);
        $objResponse -> setTplValue("location_city", $arrayHotel[0]['hotel_city']);
        $objResponse -> setTplValue("location_town", $arrayHotel[0]['hotel_town']);
        $objResponse -> setTplValue("hotel_update_url", \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesHotel['edit']), 'hotel_id'=>encode($hotel_id))));
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
    }

    protected function doAdd($objRequest, $objResponse) {
        $arrayPostValue= $objRequest->getPost();
        if(!empty($arrayPostValue) && is_array($arrayPostValue)) {
            $arrayPostValue['hotel_add_date'] = date("Y-m-d");
            $arrayPostValue['hotel_add_time'] = getTime();
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
        $conditions['where'] = array('hotel_id'=>0);
        $arrayHotel = HotelService::instance('\hotel\HotelService')->DBcache(ModulesConfig::$modulesHotelCacheKey['hotel_default_id'])->getHotel($conditions);
        //赋值
        $objResponse -> setTplValue("arrayDataInfo", $arrayHotel[0]);
        $objResponse -> setTplValue("hotel_update_url", \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesHotel['add']))));
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
        //更改tpl
    }
}