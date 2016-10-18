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
            case 'saveAttrValue':
                $this->doSaveAttrValue($objRequest, $objResponse);
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
        if($objRequest -> search == 'searchRoomLayout') {
            $this -> setDisplay();
            $arrayBookRoomLayout = $this->searchISBookRoomLayout($objRequest, $objResponse);
            $tableHr = '';
            if(!empty($arrayBookRoomLayout)) {
                foreach($arrayBookRoomLayout as $k => $v) {
                    $tableHr .= '<tr class="gradeX"><td>' . $v['room_layout_name'] . '</td>'
                               .'<td>' . $v['room_layout_price'] . '</td>'
                               .'<td><inpnu type="checkbox" ></td></tr>';
                }
                for($i = 0 ; $i < 7; $i++) {
                    $tableHr .= $tableHr;
                }

            }
            return $this->successResponse('', $tableHr);
        }

        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id']);
        $conditions['order'] = 'room_layout_valid DESC';

        //
        $weekarray = array("日","一","二","三","四","五","六");
        //赋值
        $objResponse -> searchRoomLayoutUrl = \BaseUrlUtil::Url(array('module'=>$objRequest->module, 'search'=>'searchRoomLayout'));
        $objResponse -> today = getDay() . " 星期".$weekarray[date("w")];
        $objResponse -> idCardType = ModulesConfig::$idCardType;
            //设置类别
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
    }

    protected function view($objRequest, $objResponse) {
        $this->doEdit($objRequest, $objResponse);
        $objResponse->view = '1';
        $objResponse->setTplName("hotel/modules_roomsLayout_add");
    }

    protected function doAdd($objRequest, $objResponse) {
        $room_layout_id = decode($objRequest -> room_layout_id);
        if(!empty($room_layout_id)) {
            throw new \Exception('系统异常！');
        }
        $this->doEdit($objRequest, $objResponse);
        //
        $objResponse -> add_room_layout_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomsLayout']['add'])));
        $objResponse->view = 'add';
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
        //更改tpl
    }

    protected function doEdit($objRequest, $objResponse) {

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
                                     '>='=>array('book_check_int'=>$book_check_int),
                                     '<='=>array('book_check_out'=>$book_check_out));
        $arrarISBookRoomLayout = BookService::instance()->getBook($conditions, 'room_id, room_layout_id');
        $arrayRoomId = array();
        if(!empty($arrarISBookRoomLayout)) {
            foreach($arrarISBookRoomLayout as $k => $v) {
                $arrayRoomId[] = $v['room_id'];
            }
        }
        $conditions['where'] = array('rl.hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id'],
                                     'NOT IN'=>array('rlr.room_id'=>$arrayRoomId));
        //SELECT rlr.`room_id`, rlp.`room_layout_price`, rl.* FROM room_layout_room rlr
        //LEFT JOIN `room_layout` rl ON rlr.`room_layout_id` = rl.room_layout_id
        //LEFT JOIN `room_layout_price` rlp ON rlp.`room_layout_id` = rlr.`room_layout_id` AND rlp.`room_layout_price_is_active` = '1'
        //WHERE rl.`room_layout_max_people` >= 1
        $arrayBookRoom = BookService::instance()->searchISBookRoomLayout($conditions);
        return $arrayBookRoom;
        //取得价格
    }

}