From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: simplify the way of calulating next
 nat address
Date: Sat, 3 Jun 2017 09:38:46 +0800
Message-ID: <b908d479-c1bb-466e-df2a-37ad42b835a9@kernel.org>
References: <CGME20170602074702epcas5p2afcfc8a3bb05e1916f6d93abe1958a5a@epcas5p2.samsung.com>
	<003201d2db74$6be959f0$43bc0dd0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1dGy20-0001gw-8J
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 03 Jun 2017 01:39:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dGy1y-0003yp-EZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 03 Jun 2017 01:39:08 +0000
In-Reply-To: <003201d2db74$6be959f0$43bc0dd0$@samsung.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Fan Li <fanofcode.li@samsung.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/6/2 15:45, Fan Li wrote:
> The index of segment which the next nat block is in has only one different
> bit than the current one, so to get the next nat address, we can simply
> alter that one bit.
> 
> Signed-off-by: Fan Li <fanofcode.li@samsung.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/node.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
> index 558048e..da0b21b 100644
> --- a/fs/f2fs/node.h
> +++ b/fs/f2fs/node.h
> @@ -224,10 +224,7 @@ static inline pgoff_t next_nat_addr(struct f2fs_sb_info *sbi,
>         struct f2fs_nm_info *nm_i = NM_I(sbi);
> 
>         block_addr -= nm_i->nat_blkaddr;
> -       if ((block_addr >> sbi->log_blocks_per_seg) % 2)
> -               block_addr -= sbi->blocks_per_seg;
> -       else
> -               block_addr += sbi->blocks_per_seg;
> +       block_addr ^= 1 << sbi->log_blocks_per_seg;
> 
>         return block_addr + nm_i->nat_blkaddr;
>  }
> --
> 2.7.4
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
