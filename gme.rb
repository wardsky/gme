@fate_chart = {
  'impossible' => [50, 25, 15, 10, 5, 5, 0, 0, -10],
  'no way' => [75, 50, 35, 25, 15, 10, 5, 5, 0],
  'very unlikely' => [85, 65, 50, 45, 25, 15, 10, 5, 5],
  'unlikely' => [90, 75, 55, 50, 35, 20, 15, 10, 5],
  '50/50' => [95, 85, 75, 65, 50, 35, 25, 15, 10],
  'somewhat likely' => [95, 90, 85, 80, 65, 50, 45, 25, 20],
  'likely' => [100, 95, 90, 85, 75, 55, 50, 35, 25],
  'very likely' => [105, 95, 95, 90, 85, 75, 65, 50, 45],
  'near sure thing' => [115, 100, 95, 95, 90, 80, 75, 55, 50],
  'a sure thing' => [125, 110, 95, 95, 90, 85, 80, 65, 55],
  'has to be' => [145, 130, 100, 100, 95, 95, 90, 85, 80],
}

@event_focus = {
  1..7 => 'Remote event',
  8..28 => 'NPC action',
  29..35 => 'Introduce a new NPC',
  36..45 => 'Move toward a thread',
  46..52 => 'Move away from a thread',
  53..55 => 'Close a thread',
  56..67 => 'PC negative',
  68..75 => 'PC positive',
  76..83 => 'Ambiguous event',
  84..92 => 'NPC negative',
  93..100 => 'NPC positive',
}

@event_action = [
  'attainment', 'starting', 'neglect', 'fight', 'recruit', 'triumph', 'violate', 'oppose', 'malice', 'communicate',
  'persecute', 'increase', 'decrease', 'abandon', 'gratify', 'inquire', 'antagonise', 'move', 'waste', 'truce',
  'release', 'befriend', 'judge', 'desert', 'dominate', 'procrastinate', 'praise', 'separate', 'take', 'break',
  'heal', 'delay', 'stop', 'lie', 'return', 'immitate', 'struggle', 'inform', 'bestow', 'postpone',
  'expose', 'haggle', 'imprison', 'release', 'celebrate', 'develop', 'travel', 'block', 'harm', 'debase',
  'overindulge', 'adjourn', 'adversity', 'kill', 'disrupt', 'usurp', 'create', 'betray', 'agree', 'abuse',
  'oppress', 'inspect', 'ambush', 'spy', 'attach', 'carry', 'open', 'carelessness', 'ruin', 'extravagance',
  'trick', 'arrive', 'propose', 'divide', 'refuse', 'mistrust', 'deceive', 'cruelty', 'intolerance', 'trust',
  'excitement', 'activity', 'assist', 'care', 'negligence', 'passion', 'work hard', 'control', 'attract', 'failure',
  'pursue', 'vengeance', 'proceedings', 'dispute', 'punish', 'guide', 'transform', 'overthrow', 'oppress', 'change',
]

@event_subject = [
  'goals', 'dreams', 'environment', 'outside', 'inside', 'reality', 'allies', 'enemies', 'evil', 'good',
  'emotions', 'opposition', 'war', 'peace', 'the innocent', 'love', 'the spiritual', 'the intellectual', 'new ideas', 'joy',
  'messages', 'energy', 'balance', 'tension', 'friendship', 'the physical', 'a project', 'pleasures', 'pain', 'possessions',
  'benefits', 'plans', 'lies', 'expectations', 'legal matters', 'bureaucracy', 'business', 'a path', 'news', 'exterior factors',
  'advice', 'a plot', 'competition', 'prison', 'illness', 'food', 'attention', 'success', 'failure', 'travel',
  'jealousy', 'dispute', 'home', 'investment', 'suffering', 'wishes', 'tactics', 'stalemate', 'randomness', 'misfortune',
  'death', 'disruption', 'power', 'a burden', 'intrigues', 'fears', 'ambush', 'rumor', 'wounds', 'extravagance',
  'a representative', 'adversities', 'opulence', 'liberty', 'military', 'the mundane', 'trials', 'masses', 'vehicle', 'art',
  'victory', 'dispute', 'riches', 'status quo', 'technology', 'hope', 'magic', 'illusions', 'portals', 'danger',
  'weapons', 'animals', 'weather', 'elements', 'nature', 'the public', 'leadership', 'fame', 'anger', 'information',
]

def roll_fate(odds, chaos)
  raise "Unrecognised odds: #{odds}" unless @fate_chart.key? odds
  raise "Invalid chaos value: #{chaos}" unless (1..9).include? chaos
  roll = Random.rand(100) + 1
  outcome = if roll <= @fate_chart[odds][9 - chaos]
    Random.rand(5) == 0 ? 'EXCEPTIONAL YES' : 'YES'
  else
    Random.rand(5) == 0 ? 'EXCEPTIONAL NO' : 'NO'
  end
  event = (roll % 11) == 0 && (roll / 11) <= chaos
  return [outcome, event]
end

def roll_event()
  roll = Random.rand(100) + 1
  focus = @event_focus.find { |range, focus| range.include? roll } [1]
  action = @event_action.sample
  subject = @event_subject.sample
  return [focus, action, subject]
end

def put_event()
  focus, action, subject = roll_event
  puts "** #{focus}: #{action} (of) #{subject} **"
end

def main
  chaos = 5
  ARGF.each do |command|
    case command.strip

    when /\?( \((.*)\))?$/
      odds = $2 || '50/50'
      outcome, event = roll_fate(odds, chaos)
      puts "#{outcome}\n"
      put_event() if event

    when /^\/chaos$/
      puts "#{chaos}\n"

    when /^\/event$/
      put_event()
    end
  end
end

main()
