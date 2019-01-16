class Transaction

  attr_accessor :id, :invoice_id, :credit_card_number, :created_at, :updated_at, :credit_card_expiration_date, :result
  def initialize(attributes)
    @id = attributes[:id]
    @invoice_id = attributes[:invoice_id].to_i
    @credit_card_number = attributes[:credit_card_number].to_s
    @created_at = Time.parse(attributes[:created_at])
    @updated_at = Time.parse(attributes[:updated_at])
    @credit_card_expiration_date = cc_to_string(attributes[:credit_card_expiration_date])
    @result = attributes[:result].to_sym
  end

  #helper methods
  def cc_to_string(cc_num)
    string = cc_num.to_i.to_s
    if string.length == 3
      string.prepend("0")
    end
    string
  end
end
