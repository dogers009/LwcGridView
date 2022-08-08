import { LightningElement, wire, api, track  } from 'lwc';
import getObject_B_CList from '@salesforce/apex/Object_BC_Controller.getObject_B_CList';
 
export default class GridObjectBandC extends LightningElement {
    @track loader = false;
    @track error = null;
    @track pageSize = 10;
    @track pageNumber = 1;
    @track totalRecords = 0;
    @track totalPages = 0;
    @track recordEnd = 0;
    @track recordStart = 0;
    @track isPrev = true;
    @track isNext = true;
    @track objectBandCs = [];
 
    //On load
    connectedCallback() {
        this.getObjectBandC();
    }
 
    //handle next
    handleNext(){
        this.pageNumber = this.pageNumber+1;
        this.getObjectBandC();
    }
 
    //handle prev
    handlePrev(){
        this.pageNumber = this.pageNumber-1;
        this.getObjectBandC();
    }
 
    //get accounts
    getObjectBandC(){
        this.loader = true;
        getObject_B_CList({pageSize: this.pageSize, pageNumber : this.pageNumber})
        .then(result => {
            this.loader = false;
            if(result){
                var resultData = JSON.parse(result);
                this.objectBandCs = resultData.objC;
                this.pageNumber = resultData.pageNumber;
                this.totalRecords = resultData.totalRecords;
                this.recordStart = resultData.recordStart;
                this.recordEnd = resultData.recordEnd;
                this.totalPages = Math.ceil(resultData.totalRecords / this.pageSize);
                this.isNext = (this.pageNumber == this.totalPages || this.totalPages == 0);
                this.isPrev = (this.pageNumber == 1 || this.totalRecords < this.pageSize);
            }
        })
        .catch(error => {
            this.loader = false;
            this.error = error;
        });
    }
 
    //display no records
    get isDisplayNoRecords() {
        var isDisplay = true;
        if(this.objectBandCs){
            if(this.objectBandCs.length == 0){
                isDisplay = true;
            }else{
                isDisplay = false;
            }
        }
        return isDisplay;
    }
}