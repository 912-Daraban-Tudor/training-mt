class ArchiveBoardJob
  include Sidekiq::Job

  def perform(board_id)
    Story.where(board_id: board_id).update_all(status: "archived")
  end
end
