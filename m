From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 1/2] f2fs: add F2FS_GOING_DOWN_METAFLUSH to
	test	power-failure
Date: Mon, 12 Oct 2015 17:01:29 +0800
Message-ID: <020e01d104cc$af078480$0d168d80$@samsung.com>
References: <1444350566-37795-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZlYzt-0006og-GI
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Oct 2015 09:02:21 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZlYzr-0002TP-IQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Oct 2015 09:02:21 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NW301QW4NOX7X60@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Oct 2015 18:02:11 +0900 (KST)
In-reply-to: <1444350566-37795-1-git-send-email-jaegeuk@kernel.org>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Friday, October 09, 2015 8:29 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 1/2] f2fs: add F2FS_GOING_DOWN_METAFLUSH to test power-failure
> 
> This patch introduces F2FS_GOING_DOWN_METAFLUSH which flushes meta pages like
> SSA blocks and then blocks all the writes.
> This can be used by power-failure tests.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Good idea! I test power-failure case by changing src/godown to use new
macro, until now, I didn't catch any consistent problem. :)

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

Thanks,

> ---
>  fs/f2fs/f2fs.h | 1 +
>  fs/f2fs/file.c | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index aad4720..f05ae22 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -250,6 +250,7 @@ static inline bool __has_cursum_space(struct f2fs_summary_block *sum, int
> size,
>  #define F2FS_GOING_DOWN_FULLSYNC	0x0	/* going down with full sync */
>  #define F2FS_GOING_DOWN_METASYNC	0x1	/* going down with metadata */
>  #define F2FS_GOING_DOWN_NOSYNC		0x2	/* going down */
> +#define F2FS_GOING_DOWN_METAFLUSH	0x3	/* going down with meta flush */
> 
>  #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
>  /*
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index b3985a6..6d3cfd5 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1498,6 +1498,10 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>  	case F2FS_GOING_DOWN_NOSYNC:
>  		f2fs_stop_checkpoint(sbi);
>  		break;
> +	case F2FS_GOING_DOWN_METAFLUSH:
> +		sync_meta_pages(sbi, META, LONG_MAX);
> +		f2fs_stop_checkpoint(sbi);
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> --
> 2.1.1
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
