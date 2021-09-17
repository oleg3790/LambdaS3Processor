if [ ! -d '/payload' ]
then
  mkdir payload
fi

cd src/LambdaS3Processor/LambdaS3Processor

dotnet lambda package 

cp ./bin/Release/netcoreapp3.1/LambdaS3Processor.zip ../../../payload