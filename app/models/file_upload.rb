
require 'active_support'

class FileUpload < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.
  validates :name, presence: true # Make sure the file's name is present.
  attr_accessor :genders

  def set_genders
    text = File.open(Rails.root.join('public','uploads','file_upload','attachment',"#{id}","#{name}")).read
    text.gsub!(/\r?\n/, "\n")
    text.each_line do |line|
      numbers = line.gsub(/[[:space:]]/, ' ').split
      traverse(1, numbers[0].to_i, numbers[1].to_i, '')
    end
    self.save!
  end

  def traverse(level, depth, width, flat_tree) 
    if (depth==1)
      self.genders = 'M' 
    else
      if level == 1
        flat_tree = 'M'
      end
      while (level <= depth)     
        flat_tree += reverted(flat_tree)
        level+=1
      end
      self.genders = (genders || "").to_s + flat_tree[width - 1].to_s 
    end
  end

  def reverted(flat_tree)
    tmp = flat_tree.gsub('F', 'T')
    tmp = tmp.gsub('M', 'F')
    tmp.gsub('T', 'M')
  end

end
