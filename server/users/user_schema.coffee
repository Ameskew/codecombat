c = require '../commons/schemas'
emailSubscriptions = ['announcement', 'tester', 'level_creator', 'developer', 'article_editor', 'translator', 'support', 'notification']

UserSchema = c.object {},
  name: c.shortString({title: 'Display Name', default:''})
  email: c.shortString({title: 'Email', format: 'email'})
  firstName: c.shortString({title: 'First Name'})
  lastName: c.shortString({title: 'Last Name'})
  gender: {type: 'string', 'enum': ['male', 'female']}
  password: {type: 'string', maxLength: 256, minLength: 2, title:'Password'}
  passwordReset: {type: 'string'}
  photoURL: {type: 'string', format: 'url', required: false}

  facebookID: c.shortString({title: 'Facebook ID'})
  gplusID: c.shortString({title: 'G+ ID'})

  wizardColor1: c.pct({title: 'Wizard Clothes Color'})
  volume: c.pct({title: 'Volume'})
  music: {type: 'boolean', default: true}
  autocastDelay: {type: 'integer', 'default': 5000 }
  lastLevel: { type: 'string' }

  emailSubscriptions: c.array {uniqueItems: true, 'default': ['announcement', 'notification']}, {'enum': emailSubscriptions}

  # server controlled
  permissions: c.array {'default': []}, c.shortString()
  dateCreated: c.date({title: 'Date Joined'})
  anonymous: {type: 'boolean', 'default': true}
  testGroupNumber: {type: 'integer', minimum: 0, maximum: 256, exclusiveMaximum: true}
  mailChimp: {type: 'object'}
  hourOfCode: {type: 'boolean'}
  hourOfCodeComplete: {type: 'boolean'}

  emailLower: c.shortString()
  nameLower: c.shortString()
  passwordHash: {type: 'string', maxLength: 256}

  # client side
  #gravatarProfile: {} (should only ever be kept locally)
  emailHash: {type: 'string'}

  #Internationalization stuff
  preferredLanguage: {type: 'string', default: 'en', 'enum': c.getLanguageCodeArray()}

  signedCLA: c.date({title: 'Date Signed the CLA'})
  wizard: c.object {},
    colorConfig: c.object {additionalProperties: c.colorConfig()}

  aceConfig: c.object {},
    language: {type: 'string', 'default': 'javascript', 'enum': ['javascript', 'coffeescript']}
    keyBindings: {type: 'string', 'default': 'default', 'enum': ['default', 'vim', 'emacs']}
    invisibles: {type: 'boolean', 'default': false}
    indentGuides: {type: 'boolean', 'default': false}
    behaviors: {type: 'boolean', 'default': false}

  simulatedBy: {type: 'integer', minimum: 0, default: 0}
  simulatedFor: {type: 'integer', minimum: 0, default: 0}

  jobProfile: c.object {title: 'Job Profile', required: ['lookingFor', 'active', 'name', 'city', 'country', 'skills', 'experience', 'shortDescription', 'longDescription', 'visa', 'work', 'education', 'projects', 'links']},
    lookingFor: {title: 'Looking For', type: 'string', enum: ['Full-time', 'Part-time', 'Remote', 'Contracting', 'Internship'], default: 'Full-time', description: 'What kind of developer position do you want?'}
    active: {title: 'Active', type: 'boolean', description: 'Want interview offers right now?'}
    updated: c.date {title: 'Last Updated', description: 'How fresh your profile appears to employers. The fresher, the better. Profiles go inactive after 30 days.'}
    name: c.shortString {title: 'Name', description: 'Name you want employers to see, like "Nick Winter".'}
    city: c.shortString {title: 'City', description: 'City you want to work in (or live in now), like "San Francisco" or "Lubbock, TX".', default: 'Defaultsville, CA'}
    country: c.shortString {title: 'Country', description: 'Country you want to work in (or live in now), like "USA" or "France".', default: 'USA'}
    skills: c.array {title: 'Skills', description: 'Tag relevant developer skills in order of proficiency. Employers will see the first five at a glance.', default: ['javascript'], minItems: 1, maxItems: 30, uniqueItems: true},
      {type: 'string', minLength: 1, maxLength: 20, description: 'Ex.: "objective-c", "mongodb", "rails", "android", "javascript"'}
    experience: {type: 'integer', title: 'Years of Experience', minimum: 0, description: 'How many years of professional experience (getting paid) developing software do you have?'}
    shortDescription: {type: 'string', maxLength: 140, title: 'Short Description', description: 'Who are you, and what are you looking for? 140 characters max.', default: 'Programmer seeking to build great software.'}
    longDescription: {type: 'string', maxLength: 2000, title: 'Long Description', description: 'Give employeers more details. Highlight your stunning personality. Markdown okay. 2000 characters max.', format: 'markdown', default: '* I write great code.\n* You need great code?\n* Great!'}
    visa: c.shortString {title: 'US Work Status', description: 'Are you authorized to work in the US, or do you need visa sponsorship?', enum: ['Authorized to work in the US', 'Need visa sponsorship'], default: 'Authorized to work in the US'}
    work: c.array {title: 'Work Experience', description: 'List your relevant work experience.'},
      c.object {title: 'Job', description: 'Some work experience you had.', required: ['employer', 'role', 'duration']},
        employer: c.shortString {title: 'Employer', description: 'Name of your employer.'}
        role: c.shortString {title: 'Job Title', description: 'What was your job title or role?'}
        duration: c.shortString {title: 'Duration', description: 'When did you hold this gig? Ex.: "Feb 2013 - present".'}
    education: c.array {title: 'Education', description: 'List your academic ordeals.'},
      c.object {title: 'Ordeal', description: 'Some education that befell you.', required: ['school', 'degree', 'duration']},
        school: c.shortString {title: 'School', description: 'Name of your school.'}
        degree: c.shortString {title: 'Degree', description: 'What was your degree and field of study? Ex. Ph.D. Human-Computer Interaction (incomplete)'}
        duration: c.shortString {title: 'Duration', description: 'When? Ex.: "Aug 2004 - May 2008".'}
    projects: c.array {title: 'Projects', description: 'Highlight your projects to amaze employers.'},
      c.object {title: 'Project', description: 'A project you created.', required: ['name', 'description', 'picture', 'link']},
        name: c.shortString {title: 'Project Name', description: 'What was the project called?'}
        description: {type: 'string', title: 'Description', description: 'Briefly describe the project.', maxLength: 400, format: 'markdown'}
        picture: {type: 'string', title: 'Picture', format: 'image-file', description: 'Upload a 300x225px or larger image showing off the project.'}
        link: c.url {title: 'Link', description: 'Link to the project.', default: 'http://codecombat.com'}
    links: c.array {title: 'Links', description: 'Link any other sites or profiles you want to highlight, like your GitHub, your LinkedIn, or your blog.'},
      c.object {title: 'Link', description: 'A link to another site you want to highlight, like your GitHub, your LinkedIn, or your blog.', required: ['name', 'link']},
        name: {type: 'string', maxLength: 30, title: 'Link Name', description: 'What are you linking to? Ex: "Personal Website", "Twitter"'}
        link: c.url {title: 'Link', description: 'The URL.', default: 'http://codecombat.com'}
  jobProfileApproved: {title: 'Job Profile Approved', type: 'boolean', description: 'Whether your profile has been approved by CodeCombat.'}

c.extendBasicProperties UserSchema, 'user'

module.exports = UserSchema
