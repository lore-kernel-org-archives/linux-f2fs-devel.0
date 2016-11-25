From: Junling Zheng <zhengjunling@huawei.com>
Subject: Re: [PATCH] resize.f2fs: fix an error in migrate_ssa
Date: Fri, 25 Nov 2016 11:32:29 +0800
Message-ID: <5837B0CD.4020206@huawei.com>
References: <20161124073315.26936-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhengjunling@huawei.com>) id 1cA7Fr-0001gz-DM
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Nov 2016 03:32:51 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cA7Fo-0004Vc-QR
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Nov 2016 03:32:51 +0000
In-Reply-To: <20161124073315.26936-1-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com

How about the following patch, which I think would be a little better :)

diff --git a/fsck/resize.c b/fsck/resize.c
index 46aa30e..c295a06 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -207,30 +207,33 @@ static void migrate_ssa(struct f2fs_sb_info *sbi,
 	block_t old_sum_blkaddr = get_sb(ssa_blkaddr);
 	block_t new_sum_blkaddr = get_newsb(ssa_blkaddr);
 	block_t end_sum_blkaddr = get_newsb(main_blkaddr);
+	block_t expand_sum_blkaddr = new_sum_blkaddr +
+					TOTAL_SEGS(sbi) - offset;
 	block_t blkaddr;
+	int ret;
 	void *zero_block = calloc(BLOCK_SZ, 1);
-
 	ASSERT(zero_block);

 	if (offset && new_sum_blkaddr < old_sum_blkaddr + offset) {
 		blkaddr = new_sum_blkaddr;
 		while (blkaddr < end_sum_blkaddr) {
-			if (blkaddr - new_sum_blkaddr < TOTAL_SEGS(sbi))
-				move_ssa(sbi, offset, blkaddr);
-			else
-				dev_write_block(zero_block, blkaddr);
-			offset++;
-			blkaddr++;
+			if (blkaddr < expand_sum_blkaddr)
+				move_ssa(sbi, offset++, blkaddr++);
+			else {
+				dev_write_block(zero_block, blkaddr++);
+				ASSERT(ret >=0);
+			}
 		}
 	} else {
 		blkaddr = end_sum_blkaddr - 1;
 		offset = TOTAL_SEGS(sbi) - 1;
 		while (blkaddr >= new_sum_blkaddr) {
-			if (blkaddr >= TOTAL_SEGS(sbi) + new_sum_blkaddr)
-				dev_write_block(zero_block, blkaddr);
+			if (blkaddr >= expand_sum_blkaddr) {
+				dev_write_block(zero_block, blkaddr--);
+				ASSERT(ret >=0);
+			}
 			else
-				move_ssa(sbi, offset--, blkaddr);
-			blkaddr--;
+				move_ssa(sbi, offset--, blkaddr--);
 		}
 	}


On 2016/11/24 15:33, Yunlei He wrote:
> This patch fix an error in migrate_ssa when resize with condition
> that offset is not zero && new_sum_blkaddr > old_sum_blkaddr + offset
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fsck/resize.c | 37 +++++++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/fsck/resize.c b/fsck/resize.c
> index 46aa30e..70dbef5 100644
> --- a/fsck/resize.c
> +++ b/fsck/resize.c
> @@ -208,28 +208,45 @@ static void migrate_ssa(struct f2fs_sb_info *sbi,
>  	block_t new_sum_blkaddr = get_newsb(ssa_blkaddr);
>  	block_t end_sum_blkaddr = get_newsb(main_blkaddr);
>  	block_t blkaddr;
> +	unsigned int offset1 = offset;
> +	int ret = 1;
>  	void *zero_block = calloc(BLOCK_SZ, 1);
>  
>  	ASSERT(zero_block);
>  
> -	if (offset && new_sum_blkaddr < old_sum_blkaddr + offset) {
> -		blkaddr = new_sum_blkaddr;
> -		while (blkaddr < end_sum_blkaddr) {
> -			if (blkaddr - new_sum_blkaddr < TOTAL_SEGS(sbi))
> -				move_ssa(sbi, offset, blkaddr);
> -			else
> -				dev_write_block(zero_block, blkaddr);
> -			offset++;
> -			blkaddr++;
> +	if (offset) {
> +		if (new_sum_blkaddr < old_sum_blkaddr + offset) {
> +			blkaddr = new_sum_blkaddr;
> +			while (blkaddr < end_sum_blkaddr) {
> +				if (blkaddr - new_sum_blkaddr < TOTAL_SEGS(sbi) - offset1)
> +					move_ssa(sbi, offset, blkaddr);
> +				else
> +					ret = dev_write_block(zero_block, blkaddr);
> +				ASSERT(ret >= 0);
> +				offset++;
> +				blkaddr++;
> +			}
> +		} else {
> +			blkaddr = end_sum_blkaddr - 1;
> +			offset = TOTAL_SEGS(sbi)-1;
> +			while (blkaddr >= new_sum_blkaddr) {
> +				if (blkaddr >= TOTAL_SEGS(sbi) - offset1 + new_sum_blkaddr)
> +					ret = dev_write_block(zero_block, blkaddr);
> +				else
> +					move_ssa(sbi, offset--, blkaddr);
> +				ASSERT(ret >= 0);
> +				blkaddr--;
> +			}
>  		}
>  	} else {
>  		blkaddr = end_sum_blkaddr - 1;
>  		offset = TOTAL_SEGS(sbi) - 1;
>  		while (blkaddr >= new_sum_blkaddr) {
>  			if (blkaddr >= TOTAL_SEGS(sbi) + new_sum_blkaddr)
> -				dev_write_block(zero_block, blkaddr);
> +				ret = dev_write_block(zero_block, blkaddr);
>  			else
>  				move_ssa(sbi, offset--, blkaddr);
> +			ASSERT(ret >= 0);
>  			blkaddr--;
>  		}
>  	}
> 



------------------------------------------------------------------------------
