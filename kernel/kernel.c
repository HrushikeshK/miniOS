void main() {
	char* video_memory = (char*) 0xb8000;
	const char* msg = "Kernel Loaded";

	int i = 0;
  	int j = 0;

	while(i < 80 * 35 * 2) {
    	video_memory[i] = ' ';
    	video_memory[i+1] = 0x00;
    	i += 2;
  }

  i = 0;
  j = 0;

  while(msg[j] != '\0'){
  	video_memory[i] = msg[j];
  	video_memory[i+1] = 0x04;	 // Red color with black background
  	j++;
  	i += 2;
  }
}