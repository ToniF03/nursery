#import "template.typ": *
#show: nursery-template

= Introduction
== Project description
The developed application is a cross-platform mobile application built entirely with Flutter, designed to modernize workflows in the healthcare sector. Its primary goal is to provide healthcare professionals with a centralized platform for patient management, communication, scheduling, and emergency coordination.

The application features a dashboard that displays all relevant information at a glance, including upcom-ing shifts, assigned patients, tasks, and notifications. Users can access patient information, exchange structured shift handovers, communicate with colleagues through an integrated messaging system, and request assistance in emergency situations.

Additionally, the app supports workforce management with digital shift planning, shift swaps, and per-sonalized schedules. By combining these features into a single, user-friendly platform, the application aims to improve communication, reduce administrative effort and enhance the quality and efficiency of patient care.

== Purpose of the Application
Nursery is a digital collaboration platform designed specifically for healthcare professionals working in hospitals, retirement homes, nursing facilities, and other medical institutions. Its purpose is to centralize essential daily workflows into a single, secure application, reducing the need to switch between multiple systems. The platform enables staff to communicate with colleagues in real time, access and manage patient records, coordinate tasks, respond quickly to emergencies, and retrieve important clinical infor-mation whenever needed. By improving communication, increasing accessibility to critical data, and streamlining administrative processes, Nursery aims to enhance efficiency, support better decision-making, and ultimately contribute to higher-quality patient care.

== Competitive Positioning
Nursery differentiates itself from existing healthcare software by combining multiple essential functions into a single, unified platform. Many healthcare institutions currently rely on separate applications for team communication, electronic patient records, scheduling, emergency notifications, and document management. This often leads to fragmented workflows, duplicated information, and increased adminis-trative effort.

While platforms such as Microsoft Teams provide excellent communication features and established Elec-tronic Health Record (EHR) systems such as Epic and Oracle Health (formerly Cerner) focus primarily on patient documentation, Nursery aims to bridge the gap between collaboration and clinical operations. By integrating secure messaging, emergency response, patient records, task management, and healthcare-specific workflows into one application, Nursery reduces the need to switch between multiple systems and provides healthcare professionals with a more efficient and intuitive working environment.

Rather than replacing specialized hospital information systems, Nursery is designed to complement them by serving as a central collaboration hub that connects Staff, information, and critical workflows. This approach allows healthcare providers to improve communication, accelerate decision-making, and en-hance the overall quality of patient care while minimizing operational complexity.

== Installation Instructions
=== Requirements
The app needs following components to be installed and run:

#list(
  [Flutter SDK (version 3.50.0 or higher)],
  [Dart SDK (Version 3.14.0 or higher)],
  [Git (Version 2.56.0 or higher)],
  [Android SDK (version 36.0.0 or higher)]
)

=== Clone the Repository
Run the following command to clone the repository:

```
git clone https://github.com/ToniF03/nursery.git
```

=== Navigate to the Project Directory
Run the following command to navigate to the project directory:

```
cd nursery
```

=== Install Dependencies
Run the following command to install the required dependencies:

```
flutter pub get
```

=== Run the Application
Run the following command to launch the application:

```
flutter run
```

A test account has already been set up for the application. It can be accessed using the email address testuser\@demo.com and the password Test123. Alternatively, you can create a new user account using the registration feature.

== User Stories
=== Login
#user-story(
    title: "User Authentication",
    id: "US-01",
    priority: "Must-have",
    description: "As a healthcare professional, I want to securely log into the application so that only authorized personnel can access patient information.",
    additions: ("Email or employee ID login", "Secure password hashing", "Session persistence", "Password reset"),
    dependencies: ("User database", "Authentication API", "Login UI"),
    dod: ("User can log in successfully", "Invalid credentials display an error", "Passwords are securely stored", "Sessions persist across app restarts", "Logout works correctly"),
    tasks: ("Authentication backend", "JWT/session implementation", "Login screen", "Password hashing")
)

=== Patient Records
#user-story(
    title: "Patient Records",
    id: "US-02",
    priority: "Must-have",
    description: "As a nurse, I want to access patient records so that I always have the latest medi-cal information available.",
    additions: ("Personal information", "Diagnoses", "Allergies", "Medication", "Medical documents", "Vital signs"),
    dependencies: ("Database", "API", "Role management"),
    dod: ("Patient list is displayed", "Patient details load correctly", "Access permissions are enforced", "Loading indicators are implemented"),
    tasks: ("Patient API", "Database model", "Patient overview", "Detail page", "Permission checks")
)

