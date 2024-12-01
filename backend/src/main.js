const express = require('express');
const jwt = require('jsonwebtoken');
const bodyParser = require('body-parser');
const WebSocket = require('ws');
const path = require('path');

// Server setup
const app = express();
const PORT = 3000;
const SECRET_KEY = 'supersecretkey';
const wsServer = new WebSocket.Server({ noServer: true });

app.use(bodyParser.json());
app.use(express.static('public')); // Serve public HTML files

function randomUsage(len,maxVal) {
    const arr = Array(len).fill(12);
    arr.forEach((v,i) => arr[i] = Math.random() * maxVal)
    return arr;
}

// In-memory storage
const users = {
    admin: { password: 'admin', name: 'Administrator' },
};

const userDevices = {
    admin: {
        light: { status: 'off', metrics: randomUsage(12, 10) },
        tv: { status: 'off', metrics: randomUsage(12,10) },
    },
};

// Middleware for authenticating JWT
function authenticateToken(req, res, next) {
    const authHeader = req.headers['authorization'] || req.headers['Authorization'];
    const token = authHeader && authHeader.split(' ')[1];
    if (!token) return res.sendStatus(401);
    jwt.verify(token, SECRET_KEY, (err, user) => {
        if (err) return res.sendStatus(403);
        req.user = user;
        next();
    });
}

// WebSocket connections management
const wsConnections = new Map();
wsServer.on('connection', (ws, userId) => {
    if (!wsConnections.has(userId)) {
        wsConnections.set(userId, []);
    }
    wsConnections.get(userId).push(ws);

    ws.on('close', () => {
        const userConnections = wsConnections.get(userId) || [];
        const updatedConnections = userConnections.filter((conn) => conn !== ws);
        if (updatedConnections.length > 0) {
            wsConnections.set(userId, updatedConnections);
        } else {
            wsConnections.delete(userId);
        }
    });
});

// Public endpoint to fetch all users and their devices
app.get('/public/users', (req, res) => {
    const publicData = Object.keys(users).map((username) => ({
        username,
        name: users[username].name,
        lightStatus: userDevices[username].light.status,
        tvStatus: userDevices[username].tv.status,
    }));
    res.json(publicData);
});

// Public endpoint to fetch a default token for testing
app.get('/public/token/:username', (req, res) => {
    const { username } = req.params;
    if (!users[username]) return res.status(404).send('User not found');
    const token = jwt.sign({ username }, SECRET_KEY, { expiresIn: '1h' });
    res.json({ token });
});

// Signup
app.post('/signup', (req, res) => {
    const { username, password, name } = req.body;
    if (!username || !password || !name) {
        return res.status(400).send('Username, password, and name are required');
    }
    if (users[username]) return res.status(400).send('User already exists');

    users[username] = { password, name };
    userDevices[username] = {
        light: { status: 'off', metrics: randomUsage(12,10) },
        tv: { status: 'off', metrics: randomUsage(12,10) },
    };
    const token = jwt.sign({ username }, SECRET_KEY, { expiresIn: '1h' });
    res.json({ token });
});

// Login
app.post('/login', (req, res) => {
    const { username, password } = req.body;
    if (!users[username] || users[username].password !== password) {
        return res.status(401).send('Invalid credentials');
    }

    const token = jwt.sign({ username }, SECRET_KEY, { expiresIn: '1h' });
    res.json({ token });
});

// Update user information
app.get('/user', authenticateToken, (req, res) => {
    const { username } = req.user;
    if (!users[username]) {
        return res.status(404).send('User not found');
    }
    res.json({ user: users[username], username });
});

// Update user information
app.put('/user/update', authenticateToken, (req, res) => {
    const { username } = req.user;
    const { password, name } = req.body;

    if (!users[username]) {
        return res.status(404).send('User not found');
    }

    if (password) {
        users[username].password = password;
    }
    if (name) {
        users[username].name = name;
    }

    res.json({ message: 'User updated successfully', user: { name: users[username].name } });
});

// Toggle light
app.post('/devices/light/toggle', authenticateToken, (req, res) => {
    const user = req.user.username;
    const device = userDevices[user].light;
    device.status = device.status === 'off' ? 'on' : 'off';
    const fullState = userDevices[user];
    if (wsConnections.has(user)) {
        wsConnections.get(user).forEach((ws) => {
            ws.send(JSON.stringify({ devices: fullState }));
        });
    }

    res.json({ devices: fullState });
});

// Toggle TV
app.post('/devices/tv/toggle', authenticateToken, (req, res) => {
    const user = req.user.username;
    const device = userDevices[user].tv;
    device.status = device.status === 'off' ? 'on' : 'off';
    const fullState = userDevices[user];
    if (wsConnections.has(user)) {
        wsConnections.get(user).forEach((ws) => {
            ws.send(JSON.stringify({ devices: fullState }));
        });
    }

    res.json({ devices: fullState });
});

// Get full device state
app.get('/devices/state', authenticateToken, (req, res) => {
    const user = req.user.username;
    const fullState = userDevices[user];
    res.json({ devices: fullState });
});

// Get usage metrics
app.get('/devices/metrics', authenticateToken, (req, res) => {
    const user = req.user.username;
    res.json(userDevices[user]);
});

// WebSocket upgrade
app.server = app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});

app.server.on('upgrade', (req, socket, head) => {
    const token = new URLSearchParams(req.url.replace('/', '')).get('token');
    if (!token) return socket.destroy();

    jwt.verify(token, SECRET_KEY, (err, user) => {
        if (err) return socket.destroy();
        wsServer.handleUpgrade(req, socket, head, (ws) => {
            wsServer.emit('connection', ws, user.username);
        });
    });
});
