require 'coinbase/wallet'
class CoinbasesController < ActionController::API

  def client
    @client = Coinbase::Wallet::Client.new(api_key: ENV['CBKEY'],
                                     api_secret: ENV['CBSECRET'],
                                     CB_VERSION: 'YYYY-MM-DD')
  end

  def accounts
    client
    render json: @client.accounts
  end

  def usd_wallet
     client
     render json: @client.accounts[2]
  end

  def ltc_wallet
     client
     render json: @client.accounts[0]
  end

  def eth_wallet
     client
     render json: @client.accounts[1]
  end

  def btc_wallet
      client
      render json: @client.accounts[3]
  end

  def primary_account
    client
    render json: @client.primary_account
  end

  def btc_transactions
    client
    render json: @client.accounts[3].transactions
  end

  def eth_transactions
    client
    render json: @client.accounts[1].transactions
  end

  def ltc_transactions
    client
    render json: @client.accounts[0].transactions
  end

  def usd_transactions
    client
    render json: @client.accounts[2].transactions
  end

  def transactions
    client
    render json: @client.primary_account.transactions
  end

  def account_id
    client
    render json: @client.accounts[0].id
  end

  def payment_methods
    client
    render json: @client.payment_methods
  end

  def send_payment
    client
    primary_account = client.primary_account
    response = primary_account.send({:to => 'example@gmail.com',
                           :amount => '0.0008',
                           :currency => 'BTC'})
  end

  def buy
    client
    account = client.primary_account
    payment_method = client.payment_methods.first
    buy = account.buy({:amount => "1.36",
                     :currency => "USD",
                     :payment_method => payment_method.id})
  end

  def sell
    client
    account = client.primary_account
    payment_method = client.payment_methods.first

    sell = account.sell({:amount => ".00004",
                       :currency => "BTC",
                       :payment_method => payment_method.id})

  end

  private

  def payment_params
    params.require(:payment).permit(:to, :amount, :description)
  end
end
