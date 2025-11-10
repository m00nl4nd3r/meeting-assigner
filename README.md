# Meeting Assigner

A self-contained web application for assigning meeting roles across team members with support for 1, 2, or 3-person meeting structures.

## Features

- **Multiple Role Configurations**: Choose between 1, 2, or 3-person meeting structures
- **Even Distribution**: Algorithm ensures fair workload distribution across all team members
- **Exemption Management**: Mark team members as unavailable for specific meetings
- **Dark Mode**: Toggle between light and dark themes
- **Calendar Export**: Export assignments to .ics files (iCal/Outlook compatible)
  - Export all team members' meetings combined
  - Export individual team member's meetings with their roles highlighted
  - Configurable meeting duration (15, 30, 45, or 60 minutes)
- **Slack-Friendly Copy**: Copy assignments with emojis and formatting perfect for Slack
- **Export Functionality**: Export assignments to .txt files with emojis
- **History Tracking**: View past assignments (stored in browser localStorage)
- **Fully Self-Contained**: No external dependencies, works offline and on restricted networks

## Docker Deployment

### Prerequisites
- Docker installed on your system
- Docker Compose (optional, but recommended)

### Quick Start

#### Option 1: Using Docker Compose (Recommended)

```bash
# Build and start the container
docker-compose up -d

# Stop the container
docker-compose down
```

#### Option 2: Using Docker directly

```bash
# Build the image
docker build -t meeting_assigner .

# Run the container
docker run -d -p 80:80 --name meeting_assigner meeting_assigner

# Stop the container
docker stop meeting_assigner

# Remove the container
docker rm meeting_assigner
```

### Access the Application

Once running, access the application at:
- **Local**: http://localhost
- **Network**: http://YOUR_SERVER_IP

## File Structure

```
.
├── Dockerfile              # Docker configuration
├── docker-compose.yml      # Docker Compose configuration
├── meeting_assigner.html   # The complete application (single file)
└── README.md              # This file
```

## Distribution

To distribute to other teams:

1. **Share the entire directory** containing:
   - `Dockerfile`
   - `docker-compose.yml`
   - `meeting_assigner.html`
   - `README.md`

2. Recipients can deploy using the Docker commands above

3. Alternatively, share just `meeting_assigner.html` for standalone use (can be opened directly in a browser)

## Role Configurations

### 1 Person Per Meeting
- **Owner**: Handles prep, presentation, notes, and follow-up

### 2 People Per Meeting
- **Presenter**: Handles prep and presentation
- **Follow-up**: Takes notes and handles follow-up

### 3 People Per Meeting
- **Prep**: Handles preparation
- **Presenter**: Handles presentation
- **Follow-up**: Takes notes and handles follow-up

## Using Calendar Export

After generating assignments, you can export them to calendar files (.ics format):

### Export All Meetings
1. Select "All Team Members (Combined)" from dropdown
2. Choose meeting duration (15, 30, 45, or 60 minutes)
3. Click "Export to Calendar (.ics)"
4. Import the .ics file into Outlook, Google Calendar, or Apple Calendar
5. All meetings will appear with role assignments in the description

### Export Individual Member's Meetings
1. Select a team member from the dropdown
2. Choose meeting duration
3. Click "Export to Calendar (.ics)"
4. The calendar file will only include meetings where that person has a role
5. Their specific role(s) will be shown in the meeting title (e.g., "Customer Meeting [Presenter]")

### Calendar Details
- Meetings are automatically scheduled for the current week (Monday-Friday)
- Meeting duration is configurable: 15, 30, 45, or 60 minutes
- Default start time is 9 AM, staggered by 1 hour for multiple meetings per day
- Role assignments appear in the meeting description
- Compatible with: Outlook, Google Calendar, Apple Calendar, and any iCal-compatible application

## Copy to Slack

The "📋 Copy to Clipboard" buttons format the output beautifully for Slack with:
- 📊 Header emojis  
- 📅 Day indicators
- 👤 Owner, 📋 Prep, 🎤 Presenter, ✅ Follow-up role emojis
- **Bold** titles for easy scanning
- Clean, readable format that works on mobile and desktop

Example output:
```
📅 *WEEKLY MEETING ASSIGNMENTS*

📅 *MONDAY*
• *Customer Meeting*
  🎤 Presenter: Alice
  ✅ Follow-up: Bob
```

Simply click copy and paste directly into Slack, Teams, or Discord!

## Technical Details

- **Web Server**: Nginx Alpine (lightweight)
- **Port**: 80
- **Storage**: Browser localStorage (persists assignments per browser/device)
- **No External Dependencies**: Completely self-contained, works on air-gapped systems

## Troubleshooting

### Quick Diagnostics
Run the troubleshooting script:
```bash
./troubleshoot.sh
```

### 403 Forbidden Error
If you get a 403 error:
1. Stop the container: `docker-compose down`
2. Rebuild with the fix: `./deploy.sh`
3. Verify: `./troubleshoot.sh`

See [FIX_403_ERROR.md](FIX_403_ERROR.md) for detailed fix instructions.

### Port 80 already in use
If port 80 is already in use, modify the port mapping:

**docker-compose.yml**:
```yaml
ports:
  - "8080:80"  # Change 80 to any available port
```

**Docker command**:
```bash
docker run -d -p 8080:80 --name meeting_assigner meeting_assigner
```

Then access at http://localhost:8080

### Container won't start
Check container logs:
```bash
docker logs meeting_assigner

# Or with docker-compose
docker-compose logs -f
```

### Reset the application
Simply refresh the browser page. To clear history, use the "Clear All History" button in the app.

## Security Notes

- This application runs entirely in the browser
- No data is sent to external servers
- All data is stored locally in browser localStorage
- Safe for use on restricted/air-gapped networks

## License

Free to use and distribute within your organization.
# meeting-assigner
