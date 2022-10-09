//Author : Soumya Banerjee (CS22MTECH12011)

#include<bits/stdc++.h>
using namespace std;
const double pi=3.14159265359;

// Naive polynomial multiplication in O(n^2) time complexity
vector<long int> naive_polynomial_multiplication(vector<long int>&poly_1,vector<long int>&poly_2){
    vector<long int>naive_prod(32,0);
    long int i,j;
    for(i=0;i<poly_1.size();i++){
        for(j=0;j<poly_2.size();j++){
            long int new_exp=i+j;                      // indicates new exponent value
            naive_prod[new_exp]+=(poly_1[i]*poly_2[j]);
        }
    }
    return naive_prod;
}

// Helper function to find the index of the last non-zero coefficient of a polynomial
long int find_index(vector<long int>poly){
    long int i,n=poly.size(),index=0;
    for(i=n-1;i>=0;i--){
        if(poly[i])
            index=i;
    }
    return index;
}

// Adding complex numbers
vector<double> add_complex_num(double a,double b,double c,double d){
    vector<double>sum(2,0);
    sum[0]=a+c;
    sum[1]=b+d;
    return sum;
}

// Multiplying complex numbers
vector<double> multiply_complex_num(double a,double b,double c,double d){
    vector<double>mult(2,0);
    mult[0]=a*c-b*d;
    mult[1]=a*d+b*c;
    return mult;
}

// smallest power of 2 greater than or equal to (deg_1+deg_2+1) 
long int find_N(long int &deg_1, long int &deg_2){
    long int n=deg_1+deg_2+1;
    if(n && !(n&(n-1)))                         // to check if n is a power of 2 already or not
        return n;
    else{                                       // to calculate next higher power of 2 greater than n
        long int power=0;
        while(n){
            n=n/2;
            power++;
        }
        return 1<<power;
    }
}

// finding N different N-th roots of unity
vector<vector<double>> find_complex_roots(long int N,bool inverse_or_not){
    vector<vector<double>>roots(N,vector<double>(2));
    long int i;
    double theta;
    for(i=0;i<N;i++){
        theta=(inverse_or_not?-1 :1)*2.0*pi*i/(double)N;    // for the DFT or inverse DFT 
        roots[i][0]=cos(theta);
        roots[i][1]=sin(theta);
    }
    return roots;
}

// the Eval function for calculating fft and inverse fft
vector<vector<double>> Eval(vector<vector<double>>&poly,bool inverse_or_not){
    long int N=poly.size();
    vector<vector<double>>temp;                                 //for returning the result in base condition 
    long int i,k;
    if(N==1){   //base condition
        temp.push_back(poly[0]);
        // cout<<"inside base case"<<endl;
        // for(auto it:temp){
        //     cout<<it[0]<<" "<<it[1]<<endl;
        // }
        return temp;
    }
    vector<vector<double>>w=find_complex_roots(N,inverse_or_not);   //storing the N different N-th roots of unity

    vector<vector<double>> a0(N/2,vector<double>(2)),a1(N/2,vector<double>(2));
    i=0;
    while(i<(N/2)){
        a0[i]=(poly[i*2]);                                      // for even indices
        a1[i]=(poly[i*2+1]);                                    // for odd indices
        i++;
    }

    vector<vector<double>>y0=Eval(a0,inverse_or_not);
    vector<vector<double>>y1=Eval(a1,inverse_or_not);

    vector<vector<double>>y(N,vector<double>(2));
    for(k=0;k<N/2;k++){

        vector<double>mul=multiply_complex_num(w[k][0],w[k][1],y1[k][0],y1[k][1]);       
        y[k]=add_complex_num(y0[k][0],y0[k][1],mul[0],mul[1]);
        y[k+N/2]=add_complex_num(y0[k][0],y0[k][1],-mul[0],-mul[1]);

        if(inverse_or_not==true){                           // condition for calculating inverse fft
            y[k][0]/=2;                                     // N being a power of 2, it will recursively divide the result by N
            y[k][1]/=2;

            y[k+N/2][0]/=2;
            y[k+N/2][1]/=2;
        }

    }
    // cout<<"show y:"<<endl;
    // for(i=0;i<y.size();i++){
    //     cout<<y[i][0]<<" "<<y[i][1]<<endl;
    // }
    //cout<<endl;
    return y;
}

// returns evaluations of the product polynomials
vector<vector<double>> product_polynomial_evaluations(vector<vector<double>>poly_1_evaluations,vector<vector<double>>poly_2_evaluations){
    vector<vector<double>>product_poly_evaluations(poly_1_evaluations.size(),vector<double>(2));
    long int i;
    for(i=0;i<poly_1_evaluations.size();i++){
        product_poly_evaluations[i]=multiply_complex_num(poly_1_evaluations[i][0],poly_1_evaluations[i][1],poly_2_evaluations[i][0],poly_2_evaluations[i][1]);
    }
    return product_poly_evaluations;
}

