import Foundation

struct DataModel {
    let adult: Bool
    let id: Int
    let title: String?
    
    /// 이미지 URL path
    let posterPath: String?
    
    /// 설명
    let overview: String?
    let releaseDate: Date?
}


class DBData {
    var datas: [DataModel] = []
    
    init () {
        self.datas = makeData()
    }
    
    private func fetch() {
        let datas = makeData()
        self.datas = datas
    }
    
    private func makeData() -> [DataModel] {
        var datas: [DataModel] = []
        let data = DataModel(adult: false, id: 588228, title: "투모로우 워", posterPath: "/34nDCQZwaEvsy4CFO5hkGRFDCVU.jpg", overview: "현재로 긴급 메시지를 전하기 위해 2051년에서 온 한 무리의 시간 여행자들이 도착한다. 메세지의 내용은 30년 동안 미래 인류가 치명적인 외계 종족과 세계 전쟁에서 지고 있다는 것. 인류가 생존할 수 있는 유일한 희망은 현재 세계의 군인과 민간인들이 미래로 보내서 전쟁에 참여하는 것이다. 어린 딸을 위해 세상을 구하기로 결심한 댄 포레스터는 지구의 운명을 다시 쓰기 위해 뛰어난 과학자와 사이가 멀어진 아버지와 함께 팀을 이룬다.", releaseDate: Date())
        
        let data2 = DataModel(adult: false, id: 436969, title: "더 수어사이드 스쿼드", posterPath: "/1FiLuxuowOusZAG1vvI4TorMuNG.jpg", overview: "최고의 사망률을 자랑하는 벨 리브 교도소. 미국 정보국 월러 국장(비올라 데이비스)은 태스크 포스 X라는 극비 군사 작전팀을 꾸리기 위해 이곳에 왔다. 그녀는 수감 중인 슈퍼 빌런들을 팀에 합류시키기 위해 사면이나 감형을 조건으로 제시한다. 또한 만약을 대비해 언제라도 이들을 처형할 수 있게 머리에 폭탄도 심어놓는다. 우여곡절 끝에 완성된 팀은 두개로 나뉘어 남미의 작은 섬나라 코르토 몰티즈로 향한다. 이들의 임무는 이 섬에 위치한 요툰하임이라는 비밀 연구실에 잠입해 스타피쉬의 흔적을 없애는 것. 각기 다른 해안가에 도착한 두 팀은 상반된 상황을 맞이한다.", releaseDate: Date())
        
        let data3 = DataModel(adult: false, id: 566525, title: "샹치와 텐 링즈의 전설", posterPath: "/34nDCQZwaEvsy4CFO5hkGRFDCVU.jpg", overview: "초인적인 능력을 가진 텐 링즈의 힘으로 수세기 동안 어둠의 세상을 지배해 온 웬우. 샹치는 아버지 웬우 밑에서 암살자로 훈련을 받았지만 이를 거부하고 평범함 삶을 선택한다. 그러나 샹치는 목숨을 노리는 자들의 습격으로 더 이상 운명을 피할 수 없다는 것을 직감하고, 어머니가 남긴 가족의 비밀과 내면의 신비한 힘을 일깨우게 된다.", releaseDate: Date())

        datas.append(data)
        datas.append(data2)
        datas.append(data3)
        
        return datas
    }
    
}
