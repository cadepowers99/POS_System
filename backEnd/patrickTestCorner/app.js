const express = require("express");
const app = express();
const port = 3000;

const argon2 = require("argon2");

const redis = require('redis');
const session = require('express-session');
const Knex = require("knex");
const RedisStore = require('connect-redis')(session);
const RedisClient = redis.createClient();

const db = require("knex")({
    client: "pg",
    connection: {
      host: "localhost",
      user: "postgres",
      password: "",
      database: "knex-test"
    }
  });

const sess = session({
    store: new RedisStore({ 
        client: RedisClient, // our redis client
        host: 'localhost',   // redis is running locally on our VM (we don't want anyone accessing it)
        port: 6379,          // 6379 is the default redis port (you don't have to set this unless you change port)
        ttl: 12 * 60 * 60,   // 12 hours
    }),
    secret: 'something secret', // Change This
   resave: false, 
    cookie: {
       httpOnly: true,
        maxAge: 12 * 60 * 60  // 12 hours
    },
    saveUninitialized: false, // set this to false so we can control when the cookie is set (i.e. when the user succesfully logs in)
});

app.use(sess);

app.use(express.json())

app.get('/login', async (req, res) => {
    const {username, password} = req.body; //add rest of data needed...
    
    //check data...
   // if (!email || !password){  
   //     return res.sendStatus(400); //Bad Req.
   // }

    //hash password
    //const passwordHash = await argon2.hash(password);
    
    //Add User to DB

    //const user = {email, passwordhash,...} add default role
    // if( await database.adduser(user) ) {
    //    return res.sendStatus(201);
    //} else {
//      return res.sendStatus(409); //conflict
    //}

    // add user to db via knex?
   // try {
    //    await Knex('user').insert(user);
    //    return res.sendstatus(200);  //succeeded
    //} catch (err) {
    //    return res.sendstatus(401); //failed
    //}
    res.sendStatus(200); //Good
})

app.post('/register', async (req, res) => {
   const {name, username, password, employeeID, address, phoneNumber} = req.body; //add rest of data needed...

    //check data...
    //if (!email || !password){  
    //    return res.sendStatus(400); //Bad Req.
    //}

   // const user = await database.getUser(username);

   // if (user) {
   //     const passwordHash = user.passwordHash;

   //     if ( await argon2.verify(passwordHash, password) ) {
    //        req.session.user = {
    //            email: user.email,
   //             role: user.role,
   //             phoneNumber: user.phoneNumber
   //         };
   //     } else{ //passwords dont match
   //     return res.sendstatus(401) 
   //     }
   // }  else { //email doesn't match
    //    res.sendstatus(401)
   // }
  //  return res.sendStatus(200) //user registered

  res.sendStatus(200); //Registered

})

app.get('/inventoryManagement/partsManagement', async (req, res) => {  // DO it for all Routes asap
    const {PartNumberPattern} = req.body;
    res.json({ parts: [
            {
                PartNumber: "45125A", 
                Description: "Gear", 
                Quantity: 2, 
                Price: 120.00
            },
            {
                PartNumber: "523125A", 
                Description: "Tire", 
                Quantity: 1, 
                Price: 200.00
            }
        ]
    }); //Send product Info
})

app.put('/inventoryManagement/partsManagement/add', async (req, res) => {
   // if (!req.session.user) {
   //     return res.send(401); //unauth
   // }

    const { PartNumber, Description, Quantity, QuantityOO, Price, Brand, Cost, Source, ClassID} = req.body;

    //if(!partnumber...)
    // return res.sendStatus(400)
    res.sendStatus(201); //created
})

app.get('/accountsRecievable', async (req, res) =>{
    //Communicate with DB and get list of Accounts.
    res.json({ accounts: [
            {   
                AccountNumber: 001, 
                CompanyName: "RedStone", 
                AmountOwed: 1200.23, 
                DateDue: "10/5/20"
            },
            {
                AccountNumber: 002,
                CompanyName: "Red Deer",
                AmountOwed: 123.45,
                DateDue: "4/20/20"
            }
        ]
    }); //Send Stubbed list of accounts
})

app.post('accountsRecievable/paid', async (req, res) =>{
    const {AccountNumber, AmountPaid} = req.body;
    //post payment
    res.sendStatus(200); //Posted payment
})

app.get('/inventoryManagement/partsManagement/detailed', async (req, res) =>{
    const {PartNumber} = req.body;
    res.json({QuantityOO: 2,
        Cost: 50.00,
        Brand: "Cobra",
        Source: "Intercontinental",
        ClassID: 001
    }); //Send Data
})
app.post('/inventoryManagement/partsManagement/detailed', async (req, res) =>{
    const {PartNumber, Quantity, QuantityOO} = req.body;
    //update quantity in database
    res.sendStatus(200) //Send back good
})