// for taking the imaginary part as well into consideration
vector<vector<double>> change_to_complex(vector<long int>poly,long int N){
    vector<vector<double>>new_poly(N,vector<double>(2,0));
    for(long int i=0;i<min((int)N,(int)poly.size());i++){
        new_poly[i][0]=poly[i];
    }
    return new_poly;
}

// Printing the polynomial in decreasing order of the degree of the monomials
void print_poly(vector<long int>poly){
    long int i,n=poly.size(),index=find_index(poly),flag=0;
    for(i=n-1;i>=0;i--){
        if(poly[i]){
            cout<<poly[i]<<"x^"<<i<<" ";
            flag=1;                                     // flag variable is considered for the case if all coefficients are 0 for a polynomial
            if(i==index)                                // condition to check the index for last non-zero coefficient of the polynomial
                continue;
            else
                cout<<"+ ";
        }
    }
    if(flag==0)
    cout<<0;
    cout<<endl;
}

int main(){
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    /*
    #ifndef ONLINE_JUDGE 
        freopen("input.txt", "r", stdin); 
        freopen("output.txt", "w", stdout); 
    #endif 
    */
    vector<long int>poly_1(16,0),poly_2(16,0);                      // the two polynomials
    long int deg_1,deg_2;                                           // degrees of the two polynomials
    long int  i,j;

    cout<<"Enter the degree of the first polynomial:"<<endl;
    cin>>deg_1;                                                     //input of degree 1

    cout<<"Enter the "<<(deg_1+1)<<" coefficients of the first polynomial in the increasing order of the degree of the monomials they belong to:"<<endl;
    for(i=0;i<=deg_1;i++){  
        cin>>poly_1[i];                                             //enter the coefficients of first polynomial
    }

    cout<<"Enter the degree of the second polynomial:"<<endl;
    cin>>deg_2;                                                     //input of degree 2
 
    cout<<"Enter the "<<(deg_2+1)<<" coefficients of the second polynomial in the increasing order of the degree of the monomials they belong to:"<<endl;
    for(i=0;i<=deg_2;i++){  
        cin>>poly_2[i];                                             //enter the coefficients of second polynomial
    }

    vector<long int>naive_prod=naive_polynomial_multiplication(poly_1,poly_2);   //storing the output of naive_polynomial_multiplication

    cout<<"The first polynomial is:"<<endl;
    print_poly(poly_1);
    cout<<"The second polynomial is:"<<endl;
    print_poly(poly_2);
    cout<<"The product of the two polynomials obtained via naive polynomial multiplication is:"<<endl;
    print_poly(naive_prod);                                         //polynomial printed by naive polynomial multiplication method

    long int N=find_N(deg_1,deg_2);                                 //smallest power of 2 >= (deg_1+deg_2+1)

    vector<vector<double>>poly_1_evaluations,poly_2_evaluations;

    //This step is done for the ease of calculation of the fft and inverse fft in Eval()
    vector<vector<double>>new_poly_1=change_to_complex(poly_1,N);   //new_poly_1 is just the 2D representation of poly_1 containing real and imaginary parts
    vector<vector<double>>new_poly_2=change_to_complex(poly_2,N);   //new_poly_2 is just the 2D representation of poly_2 containing real and imaginary parts

    poly_1_evaluations=Eval(new_poly_1,false);                      //fft results stored in the evaluations, false indicates fft to be done
    poly_2_evaluations=Eval(new_poly_2,false);

    // cout<<"poly_1_evaluations:"<<endl;
    // for(i=0;i<poly_1_evaluations.size();i++){
    //     cout<<poly_1_evaluations[i][0]<<" "<<poly_1_evaluations[i][1]<<endl;
    // }

    // cout<<"poly_2_evaluations:"<<endl;
    // for(i=0;i<poly_2_evaluations.size();i++){
    //     cout<<poly_2_evaluations[i][0]<<" "<<poly_2_evaluations[i][1]<<endl;
    // }

    //evaluations of the product polynomial at N complex roots of unity
    vector<vector<double>>product_poly_evaluations=product_polynomial_evaluations(poly_1_evaluations,poly_2_evaluations);

    // cout<<"product polynomial in point form:"<<endl;
    // for(auto it:product_poly_evaluations){
    //     cout<<it[0]<<","<<it[1]<<endl;
    // }

    product_poly_evaluations=Eval(product_poly_evaluations,true);       //true indicates inverse fft needs to be done in Eval()

    vector<long int>fft_prod(32,0);                                     //stores coefficients of the product polynomial
    for(i=0;i<product_poly_evaluations.size();i++){
        fft_prod[i]=round(product_poly_evaluations[i][0]);              //rounding off needed as type conversion is done from double to int
    }
    cout<<"The product of the two polynomials obtained via polynomial multiplication using FFT is:"<<endl;
    print_poly(fft_prod);                                               //polynomial printed by FFT method

    return 0;
}
