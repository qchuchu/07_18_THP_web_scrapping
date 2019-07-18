# frozen_string_literal: true

require_relative '../lib/mairie_christmas'

describe 'get_townhall_email' do
  it 'should check if the email is well found' do
    expect(get_townhall_email('/95/ableiges.html')).to eq('mairie.ableiges95@wanadoo.fr')
    expect(get_townhall_email('/95/la-roche-guyon.html')).to eq('mairie.larocheguyon@wanadoo.fr')
  end
end

describe 'get_townhall_urls' do
  it 'should check if the email is well found' do
    expect(get_townhall_email('/95/ableiges.html')).to eq('mairie.ableiges95@wanadoo.fr')
    expect(get_townhall_email('/95/la-roche-guyon.html')).to eq('mairie.larocheguyon@wanadoo.fr')
  end

  it 'should check if the xpath is adapted or not' do
    expect(get_townhall_urls).not_to be_nil
  end
end

describe 'perform function' do
  it 'should contain a certain pair of hash' do
    expect(perform).to include(hash_including('Ableiges'=>anything), hash_including('La-Roche-Guyon'=>anything))
  end
end
