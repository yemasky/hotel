<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/24
 * Time: 0:04
 */
namespace hotel;

class BookOperateService extends \BaseService {
    private static $objService = null;
    public static function instance() {
        if(is_object(self::$objService)) {
            return self::$objService;
        }
        self::$objService = new BookOperateService();
        return self::$objService;
    }

    public function rollback() {
        BookDao::instance()->rollback();
    }

    public function saveBookInfo($objRequest, $objResponse) {
        //print_r($_REQUEST);exit();
        $arrayPostValue = $objRequest->getPost();
        $payment = $arrayPostValue['payment'];//支付 类型
        $payment_type = $arrayPostValue['payment_type'];//支付方式  微信支付宝等
        $is_pay = $arrayPostValue['is_pay'];//付款已到账
        //联系信息
        $arrayBill['book_contact_name']             = $arrayPostValue['book_contact_name'];//联系人
        $arrayBill['book_contact_mobile']           = $arrayPostValue['book_contact_mobile'];//联系人移动电话
        $arrayBill['user_id']                       = '';////
        $arrayBill['hotel_id']                      = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
        //来源
        $arrayBill['book_type_id']                  = $arrayPostValue['book_type_id'];
        $arrayBill['book_discount']                 = $arrayPostValue['book_discount'];//实际折扣
        $arrayBill['book_discount_id']              = $arrayPostValue['book_discount_id'];//折扣ID
        $arrayBill['book_discount_describe']        = $arrayPostValue['book_discount_describe'];//折扣描述
        //入住日期
        $arrayBill['book_check_int']                = $arrayPostValue['book_check_int'];//入住时间
        $arrayBill['book_check_out']                = $arrayPostValue['book_check_out'];//退房时间
        $arrayBill['book_order_retention_time']     = $arrayPostValue['book_order_retention_time'];//订单保留时间
        //主订单
        $arrayBill['book_order_number_main']        = '0';//主订单号
        $arrayBill['book_order_number']             = 1;//订单号
        //
        $arrayBill['book_order_number_status']      = '0';//订单状态 -1 失效 0预定成功 1入住 2退房完成
        //
        $arrayBill['book_total_price']              = $arrayPostValue['book_total_price'];//计算支付总价
        //预付
        $arrayBill['book_prepayment_price']         = $arrayPostValue['book_prepayment_price'];//预付费
        if($payment == 1) {
            $arrayBill['book_is_prepayment']        = $is_pay;//是否已支付预付费
            if($is_pay == 1) {
                $arrayBill['book_prepayment_date']  = getDateTime();//预付费支付时间
            }
            $arrayBill['prepayment_type_id']        = $payment_type;//预付 支付方式  微信支付宝等
        }

        $arrayBill['book_prepayment_account']       = '';//预付支付帐号
        //全额支付
        if($payment == 3) {
            $arrayBill['book_is_pay']               = '1';//是否已经全额支付房费
            $arrayBill['payment_type_id']           = $payment_type;//预付 支付方式  微信支付宝等
        }
        $arrayBill['book_payment_voucher']          = $arrayPostValue['book_payment_voucher'];//付款凭证
        //时间
        $arrayBill['book_add_date']                 = getDay();
        $arrayBill['book_add_time']                 = getTime();
        $arrayLayoutPrice   = $arrayPostValue['layout_price'];
        $arrayExtraBedPrice = $arrayPostValue['extra_bed_price'];
        $arrayExtraBed = isset($arrayPostValue['extra_bed']) ? $arrayPostValue['extra_bed'] : null;
        //根据房间插入不同的房间
        $arraybatchInsert = array();
        $arraybatchInsertValue = array();
        $arrayRoomLayoutRoomHash = array();
        foreach($arrayPostValue['room_layout_id'] as $room_layout_id => $arrayRoom) {
            foreach($arrayRoom as $i => $room_id) {
                $arrayRoomLayoutRoomHash[$room_id] = $room_layout_id;
                //第一个个设为主订单
                if($i == 0) {
                    $arrayBill['book_order_number_main'] = '1';//主订单号
                    $arrayBill['room_layout_id'] = $room_layout_id;
                    $arrayBill['room_id'] = $room_id;
                    $arrayBill['book_room_layout_price'] = $arrayLayoutPrice[$room_layout_id];
                    $arrayBill['book_room_extra_bed']    = '';
                    $arrayBill['book_room_extra_bed_price'] = 0;
                    if(!empty($arrayExtraBed)) {
                        if(isset($arrayExtraBed[$room_layout_id][$room_id])) {
                            $arrayBill['book_room_extra_bed'] = $arrayExtraBed[$room_layout_id][$room_id];
                            $arrayBill['book_room_extra_bed_price'] = $arrayExtraBedPrice[$room_layout_id];
                        }
                    }
                } else {
                    $arraybatchInsertValue[$i - 1]['book_order_number_main'] = '0';//主订单号
                    $arraybatchInsertValue[$i - 1]['room_layout_id'] = $room_layout_id;
                    $arraybatchInsertValue[$i - 1]['room_id'] = $room_id;
                    $arraybatchInsertValue[$i - 1]['book_room_layout_price'] = $arrayLayoutPrice[$room_layout_id];
                    $arraybatchInsertValue[$i - 1]['book_room_extra_bed'] = '';
                    $arraybatchInsertValue[$i - 1]['book_room_extra_bed_price'] = 0;
                    if(isset($arrayExtraBed[$room_layout_id][$room_id])) {
                        $arraybatchInsertValue[$i - 1]['book_room_extra_bed'] = $arrayExtraBed[$room_layout_id][$room_id];
                        $arraybatchInsertValue[$i - 1]['book_room_extra_bed_price'] = $arrayExtraBedPrice[$room_layout_id];
                    }
                }
            }
        }

        //事务开启
        BookDao::instance()->startTransaction();
        $book_id = BookService::instance()->saveBook($arrayBill);
        $book_order_number = \Utilities::getOrderNumber($book_id);
        BookService::instance()->updateBook(array('book_id'=>$book_id), array('book_order_number'=>$book_order_number));
        if(!empty($arraybatchInsertValue)) {
            foreach($arraybatchInsertValue as $k => $v) {
                $arraybatchInsert[$k] = $arrayBill;
                $arraybatchInsert[$k]['book_order_number'] = $book_order_number;
                $arraybatchInsert[$k]['room_layout_id'] = $v['room_layout_id'];
                $arraybatchInsert[$k]['room_id'] = $v['room_id'];
                $arraybatchInsert[$k]['book_room_layout_price'] = $v['book_room_layout_price'];
                $arraybatchInsert[$k]['book_room_extra_bed'] = $v['book_room_extra_bed'];
                $arraybatchInsert[$k]['book_room_extra_bed_price'] = $v['book_room_extra_bed_price'];
            }
        }
        if(!empty($arraybatchInsert)) BookDao::instance()->setTable('book')->batchInsert($arraybatchInsert);

        //添加住客
        $arrayBookUserData = array();
        foreach($arrayPostValue['book_user_name'] as $i => $bookUser) {
            if(!empty($bookUser) && !empty($arrayPostValue['book_user_id_card'][$i])) {
                $arrayBookUserData[$i]['book_user_name'] = $bookUser;
                $arrayBookUserData[$i]['book_order_number'] = $book_order_number;
                $arrayBookUserData[$i]['book_user_id_card'] = $arrayPostValue['book_user_id_card'][$i];
                $arrayBookUserData[$i]['book_user_id_card_type'] = $arrayPostValue['book_user_id_card_type'][$i];
                $arrayBookUserData[$i]['room_layout_id'] = $arrayRoomLayoutRoomHash[$arrayPostValue['book_user_room'][$i]];
                $arrayBookUserData[$i]['room_id'] = $arrayPostValue['book_user_room'][$i];
                $arrayBookUserData[$i]['book_user_sex'] = $arrayPostValue['book_user_sex'][$i];
                $arrayBookUserData[$i]['book_check_int'] = $arrayPostValue['book_check_int'];
                $arrayBookUserData[$i]['book_check_out'] = $arrayPostValue['book_check_out'];
                $arrayBookUserData[$i]['book_add_date'] = getDay();
                $arrayBookUserData[$i]['book_add_time'] =getTime();
            }
        }
        if(!empty($arrayBookUserData)) BookDao::instance()->setTable('book_user')->batchInsert($arrayBookUserData);

        BookDao::instance()->commit();
        return $book_order_number;
    }

