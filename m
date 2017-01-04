From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: don't reserve block for empty file
 when convert inline, page
Date: Tue, 3 Jan 2017 17:23:28 -0800
Message-ID: <20170104012328.GA16504@jaegeuk.local>
References: <65c348f6-48ce-e810-72f4-0bf86c39d0b6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cOaIj-0004Dz-O5
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 04 Jan 2017 01:23:37 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cOaIi-00013M-NO
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 04 Jan 2017 01:23:37 +0000
Content-Disposition: inline
In-Reply-To: <65c348f6-48ce-e810-72f4-0bf86c39d0b6@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kinglong Mee <kinglongmee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Kinglong,

On 01/02, Kinglong Mee wrote:
> A test program gets the SEEK_DATA with two values between
> a new created file and the exist file on f2fs filesystem. 
> 
> F2FS filesystem,  (the first "test1" is a new file)
> # ./lseektest /f2fs/test1
> SEEK_DATA size != 0 (offset = 8192)
> # ./lseektest /f2fs/test1
> SEEK_DATA size != 0 (offset = 4096)
> 
> PNFS filesystem, (the first "test1" is a new file)
> # ./lseektest /pnfs/test1
> SEEK_DATA size != 0 (offset = 4096)
> # ./lseektest /pnfs/test1
> SEEK_DATA size != 0 (offset = 4096)
> 
> # cat lseektest.c
> 
> #include <stdio.h>
> #include <string.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <errno.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> 
> #ifndef SEEK_DATA
> #define SEEK_DATA      3
> #define SEEK_HOLE      4
> #endif
> 
> int main(int argc, char **argv)
> {
>         char *filename = argv[1];
>         int offset = 1, i = 0, fd = -1;
> 
>         if (argc < 2) {
>                 printf("Usage: %s f2fsfilename\n", argv[0]);
>                 return -1;
>         }
> 
>         /*
>         if (!access(filename, F_OK) || errno != ENOENT) {
>                 printf("Needs a new file for test, %m\n");
>                 return -1;
>         }*/
> 
>         fd = open(filename, O_RDWR | O_CREAT, 0777);
>         if (fd < 0) {
>                 printf("Create test file %s failed, %m\n", filename);
>                 return -1;
>         }
> 
>         for (i = 0; i < 20; i++) {
>                 offset = 1 << i;
>                 ftruncate(fd, 0);
>                 lseek(fd, offset, SEEK_SET);
>                 write(fd, "test", 5);
>                 /* Get the alloc size by seek data equal zero*/
>                 if (lseek(fd, 0, SEEK_DATA)) {
>                         printf("SEEK_DATA size != 0 (offset = %d)\n", offset);
>                         break;
>                 }
>         }
> 
>         close(fd);
>         return 0;
> }
> 
> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
> ---
>  fs/f2fs/inline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index e32a9e5..6c8d099 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -117,7 +117,7 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
>  	};
>  	int dirty, err;
>  
> -	if (!f2fs_exist_data(dn->inode))
> +	if (!f2fs_exist_data(dn->inode) || !i_size_read(dn->inode))
>  		goto clear_out;

The point is that f2fs_exist_data() should return true, since the file was
truncated to 0. So, could you check this out?

Thanks,

---
 fs/f2fs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 826fefc05fb1..ba2021e01c33 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -570,6 +570,8 @@ int truncate_blocks(struct inode *inode, u64 from, bool lock)
 	if (f2fs_has_inline_data(inode)) {
 		if (truncate_inline_inode(ipage, from))
 			set_page_dirty(ipage);
+		if (from == 0)
+			clear_inode_flag(inode, FI_DATA_EXIST);
 		f2fs_put_page(ipage, 1);
 		truncate_page = true;
 		goto out;
-- 
2.11.0

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
