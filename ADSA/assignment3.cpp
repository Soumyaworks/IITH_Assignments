//Author : Soumya Banerjee (CS22MTECH12011)

#include<bits/stdc++.h>
using namespace std;

// Path reconstruction, paths generated during Floyd Warshall algorithm
vector<int> find_path(int x,int y,vector<vector<int>>&stored_paths){
    vector<int>path;
    if(stored_paths[x][y]==-1){
        return path;
    }
    path={x+1};
    while(x!=y){
        x=stored_paths[x][y];
        path.push_back(x+1);
    }
    return path;
}

// Finding the minimum key to include in MST during Prim's algorithm
int find_minKey(vector<int>key,vector<bool>mst_set,int v)
{
    int i,j,min=INT_MAX,index;
 
    for (i=0;i<v;i++){
        if (mst_set[i] == false && key[i] < min){
            min = key[i];
            index = i;
        }
    }
    return index;
}

// Prints the final 2-factor approximate Steiner tree
void printSteiner(vector<vector<int>>matrix,vector<int>parent, vector<vector<int>>&final_mst,vector<vector<int>>&stored_paths,vector<int>&required)
{
    int v=final_mst.size();
    int n=stored_paths.size(),i,j,cost=0;
    vector<pair<int,set<int>>>ans(n);       // for displaying neighboring vertices of each neighbor
    for(i=0;i<n;i++){
        ans[i].first=i+1;
    }
    for (i=1;i<v;i++){
        vector<int>path=find_path(required[parent[i]],required[i],stored_paths);
        for(j=0;j<path.size();j++){
            if(j>0){
                ans[path[j]-1].second.insert(path[j-1]);
                ans[path[j-1]-1].second.insert(path[j]);
            }
            // if(j!=path.size()-1){
            //     cout<<path[j]<<" -";
            // }
            // else
            // cout<<path[j]<<endl;
        }
    }
    cout<<"The 2-factor approximate tree we have computed is given below (we describe this tree by listing all the neighbors of all the vertices in the tree):"<<endl;
    for(auto it:ans){
        if(!it.second.empty()){
        cout<<"Neighbors of vertex "<<it.first<<" : ";
        for(auto it2:it.second){
            cost+=matrix[it.first-1][it2-1];
            matrix[it.first-1][it2-1]=0;
            matrix[it2-1][it.first-1]=0;
            cout<<it2<<" ";
        }
        cout<<endl;
        }
    }
    cout<<"The cost of the 2-factor approximate Steiner tree = "<<cost<<endl;
}

// Implementing Prim's algorithm for finding minimum spanning tree
void prims(vector<vector<int>>matrix,vector<vector<int>>final_mst,vector<vector<int>>&stored_paths,vector<int>&required)
{
    int i,j,k,v=final_mst.size();
    vector<int>parent(v),key(v,INT_MAX);
    vector<bool>mst_set(v,false);               // set of vertices to be included in MST

    key[0]=0;
    parent[0]=-1;                             // considering first node as root of MST
 
    for (i=0;i<v-1;i++) {
        k = find_minKey(key, mst_set,v);        // minimum key vertex to be picked not in MST yet
        mst_set[k] = true;                      // the picked vertex is now part of the MST

        for (j=0;j<v;j++)
            if (final_mst[k][j] && mst_set[j] == false && final_mst[k][j] < key[j]){      
                parent[j] = k;
                key[j] = final_mst[k][j];
            }
    }
    // print the constructed MST
    // cout<<"parent array:"<<endl;
    // for(auto it:parent){
    //     cout<<it<<" ";
    // }
    // cout<<endl;
    printSteiner(matrix,parent,final_mst,stored_paths,required);
}

// Checking whether matrix is symmetric or not, also for negative values inside matrix
bool check_symmetric(vector<vector<int>>&matrix){
    int i,j,n=matrix.size();
    for(i=0;i<n;i++){
        for(j=0;j<n;j++){
            if(matrix[i][j]!=matrix[j][i] || matrix[i][j]<0)    // checking symmetric and negative values
            return false;
        }
    }
    return true;
}

