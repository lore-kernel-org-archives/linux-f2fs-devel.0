From: Junling Zheng <zhengjunling@huawei.com>
Subject: Re: [PATCH] fsck.f2fs: do umount to free memory in
 out_err
Date: Thu, 17 May 2018 18:12:14 +0800
Message-ID: <540974fb-a702-471b-2bfd-7b737463522d@huawei.com>
References: <20180517075704.168718-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengjunling@huawei.com>) id 1fJFtT-00089g-Dv
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 17 May 2018 10:12:19 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fJFtR-0074R3-99
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 17 May 2018 10:12:19 +0000
In-Reply-To: <20180517075704.168718-1-zhengjunling@huawei.com>
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

Sorry, this patch has a bug:

If f2fs_do_mount fails in validate_super_block or get_valid_checkpoint,
then we should only free sbi->ckpt and sbi->raw_super :(

On 2018/5/17 15:57, Junling Zheng wrote:
> Call f2fs_do_umount to free memory in out_err branch.
> 
> Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
> ---
>  fsck/main.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fsck/main.c b/fsck/main.c
> index c4dd8b1..870f2d8 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -844,9 +844,6 @@ retry:
>  	return 0;
>  
>  out_err:
> -	if (sbi->ckpt)
> -		free(sbi->ckpt);
> -	if (sbi->raw_super)
> -		free(sbi->raw_super);
> +	f2fs_do_umount(sbi);
>  	return ret;
>  }
> 



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
