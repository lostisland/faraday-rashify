# frozen_string_literal: true

RSpec.describe Faraday::Rashify::Middleware do
  let(:given_options) { {} }
  let(:conn) do
    Faraday.new do |faraday|
      faraday.use Faraday::Rashify::Middleware, **given_options

      faraday.adapter :test do |stub|
        stub.get('ok') { [200, { 'Content-Type' => 'text/html; character-set: utf-8' }, body] }
      end
    end
  end

  context 'when used with specific non-matching options' do
    let(:given_options) do
      { content_type: /\bjson$/ }
    end

    context 'when using a Hash' do
      let(:body) do
        { 'name' => 'Erik Michaels-Ober', 'username' => 'sferik' }
      end

      it 'does NOT create a Hashie::Rash since the content type does not match' do
        me = conn.get('/ok').body

        expect(me).to be_a(Hash)
        expect(me).to be body
      end
    end
  end

  context 'when used with specific matching options' do
    let(:given_options) do
      { content_type: /\bhtml$/ }
    end

    context 'when using a Hash' do
      let(:body) do
        { 'name' => 'Erik Michaels-Ober', 'username' => 'sferik' }
      end

      it 'creates a Hashie::Rash since the content type matches' do
        me = conn.get('/ok').body

        expect(me.name).to eq 'Erik Michaels-Ober'
      end
    end
  end

  context 'when used without specific options' do
    context 'when the given body is a Hash' do
      let(:body) do
        { 'name' => 'Erik Michaels-Ober', 'username' => 'sferik' }
      end

      it 'creates a Hashie::Rash' do
        me = conn.get('/ok').body

        expect(me.name).to eq('Erik Michaels-Ober')
        expect(me.username).to eq('sferik')
      end
    end

    context 'when the given body is a String' do
      let(:body) do
        'Most amazing string EVER'
      end

      it 'creates a String' do
        me = conn.get('/ok').body

        expect(me).to eq('Most amazing string EVER')
      end
    end

    context 'when the given body is a hash with camelcase keys' do
      let(:body) do
        { 'name' => 'Erik Michaels-Ober', 'userName' => 'sferik' }
      end

      it 'turn hashes into Hashie::Rash, and decamelcase the keys' do
        me = conn.get('/ok').body

        expect(me.name).to eq('Erik Michaels-Ober')
        expect(me.user_name).to eq('sferik')
      end
    end

    context 'when the given body is an array' do
      let(:body) do
        [123, 456]
      end

      it 'passes arrays through' do
        values = conn.get('/ok').body

        expect(values).to eq([123, 456])
      end
    end

    context 'when the body is an array of hashes' do
      let(:body) do
        [{ 'username' => 'sferik' }, { 'username' => 'pengwynn' }]
      end

      it 'turns hashes into Hashie::Rash objects' do
        us = conn.get('/ok').body

        expect(us.first).to be_a(Hashie::Mash::Rash)
        expect(us.first.username).to eq('sferik')
        expect(us.last.username).to eq('pengwynn')
      end
    end

    context 'when the body has mixed arrays' do
      let(:body) do
        [123, { 'username' => 'sferik' }, 456]
      end

      it 'turns hashes into Hashie::Rash object and passes other values through' do
        values = conn.get('/ok').body

        expect(values.first).to eq(123)
        expect(values.last).to eq(456)
        expect(values[1].username).to eq('sferik')
      end
    end
  end
end
