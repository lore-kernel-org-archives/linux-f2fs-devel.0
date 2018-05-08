From: Junling Zheng <zhengjunling@huawei.com>
Subject: Re: [PATCH] sload.f2fs: give correct file type
Date: Tue, 8 May 2018 10:11:57 +0800
Message-ID: <f2305d45-7866-801a-328a-a0574ea504be@huawei.com>
References: <20180507185833.76359-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengjunling@huawei.com>) id 1fFs6m-0007k2-2O
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 May 2018 02:12:04 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fFs6j-00BCb1-Kc
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 May 2018 02:12:03 +0000
In-Reply-To: <20180507185833.76359-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: Lianjun Huang <huanglianjun@vivo.com>

Hi, Jaegeuk

My previous patch (sload.f2fs: fix the missing of bit mask for file type) had
already fix this bug :)

Thanks,
Junling

On 2018/5/8 2:58, Jaegeuk Kim wrote:
> From: Lianjun Huang <huanglianjun@vivo.com>
> 
> This fixes permission error due to wrong file type.
> 
> Signed-off-by: Lianjun Huang <huanglianjun@vivo.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fsck/sload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fsck/sload.c b/fsck/sload.c
> index 2842f2c..2fb13f2 100644
> --- a/fsck/sload.c
> +++ b/fsck/sload.c
> @@ -106,7 +106,7 @@ static int set_perms_and_caps(struct dentry *de)
>  
>  	/* Permissions */
>  	if (fs_config_func != NULL) {
> -		fs_config_func(mnt_path, S_ISDIR(de->mode),
> +		fs_config_func(mnt_path, de->file_type == F2FS_FT_DIR,
>  				c.target_out_dir, &uid, &gid, &imode,
>  				&capabilities);
>  		de->uid = uid & 0xffff;
> 



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
