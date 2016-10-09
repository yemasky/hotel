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
        if(decode($objRequest->hotel_id) > 0) {
            $this->view($objRequest, $objResponse);
            return;
        }
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
                $stringHotelId .= $v['hotel_id'] . "','";
            }
            $stringHotelId = trim($stringHotelId, ",'");
            $conditions['where'] = array('IN'=>array('hotel_id'=>$stringHotelId));
            $arrayHotel = HotelService::getHotel($conditions);
            foreach ($arrayHotel as $k => $v) {
                //\BaseUrlUtil::Url(array('module'=>encode($arrayHotelModules[$i]['modules_id'])));
                $arrayHotel[$k]['view_url'] = \BaseUrlUtil::Url(array('module'=>encode(decode($objRequest->module)), 'hotel_id'=>encode($arrayHotel[$k]['hotel_id'])));
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

    protected function doAdd($objRequest, $objResponse) {
        $arrayPostValue= $objRequest->getPost();
        $hotel_id = 0;
        if(!empty($arrayPostValue) && is_array($arrayPostValue)) {
            $arrayPostValue['hotel_add_date'] = date("Y-m-d");
            $arrayPostValue['hotel_add_time'] = getTime();
            $hotel_id = HotelService::saveHotel($arrayPostValue);
            if($hotel_id > 0) {
                //EmployeeService::saveEmployeeDepartment(array('company_id'=>$hotel_id, 'employee_id'=>$objResponse->arrayLoginEmployeeInfo['employee_id']));
                //CompanyService::updateCompany(array('company_id'=>$company_id), array(''));
            } else {
                throw new \Exception('添加失败！');
            }
            //$url = 'index.php?action=excute_success&success_id=' . encode($hotel_id);
            //redirect($url);
            if(empty($hotel_id)) {
                return $this->errorResponse('保存失败，请检查数据！');
            }
            $this->setDisplay();
            //$hotel_id = encode($hotel_id);
            //HotelService::updateHotel(array('hotel_id'=>$hotel_id), array('hotel_is_delet'=>true));
            return $this->successResponse('保存酒店成功');

        }

        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('hotel_id'=>0);
        $arrayHotel = HotelService::instance('\hotel\HotelService')->DBcache(ModulesConfig::$modulesHotelCacheKey['hotel_default_id'])->getHotel($conditions);

        $conditions['where'] = array('employee_id'=>$objResponse->arrayLoginEmployeeInfo['employee_id']);
        $arrayEmployeeCompany = EmployeeService::getEmployeeCompany($conditions);
        $arrayCompany = null;
        if(!empty($arrayEmployeeCompany)) {
            $stringCompanyId = '';
            foreach($arrayEmployeeCompany as $k => $v) {
                $stringCompanyId .= $v['company_id'] . "','";
            }
            $stringCompanyId = trim($stringCompanyId, ",'");
            $conditions['where'] = array('IN'=>array('company_id'=>$stringCompanyId));
            $arrayCompany = CompanyService::getCompany($conditions);
        }
        //赋值
        $objResponse -> update_success = 0;
        $objResponse -> setTplValue("arrayAttribute", HotelService::getAttribute($hotel_id));
        $objResponse -> setTplValue("arrayEmployeeCompany", $arrayCompany);
        $objResponse -> setTplValue("arrayDataInfo", $arrayHotel[0]);
        $objResponse -> setTplValue("hotel_update_url", \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesHotel['add']))));
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
        //更改tpl
    }

    protected function view($objRequest, $objResponse) {
        $this->doEdit($objRequest, $objResponse);
        $objResponse->view = 1;
        $objResponse->setTplName("hotel/modules_hotel_edit");
    }

    protected function doEdit($objRequest, $objResponse) {
        $hotel_id = decode($objRequest->hotel_id);
        $arrayPostValue= $objRequest->getPost();

        $objResponse->update_success = 0;
        if(!empty($arrayPostValue) && is_array($arrayPostValue) && $hotel_id > 0) {
            HotelService::updateHotel(array('hotel_id'=>$hotel_id), $arrayPostValue);
            $objResponse->update_success = 1;
        }

        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('hotel_id'=>$hotel_id);
        $arrayHotel = HotelService::getHotel($conditions);

        $conditions['where'] = array('employee_id'=>$objResponse->arrayLoginEmployeeInfo['employee_id']);
        $arrayEmployeeCompany = EmployeeService::getEmployeeCompany($conditions);
        $arrayCompany = null;

        if(!empty($arrayEmployeeCompany)) {
            $stringCompanyId = '';
            foreach($arrayEmployeeCompany as $k => $v) {
                $stringCompanyId .= $v['company_id'] . "','";
            }
            $stringCompanyId = trim($stringCompanyId, ",'");
            $conditions['where'] = array('IN'=>array('company_id'=>$stringCompanyId));
            $arrayCompany = CompanyService::getCompany($conditions);
        }
        //赋值
        $objResponse->view = 0;
        $objResponse -> setTplValue("arrayAttribute", HotelService::getAttribute($hotel_id));
        $objResponse -> setTplValue("arrayDataInfo", $arrayHotel[0]);
        $objResponse -> setTplValue("location_province", $arrayHotel[0]['hotel_province']);
        $objResponse -> setTplValue("location_city", $arrayHotel[0]['hotel_city']);
        $objResponse -> setTplValue("location_town", $arrayHotel[0]['hotel_town']);
        $objResponse -> setTplValue("hotel_update_url", \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesHotel['edit']), 'hotel_id'=>encode($hotel_id))));
        $objResponse -> setTplValue("arrayEmployeeCompany", $arrayCompany);

        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
    }

    protected function doDelete($objRequest, $objResponse) {
        $this->setDisplay();
        $hotel_id = decode($objRequest->hotel_id);
        if(empty($hotel_id)) {
            return $this->errorResponse('操作失败，酒店ID不正确！');
        }
        HotelService::updateHotel(array('hotel_id'=>$hotel_id), array('hotel_is_delet'=>true));
        return $this->successResponse('删除酒店成功');
    }

}