=== Team chat
#user-story(
    title: "Team Chat",
    id: "US-03",
    priority: "Should-have",
    description: "As a healthcare professional, I want to communicate with my team in real time so that we can coordinate patient care effectively.",
    additions: ("Private chats", "Group chats", "Images", "Files", "Read receipts", "Push notifications", "Typing indicators"),
    dependencies: ("Authentication", "Messaging Server", "Push Notifications"),
    dod: ("Messages are delivered in real time", "Chat history is stored", "Images can be shared", "Push notifications are sent", "Typing indicators work correctly"),
    tasks: ("WebSocket implementation", "Chat backend", "Chat UI", "Notifications", "Database")
)

=== Emergency Alerts
#user-story(
    title: "Emergency Alerts",
    id: "US-04",
    priority: "Must-have",
    description: "As a nurse, I want to trigger an emergency alert so that nearby staff can respond immediately.",
    additions: ("One-tap emergency button", "Send current location/department", "Notify available staff", "Escalate if no response"),
    dependencies: ("Push notification service", "Location service", "User availability status"),
    dod: ("Alert reaches nearby staff", "Location is attached", "Emergency is logged", "False alerts can be canceled"),
    tasks: ("Emergency API", "Notification service", "UI", "Logging")
)

=== Shift Schedule
#user-story(
    title: "Shift Schedule",
    id: "US-05",
    priority: "Should-have",
    description: ("As an employee, I want to view my shift schedule so that I can plan my work and personal life accordingly."),
    additions: ("Weekly view", "Monthly view", "Shift changes", "Vacation", "Sick Leave"),
    dependencies: ("Scheduling backend", "User authentication"),
    dod: ("Schedule loads correctly", "Changes update automatiaclly", "Employees can view future shifts"),
    tasks: ("Schedule API", "Calendar UI", "Notifications")
)

=== Medication Management
#user-story(
  title: "Medication Management",
  id: "US-06",
  priority: "Must-have",
  description: "As a nurse, I want to view prescribed medication so that I can administer medi-cation safely.",
  additions: (
    "Dosage", 
    "Administration times", 
    "Missed medication warnings", 
    "Medication history"
  ),
  dependencies: (
    "Patient Records", 
    "User Authentication", 
    "Role-Based Access Control",
    "Medication database/API"
  ),
  dod: (
    "Medication list loads correctly",
    "Medication details are accurate",
    "Alerts are displayed for allergies and interactions",
    "Administration times are shown",
    "Medication history is accessible"
  ),
  tasks: (
    "Create medication database schema",
    "Implement medication API",
    "Build medication overview UI",
    "Add reminder and warning logic",
    "Implement history tracking",
    "Write unit and integration tests"
  )
)

=== Task Management
#user-story(
  title: "Task Management",
  id: "US-07",
  priority: "Should-have",
  description: "As a healthcare professional, I want to assign and manage tasks so that work is distributed efficiently.",
  additions: (
    "Create tasks", 
    "Assign tasks to staff", 
    "Set priorities", 
    "Mark tasks as complete", 
    "View task history"
  ),
  dependencies: (
    "User Authentication", 
    "Database/API for tasks", 
    "Notification system"
  ),
  dod: (
    "Tasks can be created and assigned", 
    "Deadlines are enforced", 
    "Completed tasks are tracked", 
    "Notifications are sent for upcoming deadlines"
  ),
  tasks: (
    "Design task database",
    "Build task management API",
    "Implement task UI",
    "Integrate notifications for tasks",
    "Add filtering and sorting options",
    "Write unit and integration tests"
  )
)

=== Digital Handover
#user-story(
  title: "Digital Handover",
  id: "US-08",
  priority: "Must-have",
  description: "As a nurse, I want to perform digital handovers so that patient information is transferred accurately and efficiently between shifts.",
  additions: (
    "Structured handover templates", 
    "Patient status updates", 
    "Critical alerts", 
    "Handover history"
  ),
  dependencies: (
    "Patient Records", 
    "User Authentication", 
    "Database/API for handovers"
  ),
  dod: (
    "Handover templates are available", 
    "Patient information is transferred correctly", 
    "Critical alerts are highlighted", 
    "Handover history is accessible"
  ),
  tasks: (
    "Design handover templates",
    "Implement handover API",
    "Build handover UI",
    "Integrate with patient records",
    "Add history tracking",
    "Write unit and integration tests"
  )
)

