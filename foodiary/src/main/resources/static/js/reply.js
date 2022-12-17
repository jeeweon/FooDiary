//함수 형태로 컴포넌트를 구현(functional component) -> this 사용X
const ListView = (props)=>{
    //props.list, props.loading라는 이름으로 데이터가 전달된다
    if(props.loading) { //로딩중
        return (
            <>
                <div>
                    <h2>Loading...</h2>
                </div>
            </>
        )
    }
    else if(props.list == undefined || props.list.length == 0) {//데이터가 없는 경우
        return (
            <>
                <div>
                    <h2>"댓글을 남겨주세요"</h2>
                </div>
            </>
        )
    }
    else {//데이터가 있는 경우
        const html = props.list.map(reply=>(
            <div key={reply.replyNo}>
                <p>
                    댓글번호 : {reply.replyNo}, 
                    회원 : {reply.memNo}, 작성일 : {reply.replyWriteTime}, 
                    내용 : {reply.replyContent}
                </p>
            </div>
        ));
        return (
            <>
                <div>
                    {html}
                </div>
            </>
        )
    }
};
const MainComponent = ()=> {
    //state
    //state 설정 시, 기본값(초기값)을 지정해줘야 함
    //- 이후, 데이터 불러와서 채워주는 것
    //- 배열의 기본값 = [] 빈 배열
    //- 객체의 기본값 = {} 빈 객체
    const [replyList, setReplyList] = React.useState([ ]);   //[] 빈 배열

    const [loading, setLoading] = React.useState(false);

    //effect(최초 1회)
    const loadList = ()=>{

        setLoading(true);

        axios.get("http://localhost:8888/rest/reply/list/"+168)
        .then(respObject=>{
            console.log(respObject);
            
            //const resp = respObject.data;
            //setPkmList(resp.data);
            setReplyList(respObject.data);

            //setLoading(false);    //◆ setLoading 각각 처리 (1)
        })
        //.catch(e=>{
        //    window.alert("에러 발생");
        //    setLoading(false);    ◆ setLoading 각각 처리 (2)
        //});
        .catch(e=>{})
        .finally(()=>{  //finally : error상관없이 무조건 실행 → 각각 처리하기 싫다면, finally로 처리
            setLoading(false);  //◆ setLoading 를 finally로 처리 (1+2)
        });

    };
    //React.useEffect(()=>loadList(), []);
    React.useEffect(loadList, [ ]);

    return (
        <>
            <h1>댓글 목록</h1>
            <hr/>
            {/* 댓글 출력 */}
            <ListView list={replyList} loading={loading}/>
        </>
    );
};

const app = ReactDOM.createRoot(document.querySelector("#reply"));
app.render(<MainComponent/>);