int main(){
    
    vector<vector<int>>matrix;      // stores the input matrix after reading from file
    int i,j,k;
    string line;
    ifstream f("input.txt");        // input.txt file contains the input matrix 
    if(f.is_open()){
        while(getline(f,line)){
            //cout<<line<<endl;
            line+=" ";
            vector<int>rows;
            string words="";
            for(i=0;i<line.size();i++){
                if(line[i]==' '){
                    rows.push_back(stoi(words));
                    words="";
                }
                else{
                    words+=line[i];
                }
            }
            matrix.push_back(rows);
            rows.clear();
        }
    }
    f.close();

    cout<<"The input matrix A of the program read from the file is displayed below:"<<endl;
    for(i=0;i<matrix.size();i++){
        for(j=0;j<matrix[i].size();j++){
            cout<<matrix[i][j]<<" ";
        }
        cout<<endl;
    }
    cout<<"List all the Steiner vertices (press * to quit) :"<<endl;
    vector<int>steiner;         // stores Steiner vertices
    while(true){
        string str;
        cin>>str;
        if(str=="*")
        break;
        steiner.push_back(stoi(str)-1);
    }
    
    unordered_set<int>S;
    for(i=0;i<steiner.size();i++){
        //cout<<steiner[i]<<" ";
        S.insert(steiner[i]);
    }
    
    int n=matrix.size();
    int s=steiner.size();
 
    vector<int>required(n-s);       // contains the required vertices
    k=0;
    for(i=0;i<n;i++){
        if(S.find(i)!=S.end())
            continue;
        required[k++]=i;
    }

    // cout<<"size of required:"<<required.size()<<endl;
    // cout<<"The required points are:"<<endl;
    // for(i=0;i<required.size();i++){
    //     cout<<required[i]<<" ";
    // }
    // cout<<endl;

    vector<vector<int>>dist(n,vector<int>(n,INT_MAX)),stored_paths(n,vector<int>(n,-1)),mst(n,vector<int>(n,INT_MAX));
    for(i=0;i<n;i++){
        for(j=0;j<n;j++){
            //dist[i][j]=matrix[i][j];
            if(i!=j && matrix[i][j]==0){
                dist[i][j]=INT_MAX;
                stored_paths[i][j]=-1;
            }
            else{
                dist[i][j]=matrix[i][j];
                stored_paths[i][j]=j;         
            }
        }
    }
        
    if(s==n-1){
        cout<<"The 2-factor approximate tree we have computed is given below (we describe this tree by listing all the neighbors of all the vertices in the tree):"<<endl;
        cout<<"Neighbors of vertex "<<required[0]+1<<" : "<<endl;
        cout<<"The cost of the 2-factor approximate Steiner tree = 0"<<endl;
    }
    else if(s==n){
        cout<<"No MST formed as all vertices are Steiner. The cost is 0."<<endl;
    }
    else if(s==0){
        prims(matrix,matrix,stored_paths,required);
    }
    else if(check_symmetric(matrix)==false){
        cout<<"Wrong input provided."<<endl;
    }
    else{

        // Floyd Warshall algorithm for finding all pair shortest paths
        for(k=0;k<n;k++){
            for(i=0;i<n;i++){
                for(j=0;j<n;j++){
                    // if (dist[i][k] < INT_MAX && dist[k][j] < INT_MAX){
                    //     dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j]); 
                    //     next[i][j] = next[i][k];
                    // }
                    if (dist[i][k] < INT_MAX && dist[k][j] < INT_MAX){
                        if (dist[i][j] > dist[i][k] + dist[k][j]) {
                            dist[i][j] = dist[i][k] + dist[k][j];
                            stored_paths[i][j] = stored_paths[i][k];         // storing the paths, later used for path reconstruction
                        }
                    }
                }
            }
        }

        // cout<<"Floyd warshall graph:"<<endl;
        // for(i=0;i<n;i++){
        //     for(j=0;j<n;j++){
        //         cout<<dist[i][j]<<" ";
        //     }
        //     cout<<endl;
        // }

        mst=dist;
        for(i=0;i<n;i++){
            for(j=0;j<n;j++){
                if(S.find(i)!=S.end() || S.find(j)!=S.end()){
                    mst[i][j]=0;
                }
            }
        }

        // cout<<"MST for prim's:"<<endl;
        // for(i=0;i<n;i++){
        //     for(j=0;j<n;j++){
        //         cout<<mst[i][j]<<" ";
        //     }
        //     cout<<endl;
        // }
    
        vector<vector<int>>final_mst;       // MST to be done only on the required vertices,hence stored here
        for(i=0;i<n;i++){
            vector<int>rows;
            if(S.find(i)!=S.end())
            continue;
            for(j=0;j<n;j++){
                if(S.find(j)!=S.end())
                    continue;;
                rows.push_back(mst[i][j]);
            }
            if(!rows.empty())
                final_mst.push_back(rows);
        }
    
        // cout<<"Final MST:"<<endl;
        // for(i=0;i<final_mst.size();i++){
        //     for(j=0;j<final_mst[i].size();j++){
        //         cout<<final_mst[i][j]<<" ";
        //     }
        //     cout<<endl;
        // }
        prims(matrix,final_mst,stored_paths,required);          // Prim's algorithm called for finding the MST on required vertices
    }
    return 0;
}
