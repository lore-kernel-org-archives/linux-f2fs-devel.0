From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix small discards when
	se->valid_blocks is zero
Date: Tue, 3 Jan 2017 17:55:10 -0800
Message-ID: <20170104015510.GB16504@jaegeuk.local>
References: <1483434117-24427-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cOanP-0008C9-EX
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 04 Jan 2017 01:55:19 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cOanO-00080c-Fc
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 04 Jan 2017 01:55:19 +0000
Content-Disposition: inline
In-Reply-To: <1483434117-24427-1-git-send-email-yunlong.song@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlong Song <yunlong.song@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, sylinux@163.com, linux-fsdevel@vger.kernel.org, chao@kernel.org

Hi Yunlong,

On 01/03, Yunlong Song wrote:
> In the small discard case, when se->valid_blocks is zero, the add_discard_addrs
> will directly return without __add_discard_entry. This will cause the file
> delete have no small discard. The case is like this:
> 
> 1. Allocate free 2M segment
> 2. Write a file (size n blocks < 512) in that 2M segment, se->valid_blocks = n
> 3. Delete that file, se->valid_blocks = 0, add_discard_addrs will return without
> sending any discard of that file, and forever due to cur_map[i] ^ ckpt_map[i] =
> 0 after that checkpoint

During this checkpoint, that'll be discarded as a prefree segment, no?
Note that, if this is a current segment, f2fs won't discard it until it is
fully allocated.

Thanks,

> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/segment.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 0738f48..8610f14 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -838,7 +838,7 @@ static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  		return;
>  
>  	if (!force) {
> -		if (!test_opt(sbi, DISCARD) || !se->valid_blocks ||
> +		if (!test_opt(sbi, DISCARD) ||
>  		    SM_I(sbi)->nr_discards >= SM_I(sbi)->max_discards)
>  			return;
>  	}
> -- 
> 1.8.5.2

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
