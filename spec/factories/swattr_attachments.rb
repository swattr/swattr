FactoryGirl.define do
  factory :attachment, class: Swattr::Attachment do
    issue
    uploader
    title "My attachment"
    source { File.open(File.join("spec/support/uploads/file.gif")) }
  end
end
