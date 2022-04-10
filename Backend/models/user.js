const mongoose = require('mongoose')
const Joi = require('joi')
const jwt = require('jsonwebtoken');
const { type } = require('express/lib/response');
const { joiPassword } = require('joi-password');


// *schema like model of user
const UserSchema = new mongoose.Schema({
    userName: { type: String, lowercase: true, minlength: 3, maxlength: 44 },
    email: { type: String, lowercase: true, required: true, maxlength: 1024 },
    password: { type: String, required: true, minlength: 8, maxlength: 1024 },
    phone: { type: String, minlength: 11, maxlength: 11, },
    gender: { type: String, enum: ['male', 'female'],default:'male' },
    imageUrl: { type: String, default: 'https://res.cloudinary.com/lms07/image/upload/v1645954589/avatar/6214b94ad832b0549b436264_avatar1645954588291.png' },
    cloudinary_id: { type: String, },
    birthDay: { type: String },
    country: { type: String },
    city: { type: String },
    bio: { type: String },
    isAdmin: { type: Boolean, default: false },
    isAuthor: { type: Boolean, default: false },
    isManager: { type: Boolean, default: false },
    wishList: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Course' }, { type: mongoose.Schema.Types.ObjectId, ref: 'Track' }],

    myCourses: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Course' }],
    myTracks: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Track' }],
    userEducation: {
        university: { type: String, },
        major: { type: String, },
        faculty: { type: String, },
        experince: { type: String, },
        grade: { type: String, },
        interest: [{ type: String }]
    },
})



//*validation on user inputs register
function validateUser(user) {
    const JoiSchema = Joi.object({

        userName: Joi.string().min(3).max(44).regex(/[a-zA-Z]/).lowercase(),

        email: Joi.string().email({ minDomainSegments: 2, tlds: { allow: ['com', 'net'] } },).max(1024).required().trim(),

        password: joiPassword.string()
            .minOfSpecialCharacters(1)
            .minOfLowercase(5)
            .minOfUppercase(1)
            .minOfNumeric(1)
            .noWhiteSpaces()
            .required(),

        phone: Joi.string().min(11).max(11).pattern(/^[0-9]+$/).trim(),

        gender: Joi.string().trim(),

        imageUrl: Joi.string().trim(),

        birthDay: Joi.string().trim(),

        country: Joi.string().trim(),

        city: Joi.string().trim(),

        bio: Joi.string().trim(),


    }).options({ abortEarly: false });

    return JoiSchema.validate(user)
}

//*validation on user inputs in login
function validateUserLogin(user) {
    const JoiSchema = Joi.object({

        email: Joi.string().email({ minDomainSegments: 2, tlds: { allow: ['com', 'net'] } }).min(3).max(256).required().trim(),

        password: joiPassword.string()
            .noWhiteSpaces()
            .required(),

    }).options({ abortEarly: false });

    return JoiSchema.validate(user)
}

//*validation on user inputs in login
function validateUserPassword(user) {
    const JoiSchema = Joi.object({

       oldPassword:joiPassword.string()
       .noWhiteSpaces()
       .required(),

        password: joiPassword.string()
        .minOfSpecialCharacters(1)
        .minOfLowercase(5)
        .minOfUppercase(1)
        .minOfNumeric(1)
        .noWhiteSpaces()
        .required(),

    }).options({ abortEarly: false });

    return JoiSchema.validate(user)
}

//*export to use this scehma or function in different files
module.exports = mongoose.model('User', UserSchema)


module.exports.validateUser = validateUser
module.exports.validateUserLogin = validateUserLogin
module.exports.validateUserPassword = validateUserPassword

