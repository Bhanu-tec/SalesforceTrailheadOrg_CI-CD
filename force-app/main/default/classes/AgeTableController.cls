public class AgeTableController {
    public List<AgeData> ageData { get; set; }

    public AgeTableController() {
        ageData = new List<AgeData>();
        // Populate ageData with sample data
        ageData.add(new AgeData('0-10', 5));
        ageData.add(new AgeData('11-20', 10));
        ageData.add(new AgeData('21-30', 15));
        // Add more data as needed
    }

    public class AgeData {
        public String AgeRange { get; set; }
        public Integer Count { get; set; }

        public AgeData(String ageRange, Integer count) {
            AgeRange = ageRange;
            Count = count;
        }
    }
}