<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/23
 * Time: 19:17
 */

namespace hotel;


class BookAction extends \BaseAction {
    protected function check($objRequest, $objResponse) {
        $weekarray = array("日","一","二","三","四","五","六");
        $objResponse -> today = getDay() . " 星期".$weekarray[date("w")];
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
        $objResponse -> add_book_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['book']['add'])));
        //
    }

    protected function view($objRequest, $objResponse) {
        $this->doEdit($objRequest, $objResponse);
        $objResponse->view = '1';
        $objResponse->setTplName("hotel/modules_book_edit");
    }

    protected function doAdd($objRequest, $objResponse) {
        $conditions = DbConfig::$db_query_conditions;
        if($objRequest -> search == 'searchRoomLayout') {
            $this -> setDisplay();
            $arrayBookRoomLayout = $this->searchISBookRoomLayout($objRequest, $objResponse);
            $tableHr = '';
            if(!empty($arrayBookRoomLayout)) {
                foreach($arrayBookRoomLayout as $k => $v) {
                    /*$tableHr .= '<tr class="gradeX"><td class="details-control"><span class="span3">' . $v['room_layout_name'] . '</span>'
                             .'<select class="span2 room_layout_num" id="room_layout_id_'. $v['room_layout_id'] .'" '
                             .'layout="'. $v['room_layout_id'] .'" >';
                             for($i = 0; $i <= $v['room_layout_num'] ; $i++) {
                                 $tableHr .= '<option value="'.$i.'">'.$i.'</option>';
                             }
                    $tableHr .= '</select> <a href="#room" class="select_room">'.$objResponse->arrayLaguage['room']['page_laguage_value'].' <i class="am-icon-search am-blue-16A2EF"></i></a>';

                    $tableHr .= '</td>'
                             .'<td><input type="text" class="span2 book_price" id="book_price_'. $v['room_layout_id'] .'" value="' . $v['room_layout_price']
                             . '"  /><span class="hide">' . $v['room_layout_price'] . '</span>';
                    $tableHr .='</td>'
                             .'<td>';
                    //if($v['room_layout_extra_bed'] > 0) {
                    $tableHr .= '<select class="span2 room_extra_bed" id="book_extra_bed_'. $v['room_layout_id'] .'" >';
                    for($i = 0; $i <= $v['room_layout_extra_bed'] ; $i++) {
                        $tableHr .= '<option value="'.$i.'">'.$i.'</option>';
                    }
                    $tableHr .= '</select>'
                             .'<input type="text" class="span2 book_price" id="book_extra_bed_price_'. $v['room_layout_id'] .'" value="'
                             . $v['room_layout_extra_bed_price'] . '"  /><span class="hide">' . $v['room_layout_extra_bed_price'] . '</span>';
                    //}
                    $tableHr .= '</td></tr>';*/
                }
            }
            return $this->successResponse('', $arrayBookRoomLayout);
        }
        if($objRequest -> search == 'searchUserMemberLevel') {
            $this -> setDisplay();
            if(empty($objRequest -> book_contact_mobile)) return $this->errorResponse('电话号码不能为空！');
            $conditions['where'] = array('user_mobile'=>$objRequest -> book_contact_mobile);
            $arrayBookType = BookService::instance()->getBookTypeDiscount($conditions);
            return $this->successResponse('', $arrayBookType);
        }
        if($objRequest -> search == 'searchRoom') {
            $this -> setDisplay();
            $room_layout_id = $objRequest -> room_layout_id;
            if(empty($room_layout_id)) return $this->errorResponse('房型错误，请重新选择！');
            $conditions['where'] = array('rlr.room_layout_id'=>$room_layout_id,
                'r.hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id']);
            $arrayRoom = RoomService::instance()->getRoomLayoutRoomDetailed($conditions);
            return $this->successResponse('', $arrayRoom);
        }
        if($objRequest -> search == 'discount') {
            $this -> setDisplay();
            $book_type_id = $objRequest -> book_type_id;
            if(empty($book_type_id)) return $this->errorResponse('数据错误，请重新选择！');
            $conditions['where'] = array('book_type_id'=>$book_type_id,
                'hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id']);
            $fieldid = 'book_discount_id, book_discount, book_discount_name, agreement_company_name';
            $arrayDiscount = BookService::instance()->getBookDiscount($conditions, $fieldid);
            return $this->successResponse('', $arrayDiscount);
        }
        $this->doEdit($objRequest, $objResponse);
        //
        $objResponse -> book_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['book']['add'])));
        $objResponse->view = 'add';
        $objResponse->setTplName("hotel/modules_book_edit");
    }

    protected function doEdit($objRequest, $objResponse) {
        $order_number = decode($objRequest -> order_number);
        $arrayPostValue= $objRequest->getPost();
        $conditions = DbConfig::$db_query_conditions;

        if(!empty($arrayPostValue) && is_array($arrayPostValue) && isset($arrayPostValue['room_layout_id'])) {
            $this->setDisplay();
            if(empty($arrayPostValue['room_layout_id'])) return $this->errorResponse('房型数据错误！');
            unset($arrayPostValue['room_layout_length']);
            $order_number = BookOperateService::instance()->saveBookInfo($objRequest, $objResponse);
            if($order_number == 0) return $this->errorResponse('预定失败！');
            $redirect_url =
                \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['book']['edit']),
                    'order_number'=>encode($order_number)));
            return $this->successResponse('保存售卖房型成功', array('order_number'=>encode($order_number)), $redirect_url);
        }

        $conditions['where'] = array('IN'=>array('hotel_id'=>array($objResponse->arrayLoginEmployeeInfo['hotel_id'],0)));
        $arrayBookType = BookService::instance()->getBookType($conditions);

        $conditions['where'] = null;
        $arrayPaymentType = BookService::instance()->getPaymentType($conditions);
        //
        //赋值
        $objResponse -> view = '0';
        $objResponse -> arrayBookType = $arrayBookType;
        $objResponse -> arrayPaymentType = $arrayPaymentType;
        $objResponse -> book_check_int = getDay() .' '. date("H") . ':00:00';
        $objResponse -> book_check_out = getDay(24) . ' 12:00:00';
        $objResponse -> idCardType = ModulesConfig::$idCardType;
        $objResponse -> searchBookInfoUrl =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['book']['add'])));
        $objResponse -> back_lis_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['book']['view'])));
        $objResponse -> book_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['book']['edit'])));
        //设置类别
    }

    protected function doDelete($objRequest, $objResponse) {
        $this->setDisplay();
    }

    protected function searchISBookRoomLayout($objRequest, $objResponse) {
        $conditions = DbConfig::$db_query_conditions;
        $book_check_int = $objRequest -> book_check_int;
        $book_check_out = $objRequest -> book_check_out;
        //$room_layout_max_people = $objRequest -> room_layout_max_people;
        //排除已住房间
        $conditions['where'] = array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id'],
                                     '<='=>array('book_check_int'=>$book_check_int),'>'=>array('book_check_out'=>$book_check_int));
        $arrarISBookRoomLayout = BookService::instance()->getBook($conditions, 'room_id, room_layout_id');
        $arrayRoomId = array();
        if(!empty($arrarISBookRoomLayout)) {
            foreach($arrarISBookRoomLayout as $k => $v) {
                $arrayRoomId[] = $v['room_id'];
            }
        }
        $conditions['where'] = array('rl.hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id'],
                                     'NOT IN'=>array('rlr.room_id'=>$arrayRoomId));
        $conditions['group'] = 'rlp.`room_layout_id`';
            //SELECT rlr.`room_id`, rlp.`room_layout_price`, rl.* FROM room_layout_room rlr
        //LEFT JOIN `room_layout` rl ON rlr.`room_layout_id` = rl.room_layout_id
        //LEFT JOIN `room_layout_price` rlp ON rlp.`room_layout_id` = rlr.`room_layout_id` AND rlp.`room_layout_price_is_active` = '1'
        //WHERE rl.`room_layout_max_people` >= 1
        $arrayBookRoom = BookService::instance()->searchISBookRoomLayout($conditions);
        return $arrayBookRoom;
        //取得价格
    }



}