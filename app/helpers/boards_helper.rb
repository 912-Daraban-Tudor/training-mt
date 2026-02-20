module BoardsHelper

  def reorder_board_columns(column_id, target_position)
    board_column = @board.board_columns.find_by!(column_id: column_id)
    original_position = board_column.column_position.to_i
    target_position = target_position.to_i

    if target_position > original_position
      @board.board_columns.where("column_position > ? AND column_position <= ?", original_position, target_position)
            .update_all("column_position = column_position - 1")
    elsif target_position < original_position
      @board.board_columns.where("column_position >= ? AND column_position < ?", target_position, original_position)
            .update_all("column_position = column_position + 1")
    end

    board_column.update!(column_position: target_position)
  end
end
