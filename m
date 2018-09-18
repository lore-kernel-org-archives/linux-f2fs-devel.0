From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: remove default option setting in
 remount
Date: Tue, 18 Sep 2018 21:20:58 +0800
Message-ID: <9bc59ef2-01cc-0cf1-1676-4d8a75514aad@kernel.org>
References: <20180918062344.3102-1-cgxu519@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1g2FwI-0003z1-5M
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 18 Sep 2018 13:21:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g2FwF-00EuHT-OH
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 18 Sep 2018 13:21:13 +0000
In-Reply-To: <20180918062344.3102-1-cgxu519@gmx.com>
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
To: Chengguang Xu <cgxu519@gmx.com>, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/9/18 14:23, Chengguang Xu wrote:
> Currently we set default value to options before parsing remount options,
> it will cause unexpected change of options which were specified in first
> mount.

Can you check below commit? It looks w/o it we may lose default option after
remount.

498c5e9fcd10 ("f2fs: add default mount options to remount")

Thanks,

> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> ---
>  fs/f2fs/super.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 00d512cd4bf2..89ea19466e80 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1499,8 +1499,6 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>  			clear_sbi_flag(sbi, SBI_NEED_SB_WRITE);
>  	}
>  
> -	default_options(sbi);
> -
>  	/* parse mount options */
>  	err = parse_options(sb, data);
>  	if (err)
> 
