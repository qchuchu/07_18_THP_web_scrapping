# frozen_string_literal: true

require_relative '../lib/deputes'

describe 'get_deputy_info' do
  it 'check if the deputy is well gotten' do
    expect(get_deputy_info('/deputes/fiche/OMC_PA720614')).to include(hash_including('first_name'=>"Marine", 'last_name'=>"Le Pen"))
    expect(get_deputy_info('/deputes/fiche/OMC_PA721984')).to include(hash_including('first_name'=>"Philippe",'last_name'=>"Latombe"))
  end
end

describe 'get_deputy_url' do
  it 'check if email is well gotten' do
    expect(get_deputy_url) \
      .to include("philippe.latombe@assemblee-nationale.fr","marine.lepen@assemblee-nationale.fr")
  end
end

describe 'perform' do
  it 'check if profile is well gotten' do
    expect(perform) \
      .to include(hash_including('first_name'=>"Marine", 'last_name'=>"Le Pen"), hash_including('first_name'=>"Philippe", 'last_name'=>"Latombe"))
  end
end
