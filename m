From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: relax EIO injection for quota file
Date: Sun, 22 Oct 2017 23:11:08 +0800
Message-ID: <b8e70503-c0e3-22b2-a1fe-089f8fb206a6@kernel.org>
References: <20171019165617.79128-1-jaegeuk@kernel.org>
 <20171019165617.79128-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1e6HuN-0003wc-03
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 22 Oct 2017 15:11:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e6HuM-0007Jg-7a
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 22 Oct 2017 15:11:22 +0000
In-Reply-To: <20171019165617.79128-2-jaegeuk@kernel.org>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/10/20 0:56, Jaegeuk Kim wrote:
> This case is not happening easily.

Actually it can happen, so why not just keep it?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/f2fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e0ef31cb2cc6..6301ccca8888 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1544,7 +1544,7 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>  		return ret;
>  
>  #ifdef CONFIG_F2FS_FAULT_INJECTION
> -	if (time_to_inject(sbi, FAULT_BLOCK)) {
> +	if (!IS_NOQUOTA(inode) && time_to_inject(sbi, FAULT_BLOCK)) {
>  		f2fs_show_injection_info(FAULT_BLOCK);
>  		release = *count;
>  		goto enospc;
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
