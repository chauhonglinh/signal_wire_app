require 'rails_helper'

RSpec.describe Tag, type: :model do
  context 'associations' do
    it { should have_many(:tags_tickets)}
    it { should have_many(:tickets)}
  end

  context 'first_or_create_with_count!' do
    it 'creates the tag if it does not exist' do
      tag_name = 'Tag 1'

      tag = Tag.find_by(name: tag_name)
      expect(tag).to be nil

      tag = Tag.first_or_create_with_count!(tag_name)
      expect(tag.name).to eql(tag_name.downcase)
      expect(tag.count).to eql(1)
    end

    it 'updates the tag and increase the count if it exists' do
      tag_name = 'Tag 2'

      tag = Tag.first_or_create_with_count!(tag_name)
      expect(tag.count).to eql(1)

      tag = Tag.first_or_create_with_count!(tag_name)
      expect(tag.count).to eql(2)
    end
  end

  context 'tags_with_max_count' do
    it 'returns an array of tags that have the same max count' do
      4.times do
        Tag.first_or_create_with_count!('tag 1')
        Tag.first_or_create_with_count!('tag 2')
      end

      Tag.first_or_create_with_count!('tag 3')

      expect(Tag.count).to eql(3)

      tags_with_max_count = Tag.tags_with_max_count()
      expect(tags_with_max_count.size).to eql(2)

      tags_with_max_count.each do |tag|
        expect(tag.count).to eql(4)
      end
    end
  end
end
