<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/23
 * Time: 19:17
 */

namespace hotel;


class RoomLayoutPriceAction extends \BaseAction {
    protected function check($objRequest, $objResponse) {
        $objResponse -> back_lis_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomLayoutPrice']['view'])));
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
            case 'editSystem':
                $this->doEditRoomLayoutPriceSystem($objRequest, $objResponse);
                break;
            default:
                $this->doDefault($objRequest, $objResponse);
                break;
        }
    }

    protected function tryexecute($objRequest, $objResponse) {
        RoomService::instance()->rollback();//事务回滚
    }
    /**
     * 首页显示
     */
    protected function doDefault($objRequest, $objResponse) {
        $arrayRoomLayoutPriceList = RoomOperateService::instance()->getRoomLayoutPriceList($objRequest, $objResponse);
        //赋值
        $objResponse -> arrayRoomLayoutPriceList = $arrayRoomLayoutPriceList;
        $objResponse -> thisYear = getYear();
        $objResponse -> nextYear = $objResponse -> thisYear + 1;
        $objResponse -> thisMonth = getMonth();

        $objResponse -> add_roomLayoutPriceSystem_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomLayoutPrice']['add'])));
        $objResponse -> search_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomLayoutPrice']['view'])));
        //
        //设置类别
    }

    protected function doAdd($objRequest, $objResponse) {
        $conditions = DbConfig::$db_query_conditions;
        if($objRequest -> search == 'hotel_service') {
            $this->setDisplay();
            $conditions['where'] = array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id']);
            $conditions['order'] = 'hotel_service_father_id ASC';
            $field = 'hotel_service_id, hotel_service_father_id, hotel_service_name, hotel_service_price';
            $arrayHotelService = HotelService::instance()->getHotelService($conditions, $field);
            return $this->successResponse("", $arrayHotelService);
        }
        if($objRequest -> search == 'systemPrices' && ($objRequest->room_layout_id) > 0) {
            $this->setDisplay();
            $conditions['where'] = array('IN'=>array('rlps.room_layout_id'=>array($objRequest->room_layout_id, 0),
                                                     'rlps.hotel_id'=>array('0',$objResponse->arrayLoginEmployeeInfo['hotel_id'])),
                                         '>'=>array('rlps.room_layout_price_system_id'=>1),
                                         'rlps.room_layout_price_system_valid'=>'1');
            $arrayRoomLayoutPriceSystem = RoomService::instance()->getRoomLayoutPriceSystemFilter($conditions);
            return $this->successResponse("", $arrayRoomLayoutPriceSystem);
        }
        if($objRequest -> search == 'prices_week') {
            $this->setDisplay();
            return $this->setPricesWeek($objRequest, $objResponse);
        }
        if($objRequest -> search == 'prices_month') {
            $this->setDisplay();
            return $this->setPricesMonth($objRequest, $objResponse);
        }
        if($objRequest -> search == 'historyPrice') {
            $this->setDisplay();
            return $this->getHistoryPrice($objRequest, $objResponse);
        }
        if($objRequest -> search == 'historyprice') {
            $this->setDisplay();
            return $this->getHistoryPrice($objRequest, $objResponse);
        }
        $this->doEdit($objRequest, $objResponse);
        //
        $objResponse -> add_roomLayoutPriceSystem_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomLayoutPrice']['add'])));
        $objResponse->view = 'add';
        //更改tpl
    }

    protected function doEdit($objRequest, $objResponse) {
        $conditions = DbConfig::$db_query_conditions;
        //售卖房型
        $conditions['where'] = array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id'],
                                     'room_layout_valid'=>'1');
        $arrayRoomLayout = RoomService::instance()->getRoomLayout($conditions);
        $conditions['where'] = array();
        if(!empty($arrayRoomLayout) && isset($arrayRoomLayout[0]['room_layout_id'])) {
            $conditions['where'] = array('IN'=>array('rlps.room_layout_id'=>array($arrayRoomLayout[0]['room_layout_id'], 0),
                                                     'rlps.hotel_id'=>array('0',$objResponse->arrayLoginEmployeeInfo['hotel_id'])));
        } else {
            $conditions['where'] = array('IN'=>array('rlps.room_layout_id'=>array(0),
                'rlps.hotel_id'=>array('0',$objResponse->arrayLoginEmployeeInfo['hotel_id'])));
        }
        //价格体系
        $conditions['where'] = array_merge($conditions['where'], array('>'=>array('rlps.room_layout_price_system_id'=>0),
            'rlps.room_layout_price_system_valid'=>'1'));
        //$arrayRoomLayoutPriceSystem = RoomService::instance()->getRoomLayoutPriceSystemFilter($conditions);
        //

        //赋值
        $objResponse -> thisDay = getDay();
        $objResponse -> thisToday = getToDay();
        $objResponse -> toDay = getDay(24*6);
        $objResponse -> thisYear = getYear();
        $objResponse -> nextYear = $objResponse -> thisYear + 1;
        $objResponse -> thisMonth = getMonth();
        $objResponse -> view = '0';
            //售卖房型
        $objResponse -> arrayRoomLayout = $arrayRoomLayout;
            //价格体系
        $objResponse -> arrayRoomLayoutPriceSystem = array();//$arrayRoomLayoutPriceSystem;
        //
        $objResponse -> add_roomLayoutPriceSystem_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomLayoutPrice']['add'])));
        $objResponse -> editSystem_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomLayoutPrice']['editSystem'])));
        //
        $objResponse -> setTplName("hotel/modules_roomLayoutPrice_edit");
    }

    protected function doDelete($objRequest, $objResponse) {
        $this->setDisplay();
    }

    protected function doEditRoomLayoutPriceSystem($objRequest, $objResponse) {
        $this->setDisplay();
        $arrayPostValue= $objRequest->getPost();
        $room_layout_price_system_id = RoomService::instance()->saveRoomLayoutPriceSystemAndFilter($arrayPostValue, $objResponse->arrayLoginEmployeeInfo['hotel_id']);
        return $this->successResponse("添加/修改价格体系成功！", $room_layout_price_system_id);
    }

    protected function setPricesWeek($objRequest, $objResponse) {
        $this->setDisplay();
        $arrayResult = RoomOperateService::instance()->saveRoomLayoutPriceWeek($objRequest, $objResponse);
        if($arrayResult[0] == 0) return $this->errorResponse($arrayResult[1]);
        return $this->successResponse($arrayResult[1]);
    }

    protected function setPricesMonth($objRequest, $objResponse) {
        $this->setDisplay();
        $arrayResult = RoomOperateService::instance()->saveRoomLayoutPriceMonth($objRequest, $objResponse);
        if($arrayResult[0] == 0) return $this->errorResponse($arrayResult[1]);
        return $this->successResponse($arrayResult[1]);
    }

    protected function getHistoryPrice($objRequest, $objResponse) {
        $this->setDisplay();
        $year = $objRequest->year;
        $month = $objRequest->month;
        $history_begin = $objRequest->history_begin;
        $history_end = $objRequest->history_end;
        $system_id = $objRequest->system_id;
        $room_layout_id = $objRequest->room_layout;
        $conditions = DbConfig::$db_query_conditions;
        if(!empty($year) && !empty($month)) {
            $conditions['where'] = array('room_layout_date_year'=>$year, 'room_layout_date_month'=>$month, 'room_layout_id'=>$room_layout_id,
                'room_layout_price_system_id'=>$system_id);
        } elseif(!empty($history_begin) && !empty($history_end)) {
            $arrayBegin = explode('-', $history_begin);
            $arrayEnd = explode('-', $history_end);
            if(strtotime($history_end) < strtotime($history_begin)) {
                return $this->errorResponse('时间选择不正确！');
            }
            if(($arrayEnd[0] - $arrayBegin[0]) > 1) {
                return $this->errorResponse('跨度不能超过2年！');
            }
            $conditions['where'] = array('>='=>array('room_layout_price_begin_datetime'=>$arrayBegin[0] . '-' . $arrayBegin[1] . '-01'),
                                         '<='=>array('room_layout_price_begin_datetime'=>$arrayEnd[0] . '-' . $arrayEnd[1] . '-01'),
                                         'room_layout_id'=>$room_layout_id,
                                         'room_layout_price_system_id'=>$system_id);
        }

        $field = 'room_layout_date_year,room_layout_date_month,';
        for($i = 1; $i <= 31; $i++) {
            $l = $i < 10 ? '0' . $i : $i;
            $field .= $l . '_day,';
        }
        $field = trim($field, ',');
        $arraySystemPrice = RoomService::instance()->getRoomLayoutPrice($conditions, $field);
        $arrayExtraBedPrice = RoomService::instance()->getRoomLayoutExtraBedPrice($conditions, $field);
        return $this->successResponse('', array('room_price'=>$arraySystemPrice, 'extra_bed_price'=>$arrayExtraBedPrice));
    }
}