app.get('/inventoryManagement/classManagement', async (req, res) =>{
    res.json({ classes: [{ClassID: 001,
        ClassDescr: "Gears",
        Margin1: 1.2,
        Margin2: 1.6,
        Margin3: 2.0
    }, {ClassID: 002,
        ClassDescr: "Tires",
        Margin1: 1.5,
        Margin2: 1.9,
        Margin3: 2.3
    }]}); //send stubbed class
})

app.post('/inventoryManagement/classmanagement/update', async (req, res) =>{
    const {ClassID, ClassDescr, Margin1} = req.body;
    //update class
    res.sendStatus(200); //All Good
})

app.get('/customerManagement', async (req,res) =>{
    const {Name} = req.body;
    res.json({customers: [
        {
            ID: 001,
            Name: "Redstone",
            Addr: "1234 Redstone St. Ruelle, AR, 72451",
            Phone: "501-405-5124"
        },
        {
            ID: 002,
            Name: "Red Deer",
            Addr: "321 Red Deer Blvd. Jonesboro, AR, 72401",
            Phone: "870-802-1234"
        }
    ]}); //Send stubbed Data
})

app.get('/customerManagement/detailed', async (req,res) =>{
    const {ID} = req.body;
    res.json({Name: "Redstone",
        Addr: "1234 Redstone St. Ruelle, AR, 72451",
        Phone: "501-405-5124",
        BillingAddr: "POBox 203 Ruelle, AR, 72451",
        ShippingAddr: "ATTN: Robby 1234 Redstone St. Ruelle, AR, 72451",
        CityTax: 0.05,
        StateTax: 0.1,
        FederalTax: 0.025,
        ChargeMax: 20000.00,
        CurrentCharge: 10000.00
    }); //Send stubbed data
})

app.put('/customerManagement/add', async (req,res) =>{
    const {Name,
        Addr,
        Phone,
        BillingAddr,
        ShippingAddr,
        CityTax,
        StateTax,
        FederalTax,
        ChargeMax,
        CurrentCharge
    } = req.body;
    res.sendStatus(200); //Not Implemented
})

app.get('/employeeManagement', async(req,res) =>{
    const {Name} = req.body;
    res.json({employees: [
        {
            ID: 1001,
            Name: "Cade Powers",
            Addr: "2134 Red Wold, Jonesboro, AR, 72142",
            Phone: "321-654-0987"
        },
        {
            ID: 1002,
            Name: "Patrick Case",
            Addr: "1234 Qwertrt, Jonesboro, AR, 72401",
            Phone: "456-789-7890"
        },
        {
            ID: 1003,
            Name: "Fady Farag",
            Addr: "1345 Johnson, Jonesboro, AR, 72401",
            Phone: "759-186-4451"
        },
        {
            ID: 1004,
            Name: "Ryouji Sezai",
            Addr: "2560 E Johnson, Jonesboro, AR, 72401",
            Phone: "758-458-7894"
        }
    ]});
})

app.get('/employeeManagement/detailed', async(req,res) =>{
    const {ID} = req.body;
    res.json({
        Name: "Cade Powers",
        Addr: "2134 Red Wold, Jonesboro, AR, 72142",
        Phone: "321-654-0987",
        Username: "cade",
        Role: "Admin"
    }); //Send stubbed data
})

app.post('/employeeManagement/add', async(req,res) =>{
    const {name, 
        userName, 
        password, 
        empNo, 
        address, 
        phone, 
        role
    } = req.body;
    res.sendStatus(200); //Not Implemented
})

app.get('/partsCounter/invoice', async(req,res) =>{
    const {CustomerName} = req.body;
    res.json({ invoices: [
        {
            ID: 30001,
            Customer: "Redstone",
            Date: "10/07/2020",
            FirstPart: "101-45214-000",
            Total: 1000.23
        },
        {
            ID: 30002,
            Customer: "Redstone",
            Date: "11/07/2020",
            FirstPart: "101-45214-000",
            Total: 1000.23
        }
    ]}); //Stend stubbed data
})

app.post('/partsCounter/invoice/add', async(req,res) =>{
    
    res.sendStatus(200); //Not Implemented
})

app.put('/partsCounter/workOrder/update', async(req,res) =>{
    res.sendStatus(501); //Not Implemented
})

app.get('/partsCounter/history', async(req,res) =>{
    res.sendStatus(501); //Not Implemented
})

app.get('/partsCounter/quote', async(req,res) =>{
    res.sendStatus(501); //Not Implemented
})

app.post('/partsCounter/quote/add', async(req,res) =>{
    res.sendStatus(501); //Not Implemented
})

app.get('/partsCounter/workOrder', async(req,res) =>{
    res.sendStatus(501); //Not Implemented
})

app.post('/partsCounter/workOrder/add', async(req,res) =>{
    res.sendStatus(501); //Not Implemented
})

app.listen(port, () =>{
    console.log("Listening on port 3000\n")
});