=== Staff Directory
#user-story(
  title: "Staff Directory",
  id: "US-09",
  priority: "Should-have",
  description: "As a healthcare professional, I want to access a staff directory so that I can easily find and contact colleagues.",
  additions: (
    "Searchable staff list", 
    "Contact information", 
    "Department and role filters", 
    "Profile pictures"
  ),
  dependencies: (
    "User Authentication", 
    "Database/API for staff information"
  ),
  dod: (
    "Staff list loads correctly", 
    "Search functionality works", 
    "Contact information is accurate", 
    "Filters are functional"
  ),
  tasks: (
    "Design staff database schema",
    "Implement staff API",
    "Build staff directory UI",
    "Add search and filter functionality",
    "Integrate profile pictures",
    "Write unit and integration tests"
  )
)

=== Push Notifications
#user-story(
  title: "Push Notifications",
  id: "US-10",
  priority: "Must-have",
  description: "As a healthcare professional, I want to receive push notifications so that I am alerted to important events in real time.",
  additions: (
    "Real-time alerts for emergencies", 
    "Notifications for new messages", 
    "Reminders for tasks and appointments", 
    "Customizable notification settings"
  ),
  dependencies: (
    "Notification service", 
    "User Authentication", 
    "Database/API for events"
  ),
  dod: (
    "Notifications are received in real time", 
    "Alerts are displayed correctly", 
    "Users can customize notification preferences", 
    "Notifications are logged for reference"
  ),
  tasks: (
    "Set up push notification service",
    "Implement notification API",
    "Build notification UI",
    "Integrate with messaging and task systems",
    "Add user settings for notifications",
    "Write unit and integration tests"
  )
)

=== Document Upload
#user-story(
  title: "Document Upload",
  id: "US-11",
  priority: "Should-have",
  description: "As a healthcare professional, I want to upload medical documents so that patient records remain complete.",
  additions: (
    "Upload PDFs and images", 
    "Attach documents to patient records", 
    "Scan documents", 
    "Document versioning"
  ),
  dependencies: (
    "Patient Records", 
    "User Authentication", 
    "File storage service"
  ),
  dod: (
    "Documents can be uploaded successfully", 
    "Documents are attached to the correct patient records", 
    "Version history is maintained", 
    "Uploaded documents are accessible and viewable"
  ),
  tasks: (
    "Design document upload functionality",
    "Implement document upload API",
    "Build document upload UI",
    "Integrate with patient records system",
    "Add document versioning",
    "Write unit and integration tests"
  )
)

=== Automatic Document Processing
#user-story(
  title: "Automatic Document Processing",
  id: "US-12",
  priority: "Nice-to-have",
  description: "As a healthcare professional, I want the uploaded documents to be automatically processed and assigned to the patients record.",
  additions: (
    "Support OCR (Optical Character Recognition) to extract text from scanned documents.",
    "Automatically identify the patient based on document metadata or extracted information.",
    "Classify document types (e.g., laboratory report, discharge summary, prescription, referral letter).",
    "Allow users to review and correct automatically assigned documents before final confirmation.",
    "Flag documents with low confidence for manual review.",
    "Support common file formats such as PDF, JPG, and PNG."
  ),
  dependencies: (
    "Document Upload", 
    "OCR library/service", 
    "Machine learning model for document classification", 
    "Patient Records",
    "Secure storage for processed documents",
    "User Authentication"
  ),
  dod: (
    "Uploaded documents are automatically analyzed",
    "Extracted information is correctly associated with the appropriate pa-tient whenever possible",
    "Users can review and manually correct assignments before saving",
    "Low-confidence matches are clearly highlighted",
    "Processed documents are securely stored in the patient's record",
    "OCR and document classification achieve an acceptable accuracy level for supported document types"
  ),
  tasks: (
    "Integrate OCR library/service for text extraction",
    "Develop machine learning model for document classification",
    "Implement automatic patient identification and document classification logic",
    "Build user interface for reviewing and confirming document assignments",
    "Implement secure storage for processed documents",
    "Store extracted metadata and classification results in the database",
    "Handle processing errors and confidence scoring",
    "Conduct testing and validation of the automatic processing system"
  )
)

