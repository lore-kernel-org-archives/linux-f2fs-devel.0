From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] libf2fs: move the finalize_device() into the
 io lib.
Date: Sat, 14 Jun 2014 14:25:20 +0900
Message-ID: <20140614052520.GA2456@jmac.local>
References: <1402691120-38950-1-git-send-email-jpa@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1WvgT8-0005hI-Tc
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 14 Jun 2014 05:25:34 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WvgT6-00017I-Td for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 14 Jun 2014 05:25:34 +0000
Content-Disposition: inline
In-Reply-To: <1402691120-38950-1-git-send-email-jpa@google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: JP Abgrall <jpa@google.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Fri, Jun 13, 2014 at 01:25:20PM -0700, JP Abgrall wrote:
> This is required so that libf2fs.c can be used against any kind
> of device (E.g. an in-memory sparse file) just by linking against
> something that provides the libf2fs_io.c functions.
> 
> libf2fs is currently libf2fs.c + libf2fs_io.c

Ok, merged.
Thanks,

> 
> Signed-off-by: JP Abgrall <jpa@google.com>
> ---
>  lib/libf2fs.c    | 12 ------------
>  lib/libf2fs_io.c | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
> index 8d6c670..6168c5c 100644
> --- a/lib/libf2fs.c
> +++ b/lib/libf2fs.c
> @@ -493,15 +493,3 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
>  	return 0;
>  }
>  
> -void f2fs_finalize_device(struct f2fs_configuration *c)
> -{
> -	/*
> -	 * We should call fsync() to flush out all the dirty pages
> -	 * in the block device page cache.
> -	 */
> -	if (fsync(c->fd) < 0)
> -		MSG(0, "\tError: Could not conduct fsync!!!\n");
> -
> -	if (close(c->fd) < 0)
> -		MSG(0, "\tError: Failed to close device file!!!\n");
> -}
> diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
> index 508ccce..5d9b68d 100644
> --- a/lib/libf2fs_io.c
> +++ b/lib/libf2fs_io.c
> @@ -67,3 +67,16 @@ int dev_read_blocks(void *buf, __u64 addr, __u32 nr_blks)
>  {
>  	return dev_read(buf, addr * F2FS_BLKSIZE, nr_blks * F2FS_BLKSIZE);
>  }
> +
> +void f2fs_finalize_device(struct f2fs_configuration *c)
> +{
> +	/*
> +	 * We should call fsync() to flush out all the dirty pages
> +	 * in the block device page cache.
> +	 */
> +	if (fsync(c->fd) < 0)
> +		MSG(0, "\tError: Could not conduct fsync!!!\n");
> +
> +	if (close(c->fd) < 0)
> +		MSG(0, "\tError: Failed to close device file!!!\n");
> +}
> -- 
> 2.0.0.526.g5318336
> 
> 
> ------------------------------------------------------------------------------
> HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
> Find What Matters Most in Your Big Data with HPCC Systems
> Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
> Leverages Graph Analysis for Fast Processing & Easy Data Exploration
> http://p.sf.net/sfu/hpccsystems
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

-- 
Jaegeuk Kim

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
