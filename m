From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: don't discard next free dnode page
 for an umount checkpoint
Date: Mon, 2 Feb 2015 15:37:34 -0800
Message-ID: <20150202233734.GD34575@jaegeuk-mac02.mot.com>
References: <008c01d03d35$62ceb7a0$286c26e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YIQYq-0007S6-4l
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 02 Feb 2015 23:37:44 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YIQYp-0006ZJ-8b for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 02 Feb 2015 23:37:44 +0000
Content-Disposition: inline
In-Reply-To: <008c01d03d35$62ceb7a0$286c26e0$@samsung.com>
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On Sat, Jan 31, 2015 at 05:06:59PM +0800, Chao Yu wrote:
> Previously, discard_next_dnode is added before a checkpoint to prevent that we
> may meet a garbage dnode page readed from next free blkaddr in recover flow.
> 
> Since f2fs will skip recovery flow for a clean umount image, this condition will
> never happen.
> 
> So it's safe for us to leave next free dnode as it is in an umount checkpoint.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/checkpoint.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index f7cdcad..991fd0a 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -905,8 +905,12 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	/*
>  	 * This avoids to conduct wrong roll-forward operations and uses
>  	 * metapages, so should be called prior to sync_meta_pages below.
> +	 * But if we are in an umount checkpoint, we'd better skip this
> +	 * because we will not enter recovery flow to use the next free
> +	 * blkaddr when mounting it.
>  	 */
> -	discard_next_dnode(sbi, NEXT_FREE_BLKADDR(sbi, curseg));
> +	if (cpc->reason != CP_UMOUNT)
> +		discard_next_dnode(sbi, NEXT_FREE_BLKADDR(sbi, curseg));

The reason for discard_next_dnode is to avoid wrong execution due to old
mkfs.f2fs which remains gabage data.
It needs to do all the time.

Thanks,

>  
>  	/* Flush all the NAT/SIT pages */
>  	while (get_pages(sbi, F2FS_DIRTY_META)) {
> -- 
> 2.2.1

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
