// The Cloud Functions for Firebase SDK to
// create Cloud Functions and setup triggers.
const functions = require("firebase-functions");

// The Firebase Admin SDK to access Firestore.
const admin = require("firebase-admin");
admin.initializeApp();

// const spawn = require("child-process-promise").spawn;
const path = require("path");
const os = require("os");
// const fs = require("fs");
// const content = "Some content!";
const tmp = require("tmp");
const PDFDocument = require("pdfkit");

exports.createPdfFile = functions.firestore.
    document("/users/{documentId}/{collection}/{messageId}")
    .onUpdate( async (snap, context) => {
      // Grab the current value of what was written to Firestore.

      // Access the parameter `{documentId}` with `context.params`
      functions.logger.log("Uppercasing bla bla bla");
      // Create a document
      const doc = new PDFDocument();
      // Saving the pdf file in root directory.
      // const fileName =fs.createWriteStream("output123.pdf");
      // const tempFilePath = path.join(os.tmpdir(), (fileName));

      const tmpFilePath = path.join(os.tmpdir(), "Usetest.txt");
      functions.logger.log("tmpFilePath", tmpFilePath);
      // const tmpFile = fs.createWriteStream(tmpFilePath);
      // const tmpFilePath= fs.writeFileSync("/tmp/Usetest.txt", "Hey there!");
      tmp.tmpName(function _tempNameGenerated(err, tmpFilePath) {
        if (err) throw err;

        console.log("Created temporary filename: ", path);
      });
      functions.logger.log("file writen successfully");
      functions.logger.log("tmpFilePath:", tmpFilePath);

      functions.logger.log("tmpFilePath", tmpFilePath);
      functions.logger.log("tmpFilePath", tmpFilePath);
      // doc.pipe(tmpFilePath);
      // Adding functionality
      doc
          .fontSize(27)
          .text("This the article for GeeksforGeeks", 100, 100);
      doc.end;

      const imageBucket = "images/";
      const bucket = admin.storage().bucket();
      const destination = `${imageBucket}${tmpFilePath}`;
      try {
        // Uploads a local file to the bucket
        await bucket.upload(tmpFilePath, {
          destination: destination,
          gzip: true,
        });

        console.log(`${tmpFilePath} upload to /${imageBucket}/${tmpFilePath}.`);
      } catch (e) {
        throw new Error("uploadLocalFileToStorage failed: " + e);
      }
    });