=== QR Code Patient Lookup
#user-story(
  title: "QR Code Patient Lookup",
  id: "US-13",
  priority: "Nice-to-have",
  description: "As a healthcare professional, I want to scan a QR code on a patient's wristband to quickly access their medical records.",
  additions: (
    "Scan QR codes using the device camera",
    "Automatically retrieve patient information from the database",
    "Display patient details in a user-friendly format",
    "Handle cases where the QR code is invalid or not recognized"
  ),
  dependencies: (
    "Patient Records", 
    "User Authentication", 
    "QR code generation and scanning library"
  ),
  dod: (
    "QR codes can be scanned successfully",
    "Patient information is retrieved and displayed correctly",
    "Invalid or unrecognized QR codes are handled gracefully",
    "Access permissions are enforced based on user roles"
  ),
  tasks: (
    "Integrate QR code scanning library",
    "Implement logic to retrieve patient information based on scanned QR code",
    "Build user interface for displaying patient details",
    "Add error handling for invalid or unrecognized QR codes",
    "Conduct testing to ensure accurate retrieval of patient records"
  )
)

=== Internal Voice Calls
#user-story(
  title: "Internal Voice Calls",
  id: "US-14",
  priority: "Nice-to-have",
  description: "As a healthcare professional, I want to make internal voice calls to colleagues within the app so that I can communicate quickly and securely.",
  additions: (
    "Initiate voice calls from the staff directory or chat interface",
    "Receive incoming voice calls with notifications",
    "Mute/unmute microphone during calls",
    "End calls gracefully and log call history"
  ),
  dependencies: (
    "User Authentication", 
    "Voice over IP (VoIP) service", 
    "Push notification service"
  ),
  dod: (
    "Voice calls can be initiated and received successfully",
    "Audio quality is clear and stable during calls",
    "Users can mute/unmute their microphone as needed",
    "Call history is logged for reference"
  ),
  tasks: (
    "Integrate VoIP service for voice call functionality",
    "Implement call initiation and reception logic",
    "Build user interface for voice call controls",
    "Add push notifications for incoming calls",
    "Conduct testing to ensure reliable voice communication"
  )
)

=== Incident Reporting
#user-story(
  title: "Incident Reporting",
  id: "US-15",
  priority: "Should-have",
  description: "As a healthcare professional, I want to report incidents so that they can be documented and addressed appropriately.",
  additions: (
    "Create incident reports with relevant details",
    "Attach photos or documents to incident reports",
    "Submit reports for review and follow-up",
    "Track the status of reported incidents"
  ),
  dependencies: (
    "User Authentication", 
    "Database/API for incident reports", 
    "Notification system"
  ),
  dod: (
    "Incident reports can be created and submitted successfully",
    "Attachments are uploaded and associated with the correct report",
    "Reports are reviewed and tracked through their lifecycle",
    "Notifications are sent for updates on reported incidents"
  ),
  tasks: (
    "Design incident report database schema",
    "Implement incident report API",
    "Build incident reporting UI",
    "Integrate attachment upload functionality",
    "Add status tracking and notifications for incident reports",
    "Conduct testing to ensure accurate reporting and tracking"
  )
)

=== Clinical Forms
#user-story(
  title: "Clinical Forms",
  id: "US-16",
  priority: "Should-have",
  description: "As a healthcare professional, I want to fill out clinical forms digitally so that patient information is recorded accurately and efficiently.",
  additions: (
    "Access and complete various clinical forms",
    "Save partially completed forms for later submission",
    "Submit completed forms to the appropriate department",
    "Receive confirmation of form submission"
  ),
  dependencies: (
    "User Authentication", 
    "Database/API for clinical forms", 
    "Notification system"
  ),
  dod: (
    "Clinical forms can be accessed and filled out successfully",
    "Partially completed forms can be saved and resumed later",
    "Completed forms are submitted and stored correctly",
    "Confirmation of submission is received by the user"
  ),
  tasks: (
    "Design clinical form templates and database schema",
    "Implement clinical form API",
    "Build clinical form UI with save and submit functionality",
    "Integrate notification system for submission confirmations",
    "Conduct testing to ensure accurate form handling and submission"
  )
)

