# iOSInterviewPreparation
This will help people to crack iOS interviews with examples

**Class vs Struct:**
   +-------------+          +--------------+
   |   STRUCT    |          |    CLASS     |
   +-------------+          +--------------+
   | Value type  |   vs     | Reference    |
   | Copied      |          | Shared       |
   | Safer       |          | Mutable      |
   | Models      |          | ViewModels   |
   +-------------+          +--------------+

**UsersListAPI:**
SwiftUI View
     |
     v
ViewModel ---- calls ----> NetworkManager ----> GitHub API
     |                         |
     |<----- returns -----------+
     v
 Updates UI
