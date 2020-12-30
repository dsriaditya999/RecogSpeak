function decide = record_audio(filename,fs)

recObj = audiorecorder(fs,16,1);
disp("Start Speaking after pressing ENTER");
pause;
recordblocking(recObj,1);
disp("Your Audio has been recorded. To hear the recording please press ENTER :");
pause;
play(recObj);
decide = input("Are you satisfied? (y/n) : ","s");

if decide=="y"
    
    recording = getaudiodata(recObj);
    audiowrite(filename,recording,fs);
    
else
    
    disp("Better Luck Next Time!!");
    
end




