From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add cleancache support
Date: Thu, 13 Nov 2014 17:27:51 -0800
Message-ID: <20141114012751.GB49179@jaegeuk-mac02.mot.com>
References: <1415856890-2455-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1415856890-2455-1-git-send-email-cm224.lee@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Changman Lee <cm224.lee@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Changman,

On Thu, Nov 13, 2014 at 02:34:50PM +0900, Changman Lee wrote:
> To use cleancache, fs must explicitly enable cleancache by calling
> cleancache_init_fs.

Good catch!

Prior to merge this patch, can you share any testing results or performance
numbers?

What condition will be the best way to exploit f2fs and cleancache?

Can we confirm that f2fs satisfies most of requirements described by
cleancache.txt below?

Some points for a filesystem to consider:

- The FS should be block-device-based (e.g. a ram-based FS such
  as tmpfs should not enable cleancache)
- To ensure coherency/correctness, the FS must ensure that all
  file removal or truncation operations either go through VFS or
  add hooks to do the equivalent cleancache "invalidate" operations
- To ensure coherency/correctness, either inode numbers must
  be unique across the lifetime of the on-disk file OR the
  FS must provide an "encode_fh" function.
- The FS must call the VFS superblock alloc and deactivate routines
  or add hooks to do the equivalent cleancache calls done there.
- To maximize performance, all pages fetched from the FS should
  go through the do_mpag_readpage routine or the FS should add
  hooks to do the equivalent (cf. btrfs)
- Currently, the FS blocksize must be the same as PAGESIZE.  This
  is not an architectural restriction, but no backends currently
  support anything different.
- A clustered FS should invoke the "shared_init_fs" cleancache
  hook to get best performance for some backends.

Thanks,

> 
> Signed-off-by: Changman Lee <cm224.lee@samsung.com>
> ---
>  fs/f2fs/super.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 512ffd8..2ebb960 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -24,6 +24,7 @@
>  #include <linux/blkdev.h>
>  #include <linux/f2fs_fs.h>
>  #include <linux/sysfs.h>
> +#include <linux/cleancache.h>
>  
>  #include "f2fs.h"
>  #include "node.h"
> @@ -1144,6 +1145,8 @@ try_onemore:
>  		if (err)
>  			goto free_kobj;
>  	}
> +
> +	cleancache_init_fs(sb);
>  	return 0;
>  
>  free_kobj:
> -- 
> 1.9.1
> 
> 
> ------------------------------------------------------------------------------
> Comprehensive Server Monitoring with Site24x7.
> Monitor 10 servers for $9/Month.
> Get alerted through email, SMS, voice calls or mobile push notifications.
> Take corrective actions from your mobile device.
> http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
