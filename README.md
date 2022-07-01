# Scan-F : Zero-contact Biometric System

**Scan-F** is a biometric attendance system that reduces unwanted inter-human contact. It is built with the COVID-19 pandemic in mind, and it provides a safe, efficient way to record attendance. 

## Whats new in our system 😮:
- Existing systems use a single fingerprint sensor, mounted on a wall to record the attendance. This single sensor will be used by hundreds of people and it is not safe considering the pandemic situation.
- Our solution is **inbuilt fingerprint sensor in mobile phones**. These fingerprint sensors can be used to record individual person’s attendance. 
- By this method, every person will have their own sensor for giving their attendance. In other words, a person's fingerprint sensor will not be used by another for recording attendance

## Components 🔨:
- ESP8266 board to create local WIFI network. This WIFI network is used to check whether the person is in the right place, while giving the attendance and prevents malpractice.
- A Mobile application, made using Flutter. It helps the person in authenticating using the inbuilt fingerprint sensor.
- Cloud Firestore, an online database. This database is used to store all the attendance data.

## Screenshots 🏃:
#### [Mobile Application](https://github.com/rahulv07/scanf/tree/master/scanf) 
  <table>
      <tr>
       <td><img src="https://user-images.githubusercontent.com/73294587/176865171-53b0a41e-6be1-4cec-8796-6b0d39f5a5a7.png" height="450" width="250"></td>
       <td><img src="https://user-images.githubusercontent.com/73294587/176865612-d613171d-f9a8-44cc-9aa5-923013f05f1e.png" height="450" width="250"></td>
       <td><img src="https://user-images.githubusercontent.com/73294587/176867590-5a1ae0b7-fcf4-4dee-980c-078938a19195.png" height="450" width="250"></td>
      </tr>
  </table>
  
 #### Firestore Console
  <table>
       <tr>
       <td><img src="https://user-images.githubusercontent.com/73294587/176865881-4abae5f7-f7f6-4b8d-be5f-d596886f9393.png" width="800"></td>
      </tr>
  </table>
