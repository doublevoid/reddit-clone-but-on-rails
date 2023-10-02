class VoteService
  def self.all_votes
    Vote.all
  end

  def self.find_vote_by_id(id)
    Vote.find(id)
  end

  def self.create_vote(params)
    vote = Vote.new(params)
    if vote.save
      [true, vote]
    else
      [false, vote.errors]
    end
  end

  def self.update_vote(vote, params)
    if vote.update(params)
      [true, vote]
    else
      [false, vote.errors]
    end
  end

  def self.destroy_vote(vote)
    vote.destroy
  end
end
