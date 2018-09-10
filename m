From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: surround fault_injection ralted option
 parsing using CONFIG_F2FS_FAULT_INJECTION
Date: Tue, 11 Sep 2018 00:15:56 +0800
Message-ID: <1313486d-8a86-d365-b843-0e6811050d92@kernel.org>
References: <20180910154807.29035-1-cgxu519@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1fzOrA-00063D-G1
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Sep 2018 16:16:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fzOr8-00DgA1-2Z
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Sep 2018 16:16:08 +0000
In-Reply-To: <20180910154807.29035-1-cgxu519@gmx.com>
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

On 2018/9/10 23:48, Chengguang Xu wrote:
> It's a little bit strange when fault_injection related
> options fail with -EINVAL which were already disabled
> from config, so surround all fault_injection related option
> parsing code using CONFIG_F2FS_FAULT_INJECTION. Meanwhile,
> slightly change warning message to keep consistency with
> option POSIX_ACL and FS_XATTR.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> ---
>  fs/f2fs/super.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 896b885f504e..cc49cc10d9f5 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -602,28 +602,31 @@ static int parse_options(struct super_block *sb, char *options)
>  			}
>  			F2FS_OPTION(sbi).write_io_size_bits = arg;
>  			break;
> +#ifdef CONFIG_F2FS_FAULT_INJECTION
>  		case Opt_fault_injection:
>  			if (args->from && match_int(args, &arg))
>  				return -EINVAL;
> -#ifdef CONFIG_F2FS_FAULT_INJECTION
>  			f2fs_build_fault_attr(sbi, arg, F2FS_ALL_FAULT_TYPE);
>  			set_opt(sbi, FAULT_INJECTION);
> -#else
> -			f2fs_msg(sb, KERN_INFO,
> -				"FAULT_INJECTION was not selected");
> -#endif
>  			break;
> +
>  		case Opt_fault_type:
>  			if (args->from && match_int(args, &arg))
>  				return -EINVAL;
> -#ifdef CONFIG_F2FS_FAULT_INJECTION
>  			f2fs_build_fault_attr(sbi, 0, arg);
>  			set_opt(sbi, FAULT_INJECTION);
> +			break;
>  #else
> +		case Opt_fault_injection:
>  			f2fs_msg(sb, KERN_INFO,
> -				"FAULT_INJECTION was not selected");
> -#endif
> +				"FAULT_INJECTION not supported");

"fault_injection options not supported"

>  			break;
> +
> +		case Opt_fault_type:
> +			f2fs_msg(sb, KERN_INFO,
> +				"FAULT_INJECTION not supported");

"fault_type options not supported"

Thanks,

> +			break;
> +#endif
>  		case Opt_lazytime:
>  			sb->s_flags |= SB_LAZYTIME;
>  			break;
> 
