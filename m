From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: remove QUOTA flag setting in
 f2fs_set_qf_name()
Date: Sat, 29 Sep 2018 19:03:32 +0800
Message-ID: <447e5f6c-6700-419e-0184-8d79ffb97e64@huawei.com>
References: <20180927152314.23190-1-cgxu519@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1g6D2I-00085i-MB
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 29 Sep 2018 11:03:46 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g6D2H-00E5hE-1P
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 29 Sep 2018 11:03:46 +0000
In-Reply-To: <20180927152314.23190-1-cgxu519@gmx.com>
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
To: Chengguang Xu <cgxu519@gmx.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/9/27 23:23, Chengguang Xu wrote:
> Mount flag QUOTA is the same as flag USRQUOTA in f2fs, so should not
> set flag QUOTA in f2fs_set_qf_name().

Those journalled quota codes were copied from ext4, I'm not sure, maybe
there are some userspace tools replying on this mount option, for example,
apps can check 'quota' mount option to know whether current filesystem
support quota feature, can you check that?

Thanks,

> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> ---
>  fs/f2fs/super.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 896b885f504e..e2abd45c2cdd 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -286,7 +286,6 @@ static int f2fs_set_qf_name(struct super_block *sb, int qtype,
>  		goto errout;
>  	}
>  	F2FS_OPTION(sbi).s_qf_names[qtype] = qname;
> -	set_opt(sbi, QUOTA);
>  	return 0;
>  errout:
>  	kfree(qname);
> 
