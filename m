From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 3.15 2/2] f2fs: check bdi->dirty_exceeded
 when trying to skip data writes
Date: Mon, 14 Jul 2014 17:53:36 -0700
Message-ID: <20140715005336.GC8745@kroah.com>
References: <1405349571-20058-1-git-send-email-jaegeuk@kernel.org>
	<1405349571-20058-2-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <greg@kroah.com>) id 1X6qvh-00034p-8K
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Jul 2014 00:49:13 +0000
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X6qvf-00044L-MU
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Jul 2014 00:49:13 +0000
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1ACDA22BE4
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 14 Jul 2014 20:49:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1405349571-20058-2-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Mon, Jul 14, 2014 at 07:52:51AM -0700, Jaegeuk Kim wrote:
> commit dd6b9bf5883c3ca9c17bac80ccd8615fe5a452a3 upstream.

You mean 2743f865543c0c4a5e12fc13edb2bf89a6e9687c, right?

thanks,

greg k-h

> 
> If we don't check the current backing device status, balance_dirty_pages can
> fall into infinite pausing routine.
> 
> This can be occurred when a lot of directories make a small number of dirty
> dentry pages including files.
> 
> Reported-by: Brian Chadwick <brianchad@westnet.com.au>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/node.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index a9c0495..5696bde 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -42,6 +42,8 @@ bool available_free_memory(struct f2fs_sb_info *sbi, int type)
>  		mem_size = (nm_i->nat_cnt * sizeof(struct nat_entry)) >> 12;
>  		res = mem_size < ((val.totalram * nm_i->ram_thresh / 100) >> 2);
>  	} else if (type == DIRTY_DENTS) {
> +		if (sbi->sb->s_bdi->dirty_exceeded)
> +			return false;
>  		mem_size = get_pages(sbi, F2FS_DIRTY_DENTS);
>  		res = mem_size < ((val.totalram * nm_i->ram_thresh / 100) >> 1);
>  	}
> -- 
> 2.0.1.472.g6f92e5f
> 
> --
> To unsubscribe from this list: send the line "unsubscribe stable" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
