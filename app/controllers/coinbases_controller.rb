require 'coinbase/wallet'
class CoinbasesController < ActionController::API

  def client
    @client = Coinbase::Wallet::Client.new(api_key: "VNIIuOsRbnIQzjo1", api_secret: "XAOFSFb1hBtqoHCTEUibG4SEuSiMchMC", CB_VERSION: 'YYYY-MM-DD')
  end

  def accounts
    client
    render json: @client.accounts
  end

  def usd_wallet
     client
     render json: @client.accounts[0]
  end

  def ltc_wallet
     client
     render json: @client.accounts[1]
  end

  def eth_wallet
     client
     render json: @client.accounts[2]
  end

  def btc_wallet
     client
     render json: @client.accounts[3]
  end

  def primary_account
    client
    render json: @client.primary_account
  end

  def transactions
    client
    render json: @client.primary_account.transactions
  end

  def send_payment
    client
    address = "1JQxjbjDew53sorcF6ggPK9CvZva3vSXHX"
    primary_account.send(to: address, amount: '0.0001', currency: 'BTC', description: 'For being a dick!')
  end


end
