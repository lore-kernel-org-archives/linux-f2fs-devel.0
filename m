From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: adjust the way of calculating nat block
Date: Wed, 8 Mar 2017 13:56:00 -0800
Message-ID: <20170308215600.GF5483@jaegeuk.local>
References: <CGME20170308054010epcas5p1873bf561bd7ceac17a63a6e6cebb8365@epcas5p1.samsung.com>
	<000801d297ce$735eb750$5a1c25f0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cljZ4-00025b-OG
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 21:56:10 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cljZ3-0002zE-SC
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 21:56:10 +0000
Content-Disposition: inline
In-Reply-To: <000801d297ce$735eb750$5a1c25f0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Fan Li <fanofcode.li@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 03/08, Fan Li wrote:
> use a slightly simpler expression to calculate nat block with nid.
> 
> Signed-off-by: Fan Li <fanofcode.li@samsung.com>
> ---
>  fs/f2fs/node.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
> index 2f9603f..f9fb5b8 100644
> --- a/fs/f2fs/node.h
> +++ b/fs/f2fs/node.h
> @@ -200,13 +200,11 @@ static inline pgoff_t current_nat_addr(struct f2fs_sb_info *sbi, nid_t start)
>         struct f2fs_nm_info *nm_i = NM_I(sbi);
>         pgoff_t block_off;
>         pgoff_t block_addr;
> -       int seg_off;
> 
>         block_off = NAT_BLOCK_OFFSET(start);
> -       seg_off = block_off >> sbi->log_blocks_per_seg;
> 
>         block_addr = (pgoff_t)(nm_i->nat_blkaddr +
> -               (seg_off << sbi->log_blocks_per_seg << 1) +
> +               (block_off << 1) -

NAK. This breaks the behavior.

Thanks,

>                 (block_off & (sbi->blocks_per_seg - 1)));
> 
>         if (f2fs_test_bit(block_off, nm_i->nat_bitmap))
> --
> 2.7.4

------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
