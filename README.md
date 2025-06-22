# Real-Time Collaborative Code Editor

This is a real-time collaborative code editor built using the MERN stack (MongoDB, Express, React, Node.js) and Socket.io for real-time communication. It allows multiple users to join a room and edit code simultaneously, with changes reflected live for all participants.

## Features

*   **Real-time Collaboration:** Multiple users can edit the same code file at the same time.
*   **Syntax Highlighting:** Supports various programming languages with appropriate syntax highlighting via CodeMirror.
*   **Language Selection:** Users can switch between different programming languages.
*   **Theme Selection:** Users can choose from a variety of CodeMirror themes.
*   **Room-based Editing:** Collaboration happens in unique rooms identified by a Room ID.
*   **User Presence:** See who is currently connected in the room.
*   **Copy Room ID:** Easily copy the Room ID to share with others.
*   **Notifications:** Uses `react-hot-toast` for user notifications (e.g., user joining/leaving).

## Technologies Used

*   **Frontend:**
    *   React
    *   Socket.io Client
    *   CodeMirror (for the editor)
    *   Recoil (for state management)
    *   React Router DOM (for navigation)
    *   React Hot Toast (for notifications)
    *   React Avatar (for user avatars)
*   **Backend:**
    *   Node.js
    *   Express.js
    *   Socket.io
*   **Database:**
    *   (Currently, no database is explicitly used for code persistence beyond session sync. This could be a future enhancement.)
*   **Deployment/Containerization:**
    *   Docker
    *   PM2 (Process manager for Node.js applications)

## Setup and Installation

### Prerequisites

*   Node.js (v14 or higher recommended)
*   npm (Node Package Manager)
*   Docker (for containerized deployment)
*   Git

### Environment Configuration

1.  Clone the repository:
    ```bash
    git clone <repository-url>
    cd realtime-code-editor
    ```
2.  Create a `.env` file in the root directory by copying the example:
    ```bash
    cp example.env .env
    ```
3.  Update the `.env` file with your specific configurations:
    *   `REACT_APP_BACKEND_URL`: The URL where your backend server will be accessible by the client.
        *   For local development (non-Docker), this might be `http://localhost:5050`.
        *   When running with the provided Docker setup, this is handled by the Docker environment.
    *   `SERVER_PORT`: The port on which the Node.js server will run. Defaults to `5050`.

    **Example `.env` for local development (non-Docker):**
    ```env
    REACT_APP_BACKEND_URL=http://localhost:5050
    SERVER_PORT=5050
    ```

### Running with Docker (Recommended)

This is the easiest way to get the application running with both client and server.

1.  Ensure Docker is installed and running.
2.  Build and run the application using Docker Compose:
    ```bash
    docker-compose up --build
    ```
    *   The application client will be accessible at `http://localhost:3000`.
    *   The backend server will be accessible at `http://localhost:5050`.

### Running Locally (Without Docker)

You'll need to run the server and the client separately.

**1. Start the Backend Server:**

*   Navigate to the project root.
*   Install dependencies:
    ```bash
    npm install
    ```
*   Start the development server (with nodemon for auto-restarts):
    ```bash
    npm run server:dev
    ```
    Or for production:
    ```bash
    npm run server:prod
    ```
*   The server will typically run on `http://localhost:5050` (or the `SERVER_PORT` specified in your `.env` file).

**2. Start the Frontend Client:**

*   Ensure your `.env` file has `REACT_APP_BACKEND_URL` pointing to your local backend server (e.g., `http://localhost:5050`).
*   In a new terminal, navigate to the project root.
*   (If you haven't already, run `npm install` from the root to get all dependencies including client ones).
*   Start the React development server:
    ```bash
    npm start
    ```
*   The client application will open in your browser, typically at `http://localhost:3000`.

## Available Scripts

In the `package.json` file, you can find various scripts:

*   `npm start`: Starts the React development server.
*   `npm run build`: Builds the React application for production.
*   `npm run server:dev`: Starts the backend server using `nodemon`.
*   `npm run server:prod`: Starts the backend server using `node`.
*   `npm test`: Runs tests (if any are configured).
*   `npm run start:docker`: Script used by Docker to start both server (with PM2) and client.

## How It Works

The application uses Socket.io to establish a persistent bidirectional connection between the client and the server.
1.  When a user navigates to an editor page, the client attempts to connect to the Socket.io server.
2.  The client emits a `JOIN` event with the room ID and username.
3.  The server adds the user to the specified room and broadcasts a `JOINED` event to all clients in that room, including the new user, along with the list of connected clients.
4.  When a user types in the editor, a `CODE_CHANGE` event is emitted to the server.
5.  The server then broadcasts this `CODE_CHANGE` event to all other clients in the same room.
6.  When a new user joins, a `SYNC_CODE` event is emitted by the joining client to request the current code state from an existing client, which then sends its code.
7.  When a user disconnects, a `DISCONNECTED` event is broadcast so clients can update their list of connected users.

## Troubleshooting

*   **Socket Connection Failed:**
    *   Ensure your `REACT_APP_BACKEND_URL` in the `.env` file (for local client) or in the `Dockerfile` (for Docker client) is correctly pointing to the server's address and port.
    *   Check server logs for any errors.
    *   Verify that the server is running and accessible.
    *   If using Docker, ensure port mappings in `docker-compose.yml` are correct and there are no port conflicts on your host machine.
    *   Check browser console for more detailed error messages.
    *   Ensure your network/firewall allows WebSocket connections.
```
