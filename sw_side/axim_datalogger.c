#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/mman.h>

#define MAP_SIZE 4096UL
#define MAP_MASK (MAP_SIZE - 1)

#define AXIM_SNOOPER_ADDR 0x43C20000 

//The AXIM snooper has the following register map
// slv_reg0: axi read addr, this is the read address that has been recorded from transactions
// slv_Reg1: axi write addr, this is the write address that has been recorded from transactions
// slv_reg2: time, This is a register that outputs the time that a particular transaction happened at 

void *setup_reserved_mem(unsigned int input_address);

int main()
{
	void * snooper_vaddr = (unsigned int *)setup_reserved_mem(AXIM_SNOOPER_ADDR); //Get the virtual address for the AXIM_Snooper module
	void * axim_read_addr = snooper_vaddr;
	void * axim_write_addr = snooper_vaddr + 4;
	void * snooper_time = snooper_vaddr + 8;

	FILE *logged_data;
	logged_data = fopen("master_log.csv", "w");

	unsigned int prev_axim_read = 0;
	unsigned int prev_axim_write = 0;
	unsigned int cur_axim_read;
	unsigned int cur_axim_write;	

	unsigned int diff_flag = 0;

	while(1)
	{
		cur_axim_read = *(unsigned int*)axim_read_addr;
		cur_axim_write = *(unsigned int*)axim_write_addr;

		if(cur_axim_read != prev_axim_read) 
		{
			prev_axim_read = cur_axim_read;
			diff_flag = 1;
		}

		if(cur_axim_write != prev_axim_write)
		{
			prev_axim_write = cur_axim_write;
			diff_flag = 1;
		}
		if(diff_flag == 1)
		{
			fprintf(logged_data, "%d,%d,%d\n", *(unsigned int *)snooper_time, cur_axim_read, cur_axim_write);
		}	
		diff_flag = 0;
	}

	return 0;
}


void * setup_reserved_mem(unsigned int input_address) //returns a pointer in userspace to the device
{
    void *mapped_base_reserved_mem;
    int memfd_reserved_mem;
    void *mapped_dev_base;
    off_t dev_base = input_address;

    memfd_reserved_mem = open("/dev/mem", O_RDWR | O_SYNC); //to open this the program needs to be run as root
        if (memfd_reserved_mem == -1) {
        printf("Can't open /dev/mem.\n");
        exit(0);
    }
    //printf("/dev/mem opened.\n"); 

    // Map one page of memory into user space such that the device is in that page, but it may not
    // be at the start of the page.

    mapped_base_reserved_mem = mmap(0, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, memfd_reserved_mem, dev_base & ~MAP_MASK);
        if (mapped_base_reserved_mem == (void *) -1) {
        printf("Can't map the memory to user space.\n");
        exit(0);
    }
     //printf("Memory mapped at address %p.\n", mapped_base_reserved_mem); 

    // get the address of the device in user space which will be an offset from the base 
    // that was mapped as memory is mapped at the start of a page 

    mapped_dev_base = mapped_base_reserved_mem + (dev_base & MAP_MASK);
    return mapped_dev_base;
}

