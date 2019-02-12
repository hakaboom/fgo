--OCR对象
OCR={
}

function OCR:new(data)		--{Edition="tessocr_3.02.02",path="res/",lang="chi_sim"}
	local o={
		Edition=data.Edition or "tessocr_3.02.02",
		path=data.path or "[external]",
		lang=data.lang or "eng",
		PSM=6,
		White='',
		reset=false,
	}
		local ocr, msg = createOCR({
			type = "tesseract", 
			path = o.paths,
			lang = o.language
			})
		if ocr==nil then
			print("ocr创建失败:"..msg)
			lua_exit()
		end
	setmetatable(o,{__index = self} )
	o.ocr=ocr
	return o
end

function OCR:getText(data) 	--{rect={},diff={},PSM=6,white="123456789"}
local gsub=string.gsub
local bimage
string.trim = function(s)
        return s:match'^%s*(.*%S)'  or ''
end
	if data.binarize then
		bimage=data.binarize
	else
		bimage=binarizeImage({
				rect=data.rect,
				diff={data.diff},
		    })
	end
	local code, text = self.ocr:getText({
			psm = data.PSM or self.PSM,
			data=bimage,
			whitelist=data.white or self.White,
			blacklist="",
		})
	if code > -1 then
		text=gsub(text," ","")
		if text~="" then
			print("识别结果:"..text:trim())
				return text:trim()
		end
	else
		print("识别错误")
		return false
	end
end

function OCR:release()		--释放字库(释放后再次使用需要重新启动)
	self.reset=true
	self.ocr:release()
end

function OCR:restart()		--释放后重新启动
	self.ocr,self.msg=tessocr.create({
		path=self.path,
		lang=self.lang,
	})
end
