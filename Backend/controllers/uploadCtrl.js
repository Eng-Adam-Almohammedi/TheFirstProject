const cloudinary = require('cloudinary')
const fs = require('fs')

cloudinary.config({
    cloud_name :process.env.CLOUD_NAME,
    api_key :process.env.CLOUD_API_KEY,
    api_secret :process.env.CLOUD_API_SECRET
})

const uploadCtrl = {
    uploadAvatar: async (req, res) => { 
        try {
            const imageUrl = req.body.imageUrl
            cloudinary.v2.uploader.upload(imageUrl, {          
                   folder: 'avatar', width: 150, height: 150, crop: "fill"
        }, async(err, result) => {
            if(err) throw err;
            removeTmp(imageUrl)
            
            res.json({url: result.secure_url})
    
            
        })

     } catch (err) {
        return res.status(500).json({msg: err})
    }
    },
    uploadCourseimage: async (req, res) => { 
        try {
            const file = req.files.file;
            
            cloudinary.v2.uploader.upload(file.tempFilePath, {          
                   folder: 'avatar', width: 1920, height: 1280
        }, async(err, result) => {
            if(err) throw err;

            removeTmp(file.tempFilePath)
            //console.log({result});
            res.json({url: result.secure_url})
        
        })
    } catch (err) {
        return res.status(500).json({msg: err})
    }
    }
}
const removeTmp = (path) => {
    fs.unlink(path, err => {
        if(err) throw err
    })
}

module.exports = uploadCtrl