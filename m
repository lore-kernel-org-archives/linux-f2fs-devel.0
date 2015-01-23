From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] fibmap.f2fs: fix the wrong stat info
Date: Fri, 23 Jan 2015 13:19:57 -0800
Message-ID: <20150123211837.GA26082@jaegeuk-mac02.mot.com>
References: <00c501d035f2$52ea29e0$f8be7da0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YEleD-0004WV-01
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 23 Jan 2015 21:20:09 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YEleB-0003sN-Ht for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 23 Jan 2015 21:20:08 +0000
Content-Disposition: inline
In-Reply-To: <00c501d035f2$52ea29e0$f8be7da0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On Thu, Jan 22, 2015 at 11:19:05AM +0800, Chao Yu wrote:
> fibmap shows ino, size, blocks with incorrectly decimal number, fix it.
> 
> Before:
> --------------------------------------------
> dev       [8:16]
> ino       [0x   238ea : 0]
> mode      [0x    81a4 : 33188]
> nlink     [0x       1 : 1]
> uid       [0x       0 : 0]
> gid       [0x       0 : 0]
> size      [0x   79e00 : 0]
> blksize   [0x    1000 : 4096]
> blocks    [0x     268 : 0]
> --------------------------------------------
> 
> Patched:
> --------------------------------------------
> dev       [8:16]
> ino       [0x   238ea : 145642]
> mode      [0x    81a4 : 33188]
> nlink     [0x       1 : 1]
> uid       [0x       0 : 0]
> gid       [0x       0 : 0]
> size      [0x   79e00 : 499200]
> blksize   [0x    1000 : 4096]
> blocks    [0x     268 : 616]
> --------------------------------------------
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  tools/fibmap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/fibmap.c b/tools/fibmap.c
> index a6a112b..2df8094 100644
> --- a/tools/fibmap.c
> +++ b/tools/fibmap.c
> @@ -33,14 +33,14 @@ void print_stat(struct stat64 *st)
>  {
>  	printf("--------------------------------------------\n");
>  	printf("dev       [%d:%d]\n", major(st->st_dev), minor(st->st_dev));
> -	printf("ino       [0x%8lx : %ld]\n", st->st_ino, st->st_ino);
> +	printf("ino       [0x%8llx : %lld]\n", st->st_ino, st->st_ino);
>  	printf("mode      [0x%8x : %d]\n", st->st_mode, st->st_mode);
>  	printf("nlink     [0x%8lx : %ld]\n", st->st_nlink, st->st_nlink);
>  	printf("uid       [0x%8x : %d]\n", st->st_uid, st->st_uid);
>  	printf("gid       [0x%8x : %d]\n", st->st_gid, st->st_gid);
> -	printf("size      [0x%8lx : %ld]\n", st->st_size, st->st_size);
> +	printf("size      [0x%8llx : %lld]\n", st->st_size, st->st_size);
>  	printf("blksize   [0x%8lx : %ld]\n", st->st_blksize, st->st_blksize);
> -	printf("blocks    [0x%8lx : %ld]\n", st->st_blocks, st->st_blocks);
> +	printf("blocks    [0x%8llx : %lld]\n", st->st_blocks, st->st_blocks);
>  	printf("--------------------------------------------\n\n");
>  }

It needs to use like this.
Could you check this out?

Thanks,

>From 5a510076b737b734bdeab95dd4b597cdb681fb29 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao2.yu@samsung.com>
Date: Thu, 22 Jan 2015 11:19:05 +0800
Subject: [PATCH] fibmap.f2fs: fix the wrong stat info

fibmap shows ino, size, blocks with incorrectly decimal number, fix it.

Before:
--------------------------------------------
dev       [8:16]
ino       [0x   238ea : 0]
mode      [0x    81a4 : 33188]
nlink     [0x       1 : 1]
uid       [0x       0 : 0]
gid       [0x       0 : 0]
size      [0x   79e00 : 0]
blksize   [0x    1000 : 4096]
blocks    [0x     268 : 0]
--------------------------------------------

Patched:
--------------------------------------------
dev       [8:16]
ino       [0x   238ea : 145642]
mode      [0x    81a4 : 33188]
nlink     [0x       1 : 1]
uid       [0x       0 : 0]
gid       [0x       0 : 0]
size      [0x   79e00 : 499200]
blksize   [0x    1000 : 4096]
blocks    [0x     268 : 616]
--------------------------------------------

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tools/fibmap.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/fibmap.c b/tools/fibmap.c
index a6a112b..224b233 100644
--- a/tools/fibmap.c
+++ b/tools/fibmap.c
@@ -12,6 +12,7 @@
 #include <linux/hdreg.h>
 #include <linux/types.h>
 #include <linux/fs.h>
+#include <inttypes.h>
 
 struct file_ext {
 	__u32 f_pos;
@@ -33,14 +34,17 @@ void print_stat(struct stat64 *st)
 {
 	printf("--------------------------------------------\n");
 	printf("dev       [%d:%d]\n", major(st->st_dev), minor(st->st_dev));
-	printf("ino       [0x%8lx : %ld]\n", st->st_ino, st->st_ino);
+	printf("ino       [0x%8"PRIx64" : %"PRIu64"]\n",
+						st->st_ino, st->st_ino);
 	printf("mode      [0x%8x : %d]\n", st->st_mode, st->st_mode);
 	printf("nlink     [0x%8lx : %ld]\n", st->st_nlink, st->st_nlink);
 	printf("uid       [0x%8x : %d]\n", st->st_uid, st->st_uid);
 	printf("gid       [0x%8x : %d]\n", st->st_gid, st->st_gid);
-	printf("size      [0x%8lx : %ld]\n", st->st_size, st->st_size);
+	printf("size      [0x%8"PRIx64" : %"PRIu64"]\n",
+						st->st_size, st->st_size);
 	printf("blksize   [0x%8lx : %ld]\n", st->st_blksize, st->st_blksize);
-	printf("blocks    [0x%8lx : %ld]\n", st->st_blocks, st->st_blocks);
+	printf("blocks    [0x%8"PRIx64" : %"PRIu64"]\n",
+					st->st_blocks, st->st_blocks);
 	printf("--------------------------------------------\n\n");
 }
 
-- 
2.1.1


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