=== Analytics Dashboard
#user-story(
  title: "Analytics Dashboard",
  id: "US-17",
  priority: "Nice-to-have",
  description: "As a healthcare administrator, I want to view an analytics dashboard so that I can monitor key performance indicators and make data-driven decisions.",
  additions: (
    "Visualize patient care metrics",
    "Track staff performance and workload",
    "Monitor incident reports and resolution times",
    "Generate reports for management review"
  ),
  dependencies: (
    "User Authentication", 
    "Database/API for analytics data", 
    "Data visualization library"
  ),
  dod: (
    "Analytics dashboard loads correctly with relevant data",
    "Visualizations are clear and informative",
    "Reports can be generated and exported",
    "Data is updated in real time or at regular intervals"
  ),
  tasks: (
    "Design analytics dashboard layout and components",
    "Implement analytics data API",
    "Integrate data visualization library for charts and graphs",
    "Build dashboard UI with interactive elements",
    "Add report generation and export functionality",
    "Conduct testing to ensure accurate data representation"
  )
)

=== Patient Timeline
#user-story(
  title: "Patient Timeline",
  id: "US-18",
  priority: "Should-have",
  description: "As a healthcare professional, I want to view a patient's timeline so that I can see their medical history and care progression at a glance.",
  additions: (
    "Chronological view of patient events",
    "Filter by event type (e.g., appointments, treatments, medications)",
    "View detailed information for each event",
    "Add new events to the timeline"
  ),
  dependencies: (
    "Patient Records", 
    "User Authentication", 
    "Database/API for patient events"
  ),
  dod: (
    "Patient timeline loads correctly with all relevant events",
    "Events can be filtered and sorted as needed",
    "Detailed information is accessible for each event",
    "New events can be added and displayed on the timeline"
  ),
  tasks: (
    "Design patient timeline layout and components",
    "Implement patient event API",
    "Build timeline UI with filtering and sorting functionality",
    "Integrate event detail view and add new event functionality",
    "Conduct testing to ensure accurate timeline representation"
  )
)

=== Search and Filter
#user-story(
  title: "Search and Filter",
  id: "US-19",
  priority: "Must-have",
  description: "As a healthcare professional, I want to search and filter patient records so that I can quickly find the information I need.",
  additions: (
    "Search by patient name, ID, or other identifiers",
    "Filter by department, condition, or treatment type",
    "Sort results by relevance or date",
    "Save frequently used search queries"
  ),
  dependencies: (
    "Patient Records", 
    "User Authentication", 
    "Database/API for search functionality"
  ),
  dod: (
    "Search functionality returns accurate results",
    "Filters can be applied and combined effectively",
    "Results can be sorted as specified",
    "Frequently used searches can be saved and reused"
  ),
  tasks: (
    "Implement search API with relevant query parameters",
    "Build search and filter UI components",
    "Integrate sorting functionality for search results",
    "Add feature to save and manage frequently used searches",
    "Conduct testing to ensure accurate and efficient search performance"
  )
)

=== Role-Based Access Control
#user-story(
  title: "Role-Based Access Control",
  id: "US-20",
  priority: "Must-have",
  description: "As a healthcare administrator, I want to manage user roles and permissions so that access to sensitive information is controlled.",
  additions: (
    "Define user roles (e.g., nurse, doctor, admin)",
    "Assign permissions based on roles",
    "Restrict access to sensitive patient information",
    "Audit user activity and access logs"
  ),
  dependencies: (
    "User Authentication", 
    "Database/API for role management", 
    "Security protocols"
  ),
  dod: (
    "User roles can be created and managed successfully",
    "Permissions are enforced based on assigned roles",
    "Access to sensitive information is restricted appropriately",
    "User activity and access logs are maintained for auditing"
  ),
  tasks: (
    "Design role-based access control schema",
    "Implement role management API",
    "Build UI for managing user roles and permissions",
    "Integrate security protocols for access control",
    "Add auditing functionality for user activity and access logs",
    "Conduct testing to ensure proper enforcement of access controls"
  )
)