    public function getBookInfo($objRequest, $objResponse) {
        $thisDay = $objRequest -> time_begin;
        $toDay = $objRequest -> time_end;
        $thisDay = empty($thisDay) ? getDay() : $thisDay;
        $toDay = empty($toDay) ? getDay(7*24) : $toDay;

        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id'],
            '>='=>array('book_check_int'=>$thisDay),
            '<='=>array('book_check_out'=>$toDay));
        $conditions['order'] = 'book_check_int ASC, book_order_number ASC, book_order_number_main DESC';
        $arrayBookInfo = BookService::instance()->getBook($conditions);
        $arrayBookList = array();
        if(!empty($arrayBookInfo)) {
            foreach($arrayBookInfo as $i => $arrayBook) {
                if($arrayBook['book_order_number_main'] == '1') {
                    $arrayBookList[$arrayBook['book_order_number']] = $arrayBook;
                    $arrayBookList[$arrayBook['book_order_number']]['child'][] = $arrayBook;
                } else {
                    $arrayBookList[$arrayBook['book_order_number']]['child'][] = $arrayBook;
                }
            }
        }
        sort($arrayBookList);
        //
        $objResponse -> arrayBookList = $arrayBookList;
        $objResponse -> thisYear = getYear();
        $objResponse -> thisMonth = getMonth();
        $objResponse -> thisDay = $thisDay;
        $objResponse -> toDay = $toDay;
    }

    public function searchISBookRoomLayout($objRequest, $objResponse) {
        $conditions = DbConfig::$db_query_conditions;
        $book_check_in = $objRequest -> book_check_int;
        $book_check_out = $objRequest -> book_check_out;
        $arrayBookCheckIn = explode('-', $book_check_in);
        $arrayBookCheckOut = explode('-', $book_check_out);
        $price_system_id = $objRequest -> system_id;
        //{begin} 排除已住房间
        $hotel_id = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
        $conditions['where'] = "hotel_id = '".$hotel_id."' AND (book_check_int <= '".$book_check_in."' AND '".$book_check_in."' < book_check_out) "
                                                     ."OR ('".$book_check_in."' <= book_check_int AND book_check_int < '".$book_check_out."')";
        $arrayISBookRoomLayout = BookService::instance()->getBook($conditions, 'room_id, room_layout_id');
        $arrayRoomId = array();
        if(!empty($arrayISBookRoomLayout)) {
            foreach($arrayISBookRoomLayout as $k => $v) {
                $arrayRoomId[] = $v['room_id'];
            }
        }
        //{end} 排除已住房间
        //{begin} 排除已住房型
        $conditions['where'] = array('hotel_id'=>$hotel_id);
        if(!empty($arrayRoomId))
            $conditions['where'] = array('hotel_id'=>$hotel_id,
                                         'NOT IN'=>array('room_id'=>$arrayRoomId));
        $arrayRoomLayoutRoom = RoomService::instance()->getRoomLayoutRoom($conditions, '*', 'room_layout_id', true);
        $arrayRoomLayoutId[0] = 0;
        if(!empty($arrayRoomLayoutRoom)) {
            foreach($arrayRoomLayoutRoom as $room_layout_id => $value) {
                $arrayRoomLayoutId[] = $room_layout_id;
            }
        }
        //{end} 排除已住房型
        //{begin} 查找价格体系
        $conditions['where'] = array('IN'=>array('room_layout_id'=>$arrayRoomLayoutId));
        if(!empty($price_system_id))
            $conditions['where'] = array('IN'=>array('room_layout_id'=>$arrayRoomLayoutId,'room_layout_price_system_id'=>$price_system_id));
        RoomService::instance()->getRoomLayoutPriceSystem($conditions);
        //{end} 查找价格体系
        //{begin} 查找房型房价
        RoomService::instance()->getRoomLayoutPrice();
        //{end} 查找房型房价


        $conditions['where'] = array('rl.hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id'],
            'NOT IN'=>array('rlr.room_id'=>$arrayRoomId));
        $conditions['group'] = 'rlp.`room_layout_id`';
        $table = "`room_layout_room` rlr LEFT JOIN `room_layout` rl ON rlr.`room_layout_id` = rl.room_layout_id "
            ."LEFT JOIN `room_layout_price` rlp ON rlp.`room_layout_id` = rlr.`room_layout_id` AND rlp.`room_layout_price_is_active` = '1'";
        $fieid = 'COUNT(rlp.`room_layout_id`) room_layout_num, rlp.`room_layout_price`, rlp.room_layout_extra_bed_price, rl.*';//rlr.`room_id`
        return BookDao::instance()->setTable($table)->getList($conditions, $fieid);
    }

}