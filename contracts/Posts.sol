// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Blog{
    address public owner;
   
    uint public postCounter;
    mapping(uint=>address) public authorOf;
    mapping(address=>uint) public postsOf;
    mapping(uint=>bool) public postExist;

    enum Deactivated{
        NO,YES
    }

    struct PostStruct{
        uint id;
        string title;
        string description;
        address author;
        Deactivated deleted;
        uint created;
        uint updated;
    }

    PostStruct[] activePosts;
    PostStruct[] inactivePosts;

    event Action(
        uint id,
        string actionType,
        address indexed executor,
        uint timestamp
    );

    modifier ownerOnly{
        require(msg.sender == owner,"Reserved for Owner only");
        _;
    }
    constructor(){
        owner = msg.sender;
    }

    function createPosts(string memory title,string memory description) public returns (bool) {
        require(bytes(title).length>0,"Title cannot be empty");
        require(bytes(description).length>0,"Description cannot be empty");
        postCounter++;
        authorOf[postCounter] = msg.sender;
        postsOf[msg.sender]++;
        postExist[postCounter] = true;
        activePosts.push(
            PostStruct(
                postCounter,
                title,
                description,
                msg.sender,
                Deactivated.NO,
                block.timestamp,
                block.timestamp
            )
        );

        emit Action(postCounter,"Post Created",msg.sender,block.timestamp);
        return true;
    }

    function updatePost(
        uint id,
        string memory title,
        string memory description

    )public returns (bool){
        require(postExist[id],"Blog Post not found");
        require(bytes(title).length>0,"Title can not be empty");
        require(bytes(description).length>0,"Description cannot be empty");
        require(msg.sender == activePosts[id-1].author,"Reserved for author only");
        activePosts[id -1] .title = title;
        activePosts[id - 1].description = description;
        activePosts[id - 1].updated = block.timestamp;

        emit Action(
            id,"POST UPDATED",
            msg.sender,block.timestamp
        );
        return true;
    }

    function showPost(uint id) public view returns (PostStruct memory){
        return activePosts[id - 1];
    }

    function getPosts() public view returns (PostStruct[] memory){
        return activePosts;
    }

    function getActivePosts() public view returns (PostStruct[] memory posts){
        posts = new PostStruct[](postCounter);
       
        for(uint i=0;i<activePosts.length;i++){
            if(activePosts[i].deleted != Deactivated.NO){
                posts[i] = activePosts[i];
            }
        }

        return posts;
    }


    function deletePost(uint id) public returns (bool){
        require(postExist[id],"Blog not found");
        require(msg.sender == activePosts[id-1].author,"Reserved for author only");

        activePosts[id-1].deleted = Deactivated.YES;

        emit Action(
            id,
            "POST DELETED",
            msg.sender,
            block.timestamp
        );
        return true;
    }

    function restorePost(uint id) public ownerOnly returns (bool){
        require(postExist[id],"Blog not found");
       
        activePosts[id-1].deleted = Deactivated.NO;

        emit Action(
            id,
            "POST RESTORED",
            msg.sender,
            block.timestamp
        );
        return true;
    }

}