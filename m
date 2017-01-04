From: Kinglong Mee <kinglongmee@gmail.com>
Subject: Re: [PATCH] f2fs: don't reserve block for empty file when convert
 inline, page
Date: Wed, 4 Jan 2017 16:27:48 +0800
Message-ID: <3bfc7e66-8447-2d71-1317-fb325147f2ab@gmail.com>
References: <65c348f6-48ce-e810-72f4-0bf86c39d0b6@gmail.com>
 <20170104012328.GA16504@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170104012328.GA16504@jaegeuk.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>, kinglongmee@gmail.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 1/4/2017 09:23, Jaegeuk Kim wrote:
> Hi Kinglong,
> 
> On 01/02, Kinglong Mee wrote:
>> A test program gets the SEEK_DATA with two values between
>> a new created file and the exist file on f2fs filesystem. 
>>
>> F2FS filesystem,  (the first "test1" is a new file)
>> # ./lseektest /f2fs/test1
>> SEEK_DATA size != 0 (offset = 8192)
>> # ./lseektest /f2fs/test1
>> SEEK_DATA size != 0 (offset = 4096)
>>
>> PNFS filesystem, (the first "test1" is a new file)
>> # ./lseektest /pnfs/test1
>> SEEK_DATA size != 0 (offset = 4096)
>> # ./lseektest /pnfs/test1
>> SEEK_DATA size != 0 (offset = 4096)
>>
>> # cat lseektest.c
>>
>> #include <stdio.h>
>> #include <string.h>
>> #include <stdlib.h>
>> #include <unistd.h>
>> #include <errno.h>
>> #include <sys/types.h>
>> #include <sys/stat.h>
>> #include <fcntl.h>
>>
>> #ifndef SEEK_DATA
>> #define SEEK_DATA      3
>> #define SEEK_HOLE      4
>> #endif
>>
>> int main(int argc, char **argv)
>> {
>>         char *filename = argv[1];
>>         int offset = 1, i = 0, fd = -1;
>>
>>         if (argc < 2) {
>>                 printf("Usage: %s f2fsfilename\n", argv[0]);
>>                 return -1;
>>         }
>>
>>         /*
>>         if (!access(filename, F_OK) || errno != ENOENT) {
>>                 printf("Needs a new file for test, %m\n");
>>                 return -1;
>>         }*/
>>
>>         fd = open(filename, O_RDWR | O_CREAT, 0777);
>>         if (fd < 0) {
>>                 printf("Create test file %s failed, %m\n", filename);
>>                 return -1;
>>         }
>>
>>         for (i = 0; i < 20; i++) {
>>                 offset = 1 << i;
>>                 ftruncate(fd, 0);
>>                 lseek(fd, offset, SEEK_SET);
>>                 write(fd, "test", 5);
>>                 /* Get the alloc size by seek data equal zero*/
>>                 if (lseek(fd, 0, SEEK_DATA)) {
>>                         printf("SEEK_DATA size != 0 (offset = %d)\n", offset);
>>                         break;
>>                 }
>>         }
>>
>>         close(fd);
>>         return 0;
>> }
>>
>> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
>> ---
>>  fs/f2fs/inline.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
>> index e32a9e5..6c8d099 100644
>> --- a/fs/f2fs/inline.c
>> +++ b/fs/f2fs/inline.c
>> @@ -117,7 +117,7 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
>>  	};
>>  	int dirty, err;
>>  
>> -	if (!f2fs_exist_data(dn->inode))
>> +	if (!f2fs_exist_data(dn->inode) || !i_size_read(dn->inode))
>>  		goto clear_out;
> 
> The point is that f2fs_exist_data() should return true, since the file was
> truncated to 0. So, could you check this out?

Yes, that's right.
This patch is useful. 

Tested-by: Kinglong Mee <kinglongmee@gmail.com>

thanks,
Kinglong Mee

> 
> Thanks,
> 
> ---
>  fs/f2fs/file.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 826fefc05fb1..ba2021e01c33 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -570,6 +570,8 @@ int truncate_blocks(struct inode *inode, u64 from, bool lock)
>  	if (f2fs_has_inline_data(inode)) {
>  		if (truncate_inline_inode(ipage, from))
>  			set_page_dirty(ipage);
> +		if (from == 0)
> +			clear_inode_flag(inode, FI_DATA_EXIST);
>  		f2fs_put_page(ipage, 1);
>  		truncate_page = true;
>  		goto out;
> 
