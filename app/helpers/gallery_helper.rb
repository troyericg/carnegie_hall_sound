module GalleryHelper

	def correct_date(str)
		timeDate = Time.parse(str)
		timeDate.strftime("%a, %b %-d, %Y")
	end
end
