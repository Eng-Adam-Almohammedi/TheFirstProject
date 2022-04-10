const express = require('express')
const userCtrl = require('../controllers/userController')
const managerCtrl = require('../controllers/managerController')
const router = express.Router()
const auth = require('../middleware/auth')
const multer = require('multer');
const path = require('path');


//* define storage for the images

const storage = multer.diskStorage({
  //destination for files
  destination: function (request, file, callback) {
    callback(null, './uploads');
  },

  //add back the extension
  filename: function (request, file, callback) {
    callback(null, new Date().toISOString() + file.originalname)
  },
});

//* upload parameters for multer
const upload = multer({
  storage: storage,
  limits: {
    fieldSize: 1024 * 1024 * 3,
  },
});


// ____________________________________________GETTIG_____________________________

//* middleware auth check first if user loged in and have a token 
router.get('/get-profile', auth, userCtrl.profile)

// Getting Author Contents
router.get('/profile/:id', userCtrl.getUserId)

// Getting all
router.get('/allUsers', userCtrl.allUsers)

// Getting users count
router.get('/usersCount', userCtrl.getUserCount)

// Getting user
router.get('/getUser/:search', userCtrl.getUser)


// Getting users count
router.get('/usersCount',userCtrl.getUserCount )

// Getting user
router.get('/getUser/:search',userCtrl.getUser )


// Getting enrolled courses
router.get('/enrollCourses', userCtrl.getEnrollCourse)

// Getting enrolled tracks
router.get('/enrollTracks', userCtrl.getEnrollTrack)


// Getting enrolled tracks
router.get('/enrollTracks',userCtrl.getEnrollTrack )


// Getting wishList
router.get('/wishList', userCtrl.getWishCourses)

//* ____________________________________________CREATING_______________________________

/*   router.post('/upload-profile',auth,upload.single('profile'),userCtrl.uploadProfile); */

router.post('/register', userCtrl.register)

router.post('/login', userCtrl.login)

router.post('/upload', auth, upload.single('profile'), userCtrl.uploadImage);

// change password
router.post('/change-password', [auth, userCtrl.changePassword])

// Creating promot request
router.post('/promot-request', [auth, userCtrl.authorPromot])

// Creating enroll course request
router.post('/enroll-request', [auth, userCtrl.enrollCourseRequest])

router.post('/forgot', userCtrl.forgotPassword)


//? ______________________________________UPDATE________________________________________

// Updating One
router.put('/update-profile', [upload.single('imageUrl'), auth, userCtrl.updateProfile])


// update enroll course
router.put('/enrollCourse', [auth,userCtrl.enrollCourse])

// update enroll track
router.put('/enrollTrack', [auth,userCtrl.enrollTrack])

// Updating wishList course
router.put('/wishList', [auth,userCtrl.wishListCourse])

// Updating wishList track
router.put('/wishListTrack', [auth,userCtrl.wishListTrack])


module.exports = router