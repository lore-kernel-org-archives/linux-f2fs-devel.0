From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: release reserved blocks for quota
Date: Thu, 7 Dec 2017 21:24:12 -0800
Message-ID: <20171208052412.GA77074@jaegeuk-macbookpro.roam.corp.google.com>
References: <CGME20171205075320epcas5p3c146367a8d57d8b4617085982b195e40@epcas5p3.samsung.com>
 <000b01d36d9e$199ee360$4cdcaa20$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eNB91-0000Gt-Op
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Dec 2017 05:24:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eNB91-0003qv-1h
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Dec 2017 05:24:19 +0000
Content-Disposition: inline
In-Reply-To: <000b01d36d9e$199ee360$4cdcaa20$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: LiFan <fanofcode.li@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 12/05, LiFan wrote:
> 
> Quota has been modified during inc_valid_block_count(), but not in
> truncate process. This patch adds it.
> 
> Signed-off-by: Fan li <fanofcode.li@samsung.com>
> ---
>  fs/f2fs/f2fs.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 82f1dc3..71fbba96 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1619,7 +1619,9 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
>  		sbi->current_reserved_blocks = min(sbi->reserved_blocks,
>  					sbi->current_reserved_blocks + count);
>  	spin_unlock(&sbi->stat_lock);
> +
>  	f2fs_i_blocks_write(inode, count, false, true);
> +	dquot_release_reservation_block(inode, count);

The f2fs_i_blocks_write() actually handles allocation, and reserved blocks are
only used for inc_valid_block_count().

Thanks,

>  }
>  
>  static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
> -- 
> 2.7.4
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
