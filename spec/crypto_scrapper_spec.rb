# frozen_string_literal: true

require_relative '../lib/crypto_scrapper'

describe "crypto_scrapper" do
  it "should check if include the famous crypto currencies" do
    expect(crypto_scrapper).to include(hash_including("BTC"=>anything))
    expect(crypto_scrapper).to include(hash_including("ETH"=>anything))
    expect(crypto_scrapper).to include(hash_including("BCH"=>anything))
    expect(crypto_scrapper).to include(hash_including("LTC"=>anything))
  end
end
