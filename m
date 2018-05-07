From: Junling Zheng <zhengjunling@huawei.com>
Subject: Re: [PATCH] sload.f2fs: fix the missing of bit mask for
 file type
Date: Mon, 7 May 2018 17:44:15 +0800
Message-ID: <acce8587-c6e4-7568-8dbe-40dd275c1674@huawei.com>
References: <20180503112506.229441-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengjunling@huawei.com>) id 1fFcgy-00065F-6O
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 May 2018 09:44:24 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fFcgw-009nRe-0U
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 May 2018 09:44:24 +0000
In-Reply-To: <20180503112506.229441-1-zhengjunling@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Hi, Jaegeuk

Could you please merge this fix into external/f2fs-tools repo for AOSP?
Since we found this bug while using sload feature in Android P :)

Thanks,
Junling

On 2018/5/3 19:25, Junling Zheng wrote:
> Fix the missing of bit mask for the file type bit fields.
> 
> Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> ---
>  fsck/sload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fsck/sload.c b/fsck/sload.c
> index 2842f2c..1b7a2d1 100644
> --- a/fsck/sload.c
> +++ b/fsck/sload.c
> @@ -157,7 +157,7 @@ static void set_inode_metadata(struct dentry *de)
>  
>  	de->size = stat.st_size;
>  	de->mode = stat.st_mode &
> -			(S_ISUID|S_ISGID|S_ISVTX|S_IRWXU|S_IRWXG|S_IRWXO);
> +			(S_IFMT|S_ISUID|S_ISGID|S_ISVTX|S_IRWXU|S_IRWXG|S_IRWXO);
>  	if (c.fixed_time == -1 && c.from_dir)
>  		de->mtime = stat.st_mtime;
>  	else
> 



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
