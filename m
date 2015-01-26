From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] fibmap.f2fs: fix the wrong stat info
Date: Mon, 26 Jan 2015 18:43:55 +0800
Message-ID: <007f01d03955$16522530$42f66f90$@samsung.com>
References: <00c501d035f2$52ea29e0$f8be7da0$@samsung.com>
	<20150123211837.GA26082@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1YFh9z-0007vv-Kr
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Jan 2015 10:44:47 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1YFh9x-0002EY-8S
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Jan 2015 10:44:47 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NIS007715UGNQ50@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Jan 2015 19:44:40 +0900 (KST)
In-reply-to: <20150123211837.GA26082@jaegeuk-mac02.mot.com>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Saturday, January 24, 2015 5:20 AM
> To: Chao Yu
> Cc: Changman Lee; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev][PATCH] fibmap.f2fs: fix the wrong stat info
> 
> Hi Chao,
> 
> On Thu, Jan 22, 2015 at 11:19:05AM +0800, Chao Yu wrote:
> > fibmap shows ino, size, blocks with incorrectly decimal number, fix it.
> >
> > Before:
> > --------------------------------------------
> > dev       [8:16]
> > ino       [0x   238ea : 0]
> > mode      [0x    81a4 : 33188]
> > nlink     [0x       1 : 1]
> > uid       [0x       0 : 0]
> > gid       [0x       0 : 0]
> > size      [0x   79e00 : 0]
> > blksize   [0x    1000 : 4096]
> > blocks    [0x     268 : 0]
> > --------------------------------------------
> >
> > Patched:
> > --------------------------------------------
> > dev       [8:16]
> > ino       [0x   238ea : 145642]
> > mode      [0x    81a4 : 33188]
> > nlink     [0x       1 : 1]
> > uid       [0x       0 : 0]
> > gid       [0x       0 : 0]
> > size      [0x   79e00 : 499200]
> > blksize   [0x    1000 : 4096]
> > blocks    [0x     268 : 616]
> > --------------------------------------------
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  tools/fibmap.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/fibmap.c b/tools/fibmap.c
> > index a6a112b..2df8094 100644
> > --- a/tools/fibmap.c
> > +++ b/tools/fibmap.c
> > @@ -33,14 +33,14 @@ void print_stat(struct stat64 *st)
> >  {
> >  	printf("--------------------------------------------\n");
> >  	printf("dev       [%d:%d]\n", major(st->st_dev), minor(st->st_dev));
> > -	printf("ino       [0x%8lx : %ld]\n", st->st_ino, st->st_ino);
> > +	printf("ino       [0x%8llx : %lld]\n", st->st_ino, st->st_ino);
> >  	printf("mode      [0x%8x : %d]\n", st->st_mode, st->st_mode);
> >  	printf("nlink     [0x%8lx : %ld]\n", st->st_nlink, st->st_nlink);
> >  	printf("uid       [0x%8x : %d]\n", st->st_uid, st->st_uid);
> >  	printf("gid       [0x%8x : %d]\n", st->st_gid, st->st_gid);
> > -	printf("size      [0x%8lx : %ld]\n", st->st_size, st->st_size);
> > +	printf("size      [0x%8llx : %lld]\n", st->st_size, st->st_size);
> >  	printf("blksize   [0x%8lx : %ld]\n", st->st_blksize, st->st_blksize);
> > -	printf("blocks    [0x%8lx : %ld]\n", st->st_blocks, st->st_blocks);
> > +	printf("blocks    [0x%8llx : %lld]\n", st->st_blocks, st->st_blocks);
> >  	printf("--------------------------------------------\n\n");
> >  }
> 
> It needs to use like this.
> Could you check this out?

Very good, this can fix the portability issue, thanks. :)

> 
> Thanks,
> 
> From 5a510076b737b734bdeab95dd4b597cdb681fb29 Mon Sep 17 00:00:00 2001
> From: Chao Yu <chao2.yu@samsung.com>
> Date: Thu, 22 Jan 2015 11:19:05 +0800
> Subject: [PATCH] fibmap.f2fs: fix the wrong stat info
> 
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
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  tools/fibmap.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/fibmap.c b/tools/fibmap.c
> index a6a112b..224b233 100644
> --- a/tools/fibmap.c
> +++ b/tools/fibmap.c
> @@ -12,6 +12,7 @@
>  #include <linux/hdreg.h>
>  #include <linux/types.h>
>  #include <linux/fs.h>
> +#include <inttypes.h>
> 
>  struct file_ext {
>  	__u32 f_pos;
> @@ -33,14 +34,17 @@ void print_stat(struct stat64 *st)
>  {
>  	printf("--------------------------------------------\n");
>  	printf("dev       [%d:%d]\n", major(st->st_dev), minor(st->st_dev));
> -	printf("ino       [0x%8lx : %ld]\n", st->st_ino, st->st_ino);
> +	printf("ino       [0x%8"PRIx64" : %"PRIu64"]\n",
> +						st->st_ino, st->st_ino);
>  	printf("mode      [0x%8x : %d]\n", st->st_mode, st->st_mode);
>  	printf("nlink     [0x%8lx : %ld]\n", st->st_nlink, st->st_nlink);
>  	printf("uid       [0x%8x : %d]\n", st->st_uid, st->st_uid);
>  	printf("gid       [0x%8x : %d]\n", st->st_gid, st->st_gid);
> -	printf("size      [0x%8lx : %ld]\n", st->st_size, st->st_size);
> +	printf("size      [0x%8"PRIx64" : %"PRIu64"]\n",
> +						st->st_size, st->st_size);
>  	printf("blksize   [0x%8lx : %ld]\n", st->st_blksize, st->st_blksize);
> -	printf("blocks    [0x%8lx : %ld]\n", st->st_blocks, st->st_blocks);
> +	printf("blocks    [0x%8"PRIx64" : %"PRIu64"]\n",
> +					st->st_blocks, st->st_blocks);
>  	printf("--------------------------------------------\n\n");
>  }
> 
> --
> 2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
