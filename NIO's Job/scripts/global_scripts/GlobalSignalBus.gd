extends Node

#region 玩家状态
@warning_ignore("unused_signal")
signal player_is_dead
#endregion

#region 互动状态
@warning_ignore("unused_signal")
signal interaction_started(interact_type)
@warning_ignore("unused_signal")
signal interaction_ended
#endregion

#region 不同互动类型
@warning_ignore("unused_signal")
signal talk_interacted
@warning_ignore("unused_signal")
signal box_talk_interacted
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
signal score_is_full
#endregion