=== Audit Logging
#user-story(
  title: "Audit Logging",
  id: "US-21",
  priority: "Must-have",
  description: "As a healthcare administrator, I want to maintain audit logs of user actions so that we can track changes and ensure accountability.",
  additions: (
    "Log user actions such as logins, data access, and modifications",
    "Store logs securely and protect against tampering",
    "Provide search and filtering capabilities for audit logs",
    "Generate reports for compliance and review"
  ),
  dependencies: (
    "User Authentication", 
    "Database/API for logging", 
    "Security protocols"
  ),
  dod: (
    "User actions are logged accurately and in real time",
    "Logs are stored securely and protected from tampering",
    "Search and filtering functionality is available for audit logs",
    "Reports can be generated for compliance and review purposes"
  ),
  tasks: (
    "Implement logging API to capture user actions",
    "Design secure storage for audit logs",
    "Build UI for viewing and searching audit logs",
    "Add reporting functionality for compliance review",
    "Conduct testing to ensure accurate logging and secure storage"
  )
)

=== Offline Mode
#user-story(
  title: "Offline Mode",
  id: "US-22",
  priority: "Should-have",
  description: "As a healthcare professional, I want to access patient records and perform essential tasks even when offline so that I can continue working during network outages.",
  additions: (
    "Cache patient records and essential data locally",
    "Allow users to view and edit records while offline",
    "Sync changes with the server once connectivity is restored",
    "Provide feedback on sync status and conflicts"
  ),
  dependencies: (
    "Patient Records", 
    "User Authentication", 
    "Local storage solution", 
    "Syncing mechanism"
  ),
  dod: (
    "Essential data is available offline",
    "Users can make changes while offline",
    "Changes are synced correctly when back online",
    "Sync status and conflicts are communicated to the user"
  ),
  tasks: (
    "Implement local caching for essential data",
    "Build offline editing capabilities",
    "Develop syncing mechanism for changes",
    "Add UI feedback for sync status and conflict resolution",
    "Conduct testing to ensure reliable offline functionality"
  )
)

#pagebreak()

== Wireframes
#wireframe-box(
  title: "Login",
  img-path: "images/wireframes/login.png",
  "The login page allows registered users to access their user accounts. To do so, they enter their username and password. New companies can join the Nursery family by clicking the \"Request Access as an Organization\" button. \nAfter successfully logging in, the user is redirected to the app's dashboard."
)

= Tools
== Programming language and used Version
The application was developed using the Flutter framework in the Dart programming language. Flutter enables the development of cross-platform applications from a single codebase for Android, iOS, the web, and desktop systems.

Versions used at the time of development:

#list(
  [*Programming Language*: Dart 3.14.0],
  [*Framework*: Flutter 3.50.0]
)

== Development Environment
The application was developed in a development environment that includes the following tools and technologies:

#list(
  [*IDE*: Visual Studio Code],
  [*Version Control*: Git],
  [*Database*: Supabase],
  [*Platform*: Android, iOS, Web and Desktop],
  [*Testing*: Flutter Driver, Widget Tests],
  [*CI/CD*: GitHub Actions]
)

== Important Dependencies
The application relies on several important dependencies to provide its functionality. These dependencies include:

#list(
  [*Backend and Data Management*: supabase_flutter: ^2.12.2],
  [*Localization*: flutter_localizations],
  [*Design*: google_fonts: ^6.2.1],
  [*Testing*: flutter_test and flutter_lints: ^6.0.0]
)

== Sources and Licenses
The application uses the following sources and licenses:

#list(
  [*Image-Assets*: Created by Toni Fey, All Rights Reserved],
  [*Fonts*: Font Roboto by Christian Robertson, SIL Open Font License, Version 1.1],
  [*Icons*: Material Icons by Google, Apache License 2.0]
)

= Project Architecture
== Description of the Overall Architecture
The application follows a modular architecture that separates concerns into distinct layers, promoting maintainability, scalability, and testability. The architecture consists of the following key components:

#list(tight: false,
  [*Presentation Layer*: This layer is responsible for the user interface and user experience. It includes screens, widgets, and UI components that interact with the user. The presentation layer communicates with the business logic layer to retrieve and display data.],
  [*Business Logic Layer*: This layer contains the core application logic, including state management, data processing, and decision-making. It handles user interactions, validates input, and coordinates between the presentation layer and data access layer.],
  [*Data Access Layer*: This layer manages data retrieval and storage. It interacts with external services, databases, and APIs to fetch and persist data. The data access layer abstracts the underlying data sources, providing a consistent interface for the business logic layer.],
  [*Service Layer*: This layer provides additional services such as authentication, notifications, and analytics. It encapsulates external dependencies and provides reusable functionality across the application.]
)

