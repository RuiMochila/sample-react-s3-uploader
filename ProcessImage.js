const AWS = require('aws-sdk');
const util = require('util');
const sharp = require('sharp');
const https = require('https');

// get reference to S3 client
const s3 = new AWS.S3();

// set thumbnail width. 
const width  = 200;

function notifyServer(dstKey){
  return new Promise((resolve, reject) => {
    const options = {
      host: '33b1dd89e368.ngrok.io',
      path: '/uploads/status?src_key=' + encodeURIComponent(dstKey),
      method: 'PUT'
    };
    const req = https.request(options, (res) => {
      resolve();
    });
    req.on('error', (e) => {
      reject(e.message);
    });
    req.write('');
    req.end();
  });
}

exports.handler = async (event, context, callback) => {
  console.log("Event:\n", util.inspect(event, {depth: 5}));
  const srcBucket = event.Records[0].s3.bucket.name;
  const dstBucket = srcBucket;
  // Object key may have spaces or unicode non-ASCII characters.
  const srcKey    = decodeURIComponent(event.Records[0].s3.object.key.replace(/\+/g, " "));
  // Set one key for the thumbnail version
  const dstKey    = srcKey.replace("uploads/originals/", "uploads/thumbnails/");

  const typeMatch = srcKey.match(/\.([^.]*)$/);
  if (!typeMatch) {
    console.log("Could not determine the image type.");
    return;
  }
 
  const imageType = typeMatch[1].toLowerCase();
  if (imageType != "jpg" && imageType != "png" && imageType != "jpeg") {
    console.log(`Unsupported image type: ${imageType}`);
    return;
  }

  // Download the image from the S3 source bucket. 
  try {
    const params = {
      Bucket: srcBucket,
      Key: srcKey
    };
    var origimage = await s3.getObject(params).promise();

  } catch (error) {
    console.log(error);
    return;
  }  

  try { 
    // Resize will set the height automatically to maintain aspect ratio.
    var buffer = await sharp(origimage.Body).resize(width).toBuffer();      
  } catch (error) {
    console.log(error);
    return;
  } 

  try {
    const destparams = {
      Bucket: dstBucket,
      Key: dstKey,
      Body: buffer,
      ContentType: "image",
      ACL: 'public-read'
    };

    const putResult = await s3.putObject(destparams).promise(); 

    // Notify Rails backend that versions are ready
    await notifyServer(srcKey);
  
  } catch (error) {
    console.log(error);
    return;
  } 
        
  console.log('Successfully resized ' + srcBucket + '/' + srcKey + ' and uploaded to ' + dstBucket + '/' + dstKey);
}