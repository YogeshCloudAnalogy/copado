import { LightningElement, track, wire } from 'lwc';
import getAccountDataToExport from '@salesforce/apex/ExportDataController.getAccountDataToExport';
import generatePDF from '@salesforce/apex/ExportDataController.generatePDF';
import { loadStyle, loadScript } from 'lightning/platformResourceLoader';
// import jspdf from '@salesforce/resourceUrl/jspdf';
import jspdf from "@salesforce/resourceUrl/jspdf";


export default class ExportDataAsCsvOrXls extends LightningElement {

    conatctData = [];

    columnHeader = ['Id', 'LastName' ]

    @wire(getAccountDataToExport)
    wiredData({ error, data }) {
        if (data) {
            console.log('Data', data);
            this.conatctData = data;
        } else if (error) {
            console.error('Error:', error);
        }
    }
    renderedCallback() {
        Promise.all([
            loadScript(this,jspdf)// load script here
        ]).then(()=>{
            console.log('test');
        }).catch(err=>{
            console.log('err=>',err);
        })
    }

    async createPdf() {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();
        console.log(this.conatctData)
        console.log(this.createHeaders(this.columnHeader))
        doc.table(30,30, this.conatctData, this.createHeaders(this.columnHeader),{ autosize:true });
        doc.save("demo.pdf");
    }

  createHeaders(keys) {
    var result = [];
    for (var i = 0; i < keys.length; i += 1) {
        result.push({
            id: keys[i],
            name: keys[i],
            prompt: keys[i],
            width: 65,
            align: "center",
            padding: 0
        });
    }
    return result;
}
}