#pagebreak()

== Database architecture in Supabase
The application uses Supabase as its backend service, which provides a PostgreSQL database along with authentication, storage, and real-time capabilities. The database architecture is designed to support the application's data requirements and ensure efficient data management. 

```pintora
erDiagram
  userData {
    id int PK
    created_at timestamptz
    company text
    role text
    birthday date
    first_name text
    last_name text
  }

  wardData {
    id int PK
    name text
    currentCapacity int4
    maxCapacity int4
    ResidentialAreaManager uuid FK
  }

  auth.users {
    uid uuid PK
    displayName text
    email text
    phone text
  }

  auth.users }|--|{ wardData : "wardData.ResidentialAreaManagement → auth.user.uid"
  userData |o--|| auth.users : "userData.id → auth.user.uid"
```
*Note:* The `auth.users` table is managed by Supabase and is used for authentication purposes. The table is simplified in this diagram to show its relationship with the other table.

== Class Diagram
The class diagram shows the main classes of the current Flutter application. The widgets form the presentation layer, `AuthGate` controls the transition between the login screen and the dashboard, and the Supabase client handles authentication and data access.

```pintora
classDiagram

  class Nursery {
    +build(context) Widget
  }

  class MyHomePage {
    +title String
  }

  class AuthGate {
    +onAuthStateChanged ValueChanged~bool~
    +build(context) Widget
  }

  class LoginScreen {
    +onLoginSuccess VoidCallback
    +signInWithEmail(email, password) Future
  }

  class RegisterPage {
    +onLoginSuccess VoidCallback
    +signUpWithEmail(email, password, organization, name) Future
  }

  class Dashboard {
    +onLogout VoidCallback
    +getUserName() Future
    +build(context) Widget
  }

  class UserMenuPage {
    +onLogout VoidCallback
    +getUserName() Future
    +logOut() Future
  }

  class DashboardInfoCard {
    +label String
    +value String
    +onTap VoidCallback
  }

  class AlertCard {
    +title String
    +subtitle String
    +description String
    +onTap VoidCallback
  }

  class Timeline {
    +title String
    +children List~Widget~
  }

  class TimelineItem {
    +child Widget
  }

  class AppLocale {
    +localeNotifier ValueNotifier~Locale?~
    +setLocale(locale) void
  }

  class SupabaseClient {
    +auth GoTrueClient
    +from(table) PostgrestQueryBuilder
  }

  class UserData {
    +id uuid
    +company String
    +role String
    +firstName String
    +lastName String
  }

  Nursery *-- MyHomePage : starts
  MyHomePage *-- AuthGate : contains
  AuthGate ..> LoginScreen : shows when unauthenticated
  AuthGate ..> Dashboard : shows when authenticated
  LoginScreen ..> RegisterPage : opens
  Dashboard *-- DashboardInfoCard : contains
  Dashboard *-- AlertCard : contains
  Dashboard *-- Timeline : contains
  Timeline *-- TimelineItem : contains
  Dashboard ..> UserMenuPage : opens
  LoginScreen ..> SupabaseClient : authenticates
  RegisterPage ..> SupabaseClient : registers
  Dashboard ..> SupabaseClient : reads profile
  UserMenuPage ..> SupabaseClient : reads profile and signs out
  SupabaseClient ..> UserData : persists
  Nursery ..> AppLocale : observes
```

= Testing
== Unit Testing
Unit testing is a software testing technique that focuses on verifying the functionality of individual components or units of code in isolation. In the context of the Nursery application, unit tests are written to ensure that each function, method, or class behaves as expected under various conditions. These tests help identify bugs early in the development process and provide confidence that the code works correctly.

== Manual Testcases
Manual test cases are a set of predefined steps and expected outcomes that testers follow to verify the functionality of the Nursery application. These test cases are executed manually by testers to ensure that the application meets its requirements and behaves as intended. Each test case includes a description of the test scenario, the steps to perform, the expected results, and any necessary preconditions or data.

= Challenges and their solutions
== Challenge 1: Ensuring Data Security and Privacy
== Challenge 2: Handling Offline Functionality
== Challenge 3: Managing and Maintaining the Application

= Current Status and Future Plans
== Current Status
== Future Plans

= Outlook

= Conclusion