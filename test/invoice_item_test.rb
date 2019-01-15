  it "#id returns the invoice item id" do
    expect(invoice_item.id).to eq 2345
    expect(invoice_item.id.class).to eq Fixnum
  end

  it "#item_id returns the item id" do
    expect(invoice_item.item_id).to eq 263562118
    expect(invoice_item.item_id.class).to eq Fixnum
  end

  it "#invoice_id returns the invoice id" do
    expect(invoice_item.invoice_id).to eq 522
    expect(invoice_item.invoice_id.class).to eq Fixnum
  end

  it "#unit_price returns the unit price" do
    expect(invoice_item.unit_price).to eq 847.87
    expect(invoice_item.unit_price.class).to eq BigDecimal
  end

  it "#created_at returns a Time instance for the date the invoice item was created" do
    expect(invoice_item.created_at).to eq Time.parse("2012-03-27 14:54:35 UTC")
    expect(invoice_item.created_at.class).to eq Time
  end

  it "#updated_at returns a Time instance for the date the invoice item was last updated" do
    expect(invoice_item.updated_at).to eq Time.parse("2012-03-27 14:54:35 UTC")
    expect(invoice_item.updated_at.class).to eq Time
  end
end
