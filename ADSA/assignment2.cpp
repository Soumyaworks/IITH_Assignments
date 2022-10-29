//Author : Soumya Banerjee (CS22MTECH12011)

#include<bits/stdc++.h>
using namespace std;

struct TreeNode {
    string val="";
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(""), left(nullptr), right(nullptr) {}
    TreeNode(string x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(string x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
    //TreeNode *root=new TreeNode();
};

// finding the index of string str from array words
int find_index(string str,vector<pair<string,double>>&words){
    for(int i=0;i<words.size();i++){
        if(words[i].first==str)
            return i;
    }
    return 0;
}

// constructing the optimal BST using the data from root matrix
TreeNode* construct_optimalBST(int x,int y,vector<vector<string>>&root,vector<pair<string,double>>&words){
    if(x>y)
        return NULL;
    else if(x==y){
        TreeNode *temp=new TreeNode(words[x].first);
        return temp;
    }
    else{
        TreeNode *node=new TreeNode(root[x][y]);
        node->left=construct_optimalBST(x,find_index(root[x][y],words)-1,root,words);
        node->right=construct_optimalBST(find_index(root[x][y],words)+1,y,root,words);
        return node;
    }
}

// preorder traversal of the optimal BST
void preorder_traversal(TreeNode *optimalBST_root){
    if(optimalBST_root==NULL)
        return;
    else{
        cout<<optimalBST_root->val<<" ";    // printing the root data
        preorder_traversal(optimalBST_root->left);
        preorder_traversal(optimalBST_root->right);
    }
}

// calculates the optimal BST cost using dynamic programming and stores in the cost matrix, O(n^3) time complexity required
void findOptimalBST(vector<vector<double>>&cost,vector<vector<string>>&root,long int n,vector<pair<string,double>>&words){
    
    int i,j,k,l,m;
    double t=0;

    // populating the left/main diagonal of the matrices
    for(i=0;i<n;i++){       
        cost[i][i]=words[i].second;
        root[i][i]=words[i].first;
    }

    k=2;
    while(k<=n){
        for(i=0;i<=n-k;i++){
            j=i+k-1;
            cost[i][j]=INT_MAX;     // similar to initializing with infinity
            double sum=0;
            for(l=i;l<=j;l++){
                sum+=words[l].second;
            }
            for(m=i;m<=j;m++){
                t=sum + ((m-1<i)?0:cost[i][m-1]) + ((m+1>j)?0:cost[m+1][j]);
                if(t<cost[i][j]){
                    cost[i][j]=t;       //storing the minimum cost
                    root[i][j]=words[m].first;
                }
            }
        }
        k++;
    }

    // cout<<"cost matrix after:"<<endl;
    // for(i=0;i<n;i++){
    //     for(j=0;j<n;j++){
    //         cout<<cost[i][j]<<"\t";
    //     }
    //     cout<<endl;
    // }
    
    // cout<<"root matrix after:"<<endl;
    // for(i=0;i<n;i++){
    //     for(j=0;j<n;j++){
    //         cout<<root[i][j]<<"\t";
    //     }
    //     cout<<endl;
    // }
}
int main(){
    // ios_base::sync_with_stdio(false);
    // cin.tie(NULL);
    /*
    #ifndef ONLINE_JUDGE 
        freopen("input.txt", "r", stdin); 
        freopen("output.txt", "w", stdout); 
    #endif 
    */
    int n,i,j;
    cout<<"How many strings do you want to insert in the BST?"<<endl;
    cin>>n;
    vector<pair<string,double>>words(n);        // stores the words along with their probabilites as pairs
    double total_prob=0.0;
    vector<string>w(n);
    vector<double>prob(n);
    set<double>distinct_prob;                   
    set<string>distinct_words;                  // set is used to check both distinct values as well as sorted order at once
    cout<<"Enter "<<n<<" strings in sorted dictionary order along with their probabilities:"<<endl;
    for(i=0;i<n;i++){
        cin>>w[i]>>prob[i];
        total_prob+=prob[i];
        words[i].first=w[i];
        words[i].second=prob[i];
        distinct_prob.insert(prob[i]);
        distinct_words.insert(w[i]);
    }

    bool sorted=true;                   // variable to check if the input words are in sorted dictionary order or not
    i=0;
    for(auto word:distinct_words){
        if(word!=w[i++]){
            sorted=false;
            break;
        }
    }
    vector<int>wrong_cases;

    // Possible cases of wrong inputs provided
    if(sorted==false){
        wrong_cases.push_back(1);
    }
    if(distinct_prob.size()!=n){
        wrong_cases.push_back(2);
    }
    if((int)total_prob!=1){
        wrong_cases.push_back(3);
    }
    if(distinct_words.size()!=n){
        wrong_cases.push_back(4);
    }

    
    if(wrong_cases.size()>0){   // indicates some form of invalid input is provided
        for(i=0;i<wrong_cases.size();i++){
            switch(wrong_cases[i]){
                case 1: cout<<"The strings entered are not in sorted order."<<endl;
                        break;
                case 2: cout<<"The probabilities are not distinct."<<endl;
                        break;
                case 3: cout<<"The probabilities don't add up to 1."<<endl;
                        break;
                case 4: cout<<"The strings entered are not distinct."<<endl;
                        break;
                default: cout<<"Invalid input"<<endl;
            }
        }
    }
    else{
        // inputs are valid, we can proceed.

        vector<vector<double>>cost(n,vector<double>(n,0));
        vector<vector<string>>root(n,vector<string>(n,"-"));
        
        findOptimalBST(cost,root,n,words);      // calculates the optimalBST cost using DP

        cout<<"The minimum expected total access time is "<<cost[0][n-1]<<endl;

        TreeNode *optimalBST_root=construct_optimalBST(0,n-1,root,words);       // constructing the optimalBST
        cout<<"Preorder traversal of the BST that provides minimum expected total access time is:"<<endl;
        preorder_traversal(optimalBST_root);                                    // printing the preorder traversal from the optimalBST root
    }
    return 0;
}
