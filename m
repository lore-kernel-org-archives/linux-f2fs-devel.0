From: Sheng Yong <shengyong1@huawei.com>
Subject: Re: [PATCH] fsck.f2fs: detect and recover corrupted
 quota file
Date: Wed, 19 Sep 2018 09:48:53 +0800
Message-ID: <0c46376e-8f21-ff13-cec2-ac8f06b68ffa@huawei.com>
References: <20180919012837.92414-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1g2Rc3-0001qE-IU
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 19 Sep 2018 01:49:07 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g2Rc1-00FPi0-MC
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 19 Sep 2018 01:49:07 +0000
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 128E2411107
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 19 Sep 2018 09:48:58 +0800 (CST)
In-Reply-To: <20180919012837.92414-1-yuchao0@huawei.com>
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
To: linux-f2fs-devel@lists.sourceforge.net

Hi, Chao

On 2018/9/19 9:28, Chao Yu wrote:
> Once quota file is corrupted, kernel will set CP_QUOTA_NEED_FSCK_FLAG
> into checkpoint pack, this patch makes fsck supporting to detect the flag
> and try to rebuild corrupted quota file.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>   fsck/fsck.c       |  3 ++-
>   fsck/main.c       |  1 +
>   fsck/mount.c      | 11 +++++++++--
>   include/f2fs_fs.h |  2 ++
>   4 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index 40b95f7054a2..28c913b83355 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -2670,7 +2670,8 @@ int fsck_verify(struct f2fs_sb_info *sbi)
>   				flush_curseg_sit_entries(sbi);
>   			}
>   			fix_checkpoint(sbi);
> -		} else if (is_set_ckpt_flags(cp, CP_FSCK_FLAG)) {
> +		} else if (is_set_ckpt_flags(cp, CP_FSCK_FLAG) ||
> +			is_set_ckpt_flags(cp, CP_QUOTA_NEED_FSCK_FLAG)) {
>   			write_checkpoint(sbi);
>   		}
>   	}
> diff --git a/fsck/main.c b/fsck/main.c
> index 714e28a509b9..e20f31ca09e4 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -162,6 +162,7 @@ static void add_default_options(void)
>   	case CONF_ANDROID:
>   		__add_fsck_options();
>   	}
> +	c.quota_fix = 1;
>   }
>   
>   void f2fs_parse_options(int argc, char *argv[])
> diff --git a/fsck/mount.c b/fsck/mount.c
> index 6a3382dbd449..21a39a7222c6 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -405,6 +405,8 @@ void print_ckpt_info(struct f2fs_sb_info *sbi)
>   void print_cp_state(u32 flag)
>   {
>   	MSG(0, "Info: checkpoint state = %x : ", flag);
> +	if (flag & CP_QUOTA_NEED_FSCK_FLAG)
> +		MSG(0, "%s", " quota_need_fsck");
>   	if (flag & CP_LARGE_NAT_BITMAP_FLAG)
>   		MSG(0, "%s", " large_nat_bitmap");
>   	if (flag & CP_NOCRC_RECOVERY_FLAG)
> @@ -2541,12 +2543,17 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
>   
>   	print_ckpt_info(sbi);
>   
> +	if (c.quota_fix) {
> +		if (get_cp(ckpt_flags) & CP_QUOTA_NEED_FSCK_FLAG)
> +			c.fix_on = 1;
> +	}
> +

I think we don't need the quota_fix, if -f is set, fsck will always check
quota files. If anything wrong, fix_on will be set.

thanks,

>   	if (c.auto_fix || c.preen_mode) {
>   		u32 flag = get_cp(ckpt_flags);
>   
>   		if (flag & CP_FSCK_FLAG ||
> -			(exist_qf_ino(sb) && (!(flag & CP_UMOUNT_FLAG) ||
> -						flag & CP_ERROR_FLAG))) {
> +			flag & CP_QUOTA_NEED_FSCK_FLAG ||
> +			(exist_qf_ino(sb) && (flag & CP_ERROR_FLAG))) {
>   			c.fix_on = 1;
>   		} else if (!c.preen_mode) {
>   			print_cp_state(flag);
> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> index 9396c785a254..160eaf72f0b6 100644
> --- a/include/f2fs_fs.h
> +++ b/include/f2fs_fs.h
> @@ -372,6 +372,7 @@ struct f2fs_configuration {
>   	int defset;
>   	int bug_on;
>   	int auto_fix;
> +	int quota_fix;
>   	int preen_mode;
>   	int ro;
>   	int preserve_limits;		/* preserve quota limits */
> @@ -641,6 +642,7 @@ struct f2fs_super_block {
>   /*
>    * For checkpoint
>    */
> +#define CP_QUOTA_NEED_FSCK_FLAG		0x00000800
>   #define CP_LARGE_NAT_BITMAP_FLAG	0x00000400
>   #define CP_NOCRC_RECOVERY_FLAG	0x00000200
>   #define CP_TRIMMED_FLAG		0x00000100
> 
