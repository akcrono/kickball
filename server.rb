require 'sinatra'
require 'csv'
require 'pry'

def players_on_team team
  players = []
  CSV.foreach('lackp_starting_rosters.csv', headers: true, :header_converters => :symbol, :converters => :all) do |row|
    players << row.to_hash if row[:team] == team
  end

  return players
end

def players_at_position position
  players = []
  CSV.foreach('lackp_starting_rosters.csv', headers: true, :header_converters => :symbol, :converters => :all) do |row|
    players << row.to_hash if row[:position] == position
  end

  return players
end

def team_names
  teams = []
  CSV.foreach('lackp_starting_rosters.csv', headers: true, :header_converters => :symbol, :converters => :all) do |row|
    teams << row[:team]
  end
  return teams.uniq
end

def position_list
  positions = []
  CSV.foreach('lackp_starting_rosters.csv', headers: true, :header_converters => :symbol, :converters => :all) do |row|
    positions << row[:position]
  end
  return positions.uniq
end

get '/' do
  @teams = team_names

  @positions = position_list

  erb :index

end

get '/teams/:team' do
  @this_team = params[:team]
  @players = players_on_team @this_team

  erb :teams


end

get '/positions/:position' do
  @this_position = params[:position]
  @players = players_at_position @this_position
  binding.pry
  erb :positions


end

