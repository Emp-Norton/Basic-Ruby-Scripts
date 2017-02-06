def parcel_is_saturated?(parcel_temp, dew_point)
  if parcel_temp==dew_point
  	return true
  else 
  	return false
  end
end

def stable?(parcel_temp, ground_temp)
	if parcel_temp>ground_temp
		return false
	elsif parcel_temp<ground_temp
		return true
	end
end


def zone_init
	puts "What is the temperature on the ground and in the parcel?"
	@ground_temp=gets.chomp.to_i
    @parcel_temp=@ground_temp
	puts "What is the dew point?"
	@dew_point=gets.chomp.to_i
	puts "How many 1 kilometer zones?"
	@zones= Array.new(gets.chomp.to_i)
	idx=0
	  while idx<@zones.length
		puts "What is the kilometric lapse rate for zone #{idx}?"
		@zones[idx]=gets.chomp.to_i
		idx+=1
	  end 
end

 
	dalr = 10 #dry air lapse rate 
	malr = 6 #saturated air lapse rate
	ddplr = 2 #dry dew point lapse rate
	mdplr = 6 #saturated dew point lapse rate
	cloud_thickness = 0 #counter for breadth of parcel saturation zones


 zone_init #asks for ELR/ground temp for each km zone and saves in array called zones

 z_idx=0
   while z_idx<@zones.length
   	elr=@zones[z_idx]
   	if parcel_is_saturated?(@parcel_temp, @dew_point)
   		@ground_temp=@ground_temp-elr
   		@parcel_temp=@parcel_temp-malr
   		@dew_point=@dew_point-mdplr
   		cloud_thickness+=1
   		z_idx+=1
   	else
   		@ground_temp=@ground_temp-elr
   		@parcel_temp=@parcel_temp-dalr
   		@dew_point=@dew_point-ddplr
   		z_idx+=1
   	end
   puts "Zone #{z_idx}: Env:#{@ground_temp}c, Parcel:#{@parcel_temp}c, Dew Point:#{@dew_point} Saturated:#{parcel_is_saturated?(@parcel_temp, @dew_point)}, Stability:#{stable?(@parcel_temp, @ground_temp)}"
   end
   puts "Cloud Thickness:#{cloud_thickness} km"
