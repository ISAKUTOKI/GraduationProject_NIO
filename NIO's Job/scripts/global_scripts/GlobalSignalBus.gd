extends Node

#region 玩家状态
@warning_ignore("unused_signal")
signal player_is_dead
#endregion

#region 互动状态
@warning_ignore("unused_signal")
signal interaction_started(type: InteractStats)
@warning_ignore("unused_signal")
signal interaction_ended
#endregion

#region 不同互动类型
@warning_ignore("unused_signal")
signal talk_interacted(text_path: String)
@warning_ignore("unused_signal")
signal box_talk_interacted(text_path: String)
@warning_ignore("unused_signal")
signal use_interacted
@warning_ignore("unused_signal")
signal pick_up_interacted
#endregion

#region 数据分拣工
@warning_ignore("unused_signal")
signal data_gain_score(score: float, position: Vector2)
@warning_ignore("unused_signal")
signal data_number_is_picked
@warning_ignore("unused_signal")
signal data_score_is_full
#endregion

#region 汉堡店员
@warning_ignore("unused_signal")
signal burger_part_is_picked(part_type: BurgerPartStats)
@warning_ignore("unused_signal")
signal burger_part_is_created(part_type: BurgerPartStats, from: Vector2, to: Vector2)
@warning_ignore("unused_signal")
signal burger_is_packed(packed_burger: Array)
@warning_ignore("unused_signal")

signal burger_create_order(order_create_is_random: bool, designated_order_type_number: int)
@warning_ignore("unused_signal")

signal burger_order_is_created(order_type: BurgerOrderStats.OrderType, create_position: Vector2, create_z_index: int)
@warning_ignore("unused_signal")
signal burger_order_is_submitted(order_type: BurgerOrderStats.OrderType)
@warning_ignore("unused_signal")
signal burger_final_burger_is_ok
@warning_ignore("unused_signal")
signal burger_order_succeeded
@warning_ignore("unused_signal")
signal burger_order_failed
@warning_ignore("unused_signal")
signal burger_is_ok_to_clear
@warning_ignore("unused_signal")
signal burger_is_ready_for_start_stage
#endregion
