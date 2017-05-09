From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: make sure f2fs_gc returns consistent
 errno
Date: Tue, 9 May 2017 23:25:35 +0800
Message-ID: <494c3854-000d-c61c-caca-5a152ec6ff08@kernel.org>
References: <20170509113754.53173-1-guoweichao@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1d872J-0004nV-Rt
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 09 May 2017 15:26:51 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d872G-0001ut-Fb
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 09 May 2017 15:26:51 +0000
In-Reply-To: <20170509113754.53173-1-guoweichao@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Weichao Guo <guoweichao@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/5/9 19:37, Weichao Guo wrote:
> By default, f2fs_gc returns -EINVAL in general error cases, e.g., no victim
> was selected. However, the default errno may be overwritten in two cases:
> gc_more and BG_GC -> FG_GC. We should return consistent errno in such cases.

How about clean up this patch as below, which always set return value
before jumping to 'stop' tag.

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ac2f74e40eea..6906a284c98d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -957,7 +957,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 {
 	int gc_type = sync ? FG_GC : BG_GC;
 	int sec_freed = 0;
-	int ret = -EINVAL;
+	int ret;
 	struct cp_control cpc;
 	unsigned int init_segno = segno;
 	struct gc_inode_list gc_list = {
@@ -967,8 +967,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,

 	cpc.reason = __get_cp_reason(sbi);
 gc_more:
-	if (unlikely(!(sbi->sb->s_flags & MS_ACTIVE)))
+	if (unlikely(!(sbi->sb->s_flags & MS_ACTIVE))) {
+		ret = -EINVAL;
 		goto stop;
+	}
 	if (unlikely(f2fs_cp_error(sbi))) {
 		ret = -EIO;
 		goto stop;
@@ -989,6 +991,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 			gc_type = FG_GC;
 	}

+	ret = -EINVAL;
 	/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
 	if (gc_type == BG_GC && !background)
 		goto stop;

Thanks,

> 
> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
> ---
>  fs/f2fs/gc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 0265221..32c9463 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -965,6 +965,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>  
>  	cpc.reason = __get_cp_reason(sbi);
>  gc_more:
> +	ret = -EINVAL;
>  	if (unlikely(!(sbi->sb->s_flags & MS_ACTIVE)))
>  		goto stop;
>  	if (unlikely(f2fs_cp_error(sbi))) {
> @@ -982,6 +983,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>  			ret = write_checkpoint(sbi, &cpc);
>  			if (ret)
>  				goto stop;
> +			else
> +				ret = -EINVAL;
>  		}
>  		if (has_not_enough_free_secs(sbi, 0, 0))
>  			gc_type = FG_GC;
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
