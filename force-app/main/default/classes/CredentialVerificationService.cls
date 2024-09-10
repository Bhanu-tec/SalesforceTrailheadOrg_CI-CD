global class CredentialVerificationService {
    webService static String verifyCredential(String lastName, String certificationName) {
        if (String.isBlank(lastName) || String.isBlank(certificationName)) {
            return 'No record found';
        }

        // Query for active and inactive certifications
        List<Contact_Certification__c> contactCertifications = [
            SELECT Name, Contact__r.LastName, Certification__r.Name, isActive__c
            FROM Contact_Certification__c
            WHERE Contact__r.LastName = :lastName
              AND Name = :certificationName
            LIMIT 1
        ];

        if (contactCertifications.isEmpty()) {
            return 'No record found';
        }

        Contact_Certification__c contactCertification = contactCertifications[0];
        if (contactCertification.isActive__c) {
            return 'Valid';
        } else {
            return 'Needs Renewal';
        }
    }
}