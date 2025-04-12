# DocPilot - AI-Powered Electronic Medical Record System

DocPilot is a revolutionary EMR application that leverages conversational AI to transform doctor-patient interactions. Traditional EMR systems are outdated, expensive, and cumbersome to use, leading to resistance from medical professionals. DocPilot solves these problems by listening to consultations in real-time, automatically extracting relevant medical information, and generating prescriptions that doctors can simply review, sign, and save digitally.

## Table of Contents

- [Project Overview](#project-overview)
- [Key Features](#key-features)
- [System Architecture](#system-architecture)
- [UI Design](#UI-Design)
- [Technology Stack](#technology-stack)
- [Setup Guide](#setup-guide)
- [User Workflows](#user-workflows)
- [Integration Details](#integration-details)
- [Data Flow and Storage](#data-flow-and-storage)
- [Deployment Strategy](#deployment-strategy)
- [Contributing](#contributing)
- [License](#license)

## Project Overview

Healthcare documentation remains stuck in the past, with the last major innovation in EMR systems dating back to the 1990s. Doctors struggle with complex, expensive software that diverts their attention away from patients and creates administrative burden. DocPilot introduces a paradigm shift by:

- **Automating documentation** through advanced conversational AI
- **Simplifying the user experience** for medical professionals
- **Reducing operational costs** compared to traditional EMR systems
- **Increasing accuracy** of medical records
- **Saving valuable time** for healthcare providers

The application passively listens to doctor-patient consultations, intelligently extracts critical medical information (symptoms, diagnoses, medications, tests), and automatically generates prescription documents ready for doctor review and approval. Additionally, it integrates comprehensive OPD appointment management to provide a complete clinical workflow solution.

### Key Value Propositions

- **Reduce documentation burden** by automating the creation of medical records and prescriptions
- **Improve patient experience** through faster consultations with more face-to-face interaction
- **Enhance clinical accuracy** via systematic extraction of medical information
- **Generate actionable insights** from aggregated medical data
- **Ensure regulatory compliance** by maintaining comprehensive, standardized records

## Key Features

### 1. AI-Powered Consultation Transcription

- Real-time audio processing of doctor-patient conversations
- Automatic differentiation between speakers
- Support for multiple languages and medical dialects
- Privacy-focused processing with data security measures
- Noise filtering and acoustic optimization for clinical environments

### 2. Intelligent Medical Information Extraction

- Automatic identification of reported symptoms
- Recognition of diagnostic conclusions
- Extraction of prescribed medications with dosage details
- Documentation of ordered laboratory and imaging tests
- Capture of follow-up instructions and recommendations

### 3. Automated Prescription Generation

- Creation of standardized prescription documents
- Integration of patient demographic information
- Automatic inclusion of drug information and dosing instructions
- Support for digital signature and authentication
- Options for printing or digital sharing with patients

### 4. OPD Appointment Management

- Scheduling interface for patient appointments
- Waitlist management and queue optimization
- Appointment reminders and notifications
- Visit history tracking and retention
- Resource allocation and clinic management tools

### 5. Clinical Analytics Dashboard

- Provider productivity metrics
- Treatment pattern analysis
- Prescription trend monitoring
- Patient flow visualization
- Operational efficiency reporting

## System Architecture

![Image](https://github.com/user-attachments/assets/92ab764b-8f80-470d-b62d-d33148abd1cf)

Link of the diagram - https://app.eraser.io/workspace/uH9HKVssowZErmxsQak8

### High-Level Architecture Overview

DocPilot follows a microservices architecture with the following key components:

**Mobile Application Layer**
- Flutter-based cross-platform user interface
- Responsive design for various device form factors
- Offline capability with synchronization
- Secure authentication and authorization

**API Gateway Layer**
- Handles all communication between frontend and backend services
- Manages authentication and request routing
- Implements rate limiting and request validation
- Provides unified interface for diverse microservices

**Core Processing Engine**
- Orchestrates workflows between different services
- Manages the processing queue for asynchronous tasks
- Handles context management for ongoing consultations
- Coordinates data flow between components

**AI Service Layer**
- Speech-to-text conversion for consultation recording
- Natural language understanding for medical context
- Named entity recognition for medical terms
- Knowledge retrieval system for medication information
- Document generation for prescriptions and reports

**Integration Services**
- Pharmacy system connections
- Laboratory test ordering interfaces
- Hospital information system bridges
- Insurance verification endpoints
- Regulatory compliance reporting

**Data Storage Layer**
- Vector database for semantic search functionality
- Relational database for structured patient data
- Document store for consultation transcripts and prescriptions
- Secure patient information repository with encryption

## UI Design
![image](https://github.com/user-attachments/assets/67bbed21-9d6e-4e38-8808-36f66a69d9e8)
![image](https://github.com/user-attachments/assets/5d8fc572-e469-4263-8fe5-8ced272034a6)
![image](https://github.com/user-attachments/assets/1eca018b-4278-411f-8648-cb7071a55752)
![image](https://github.com/user-attachments/assets/8d250a30-6232-41bc-be3c-d8da582ab45d)
![image](https://github.com/user-attachments/assets/8dae2537-3999-4aa5-81ff-9145734179c0)


## Technology Stack

### Frontend Components
- **Framework**: Flutter + Dart
- **State Management**: Provider/Bloc
- **UI Components**: Material Design/Custom Medical UI Kit
- **Offline Support**: Hive/SQLite

### Backend Services
- **Core Framework**: Node.js/Express or FastAPI
- **Containerization**: Docker & Kubernetes
- **Messaging Queue**: RabbitMQ
- **Task Scheduling**: Celery

### AI Components
- **Speech Recognition**: Custom-trained medical speech models
- **NLP Processing**: Medical-domain fine-tuned language models
- **Entity Extraction**: Custom NER models for medical entities
- **Document Generation**: Template-based with dynamic content

### Data Storage
- **Backend Platform**: Appwrite
- **Database**: Appwrite Database (Document/Collection based)
- **Authentication**: Appwrite Auth
- **Storage**: Appwrite Storage for documents and media
- **Functions**: Appwrite Functions for serverless operations

### DevOps & Infrastructure
- **CI/CD**: GitHub Actions
- **Monitoring**: Prometheus/Grafana
- **Logging**: ELK Stack
- **Cloud Deployment**: Flexible deployment options (AWS/GCP/Azure)

## Setup Guide

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Node.js 16+ (for backend services)
- Docker and Docker Compose
- Appwrite account and project setup
- Firebase project (optional, for analytics)

### Local Development Setup

1. Clone the repository:
```bash
git clone https://github.com/prakharsingh-74/Docpilot.git
cd Docpilot
```

2. Set up the Flutter application:
```bash
cd mobile_app
flutter pub get
```

3. Configure Appwrite:
```bash
# Create a .env file with your Appwrite credentials
touch .env
# Add the following to the .env file:
# APPWRITE_ENDPOINT=your_appwrite_endpoint
# APPWRITE_PROJECT_ID=your_project_id
# APPWRITE_API_KEY=your_api_key
```

4. Run the application:
```bash
flutter run
```

### Backend Services Setup

1. Navigate to the backend directory:
```bash
cd backend
```

2. Install dependencies:
```bash
npm install
# or if using Poetry for Python backend
poetry install
```

3. Start the services with Docker Compose:
```bash
docker-compose up -d
```

### AI Model Setup

1. Download pre-trained models:
```bash
cd ai_models
./download_models.sh
```

2. Test the AI pipeline:
```bash
python test_pipeline.py
```

## User Workflows

### Doctor Consultation Workflow

```
stateDiagram-v2
    [*] --> LoginAuthentication
    LoginAuthentication --> PatientSelection
    PatientSelection --> NewPatient: Create New
    PatientSelection --> ExistingPatient: Select Existing
    NewPatient --> PatientDetails
    PatientDetails --> ConsultationRecording
    ExistingPatient --> ReviewHistory
    ReviewHistory --> ConsultationRecording
    ConsultationRecording --> AIProcessing
    AIProcessing --> ReviewPrescription
    ReviewPrescription --> EditPrescription: Modifications Needed
    ReviewPrescription --> FinalizePrescription: Approve
    EditPrescription --> FinalizePrescription
    FinalizePrescription --> DeliveryOptions
    DeliveryOptions --> Print
    DeliveryOptions --> DigitalShare
    DeliveryOptions --> SaveOnly
    Print --> ConsultationComplete
    DigitalShare --> ConsultationComplete
    SaveOnly --> ConsultationComplete
    ConsultationComplete --> [*]
```

**Explanation:**
1. Doctor logs into the system with secure authentication
2. Selects existing patient or creates new patient record
3. For existing patients, reviews medical history before consultation
4. Initiates consultation recording when patient interaction begins
5. AI processes the conversation in real-time
6. Doctor reviews the auto-generated prescription
7. Makes any necessary edits or approves as-is
8. Selects delivery method (print, digital share, or save only)
9. Completes the consultation and prepares for next patient

### Patient Registration Workflow

```
stateDiagram-v2
    [*] --> ReceptionistInterface
    ReceptionistInterface --> PatientIdentification
    PatientIdentification --> ExistingPatient: Found in System
    PatientIdentification --> NewPatientRegistration: Not Found
    NewPatientRegistration --> BasicInformation
    BasicInformation --> ContactDetails
    ContactDetails --> InsuranceInformation
    InsuranceInformation --> ConsentForms
    ConsentForms --> QueueAssignment
    ExistingPatient --> VerifyUpdateInformation
    VerifyUpdateInformation --> QueueAssignment
    QueueAssignment --> WaitingRoom
    WaitingRoom --> ConsultationPreparation
    ConsultationPreparation --> DoctorConsultation
    DoctorConsultation --> [*]
```

### Appointment Management Workflow

```
stateDiagram-v2
    [*] --> CheckSchedule
    CheckSchedule --> SlotAvailable: Open Slots
    CheckSchedule --> Waitlist: No Immediate Slots
    SlotAvailable --> BookAppointment
    BookAppointment --> SendConfirmation
    SendConfirmation --> ReminderSystem
    ReminderSystem --> AppointmentDay
    Waitlist --> NotifyWhenAvailable
    NotifyWhenAvailable --> BookAppointment: Slot Opens
    AppointmentDay --> CheckIn
    CheckIn --> ConsultationProcess
    ConsultationProcess --> FollowUpBooking
    FollowUpBooking --> [*]
```

## Integration Details

### Pharmacy Systems Integration

DocPilot offers seamless integration with pharmacy management systems to enable:
- Direct prescription transmission to patient-preferred pharmacies
- Medication availability checks in real-time
- Generic alternative suggestions based on inventory
- Prescription fill status tracking
- Medication interaction warnings based on patient history

### Laboratory Systems Integration

Connections to laboratory information systems provide:
- Electronic lab test ordering
- Digital results delivery directly to patient records
- Abnormal result highlighting and notifications
- Historical test result comparisons
- Integrated billing for laboratory services

### Hospital Information Systems

For hospital-based deployments, DocPilot integrates with:
- Admission, discharge, transfer (ADT) systems
- Inpatient EMR platforms
- Radiology information systems
- Billing and revenue cycle management
- Bed management and resource allocation

## Data Flow and Storage

### Data Collection and Processing

```
flowchart TB
    subgraph "Audio Input"
        MIC["Microphone"]
        REC["Recording Module"]
    end
    
    subgraph "Processing Pipeline"
        STT["Speech-to-Text"]
        NLP["NLP Processing"]
        NER["Named Entity Recognition"]
        DOC["Document Generation"]
    end
    
    subgraph "Storage Layer"
        AW["Appwrite"]
        subgraph "Appwrite Services"
            DB["Database"]
            ST["Storage"]
            AUTH["Authentication"]
        end
    end
    
    subgraph "Output Channels"
        UI["User Interface"]
        PRINT["Printing Service"]
        SHARE["Digital Sharing"]
    end
    
    MIC --> REC
    REC --> STT
    STT --> NLP
    NLP --> NER
    NER --> DOC
    DOC --> UI
    DOC --> DB
    UI --> PRINT
    UI --> SHARE
    UI --> ST
```

### Data Security and Privacy

DocPilot implements comprehensive security measures to protect sensitive patient information:

- End-to-end encryption for all data in transit
- HIPAA-compliant storage solutions
- Role-based access controls
- Audit logging for all data access
- Automated data retention policies
- Patient consent management
- De-identification protocols for research data
- Regular security audits and penetration testing

## Deployment Strategy

### Cloud Deployment

DocPilot supports flexible cloud deployment options:

1. **Fully Managed SaaS Solution**
   - Subscription-based model for smaller practices
   - Automatic updates and maintenance
   - Scalable resources based on practice size
   - Managed backups and disaster recovery

2. **Private Cloud Deployment**
   - For larger healthcare organizations with existing infrastructure
   - Integration with corporate identity management
   - Custom security policies implementation
   - Dedicated resources and performance tuning

3. **Hybrid Models**
   - Mixed on-premises and cloud deployment
   - Gradual migration path from legacy systems
   - Data sovereignty compliance for regulated markets
   - Business continuity and redundancy options

### On-Premises Options

For healthcare facilities with strict data locality requirements:

- Containerized deployment with Kubernetes
- Hardware specification guidelines for optimal performance
- Air-gapped installation options for high-security environments
- Local backup and recovery procedures
- Update management through controlled channels

## Contributing

We welcome contributions to the DocPilot project! Please follow these steps to contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

Please read our [Contributing Guidelines](CONTRIBUTING.md) for more details.

### Development Environment

We recommend using the following tools for development:
- Visual Studio Code with Flutter extensions
- Android Studio for mobile testing
- Postman for API testing
- Docker Desktop for containerized services

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

© 2025 DocPilot. All rights reserved.
