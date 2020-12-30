function ASR_demo(nentry)

fs = 12500;

fprintf("Welcome to the Automatic Speaker Recognition Demonstration ! \n");

stage = input("Choose Stage :\n 1. For Enrollment Stage (e)\n 2. For Live Demo (d) \n 3. For Offline Testing (t)\n","s");

if stage=="e"
    disp("-----------------------------Speaker Enrollment----------------------------\n");
    filename = "s"+num2str(nentry)+".wav";
    
    fprintf("We will be requiring two recordings of your voice!\n Recording-1\n");
    
    d = "n";
    
    while(d=="n")
        d = record_audio(".\Dataset-1\train\"+filename,fs);
    end
    
    d = "n";
    
    fprintf("Recording-1 was Successful! \n Recording-2");
    
    while(d=="n")
        d = record_audio(".\Dataset-1\test\"+filename,fs);
    end
    
    fprintf("-----------------------------Enrollment Successful!----------------------------\n");
    
elseif stage=="d"
    
    disp("-----------------------------Demonstration of ASR----------------------------\n");
    recObj = audiorecorder(fs,16,1);
    
    code = sr_trainer(".\Dataset-1\train\",nentry);
    
    d1 = "n";
    
    while(d1=="n")
        disp("You have to be enrolled for this demonstration! Please start speaking (Say zero) after pressing enter.");
        pause;
        recordblocking(recObj,1);
        disp("Your Audio has been recorded. To hear the recording please press ENTER :");
        pause;
        play(recObj);
        d1 = input("Are you satisfied? (y/n) : ","s");
        recording = getaudiodata(recObj);
        
    end
    
    v = process_mfcc(recording, fs,26);            % Compute MFCC's
   
    distmin = inf;
    k1 = 0;
   
    for l = 1:length(code)      % each trained codebook, compute distortion
        d = disteu(v, code{l}); 
        dist = sum(min(d,[],2)) / size(d,1);
      
        if dist < distmin
            distmin = dist;
            k1 = l;
        end      
    end
    
    fprintf("Now, after pressing enter if the voice message that you hear is addressed to you, it means you have been recognized!\n");
    
    pause;
    
    message_file = ".\Acknowledgement\s"+int2str(k1)+".mp3";
    
    [m,f1] = audioread(message_file);
    sound(m,f1);
    
    final = input("Was the message Signal addressed to you? (y/n)\n","s");
    
    if final=="y"
        
        fprintf("Therefore, the ASR system recognized you!\n");
        
    else
        fprintf("Better Luck Next Time\n");
        
    end
    
    fprintf("-----------------------------ASR Demonstration Complete!----------------------------\n");
    
else
    
    fprintf("-----------------------------Offline Testing----------------------------\n");
    
    fprintf("The number of audio files available for testing are %d \n",nentry);
    
    fprintf("Press ENTER to test and summarize the results");
    pause;
    
    code = sr_trainer(".\Dataset-1\train\",nentry);
    
    sr_tester(".\Dataset-1\test\",nentry,code);
    
    fprintf("-----------------------------Offline Testing Complete!----------------------------\n");
    
end

end
    
    
    
    
    
    
    
    
    
    
    

    
    
    

    
    

