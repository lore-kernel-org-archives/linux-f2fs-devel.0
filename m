From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/2] f2fs: only set project inherit bit for
 directory
Date: Thu, 13 Jun 2019 14:36:21 +0800
Message-ID: <73fb9e88-d3f5-9420-d6d8-82ff4354e4d6@huawei.com>
References: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
 <1559795545-17290-2-git-send-email-wshilong1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hbJLd-0000vN-Lu
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Jun 2019 06:36:33 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hbJLb-00BZpz-52
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Jun 2019 06:36:32 +0000
In-Reply-To: <1559795545-17290-2-git-send-email-wshilong1991@gmail.com>
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
To: Wang Shilong <wangshilong1991@gmail.com>, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Andreas Dilger <adilger@dilger.ca>, Wang Shilong <wshilong@ddn.com>

On 2019/6/6 12:32, Wang Shilong wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> It doesn't make any sense to have project inherit bits
> for regular files, even though this won't cause any
> problem, but it is better fix this.
> 
> Cc: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> ---
>  fs/f2fs/f2fs.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 06b89a9862ab..f02ebecb68ea 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2370,7 +2370,8 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
>  			   F2FS_PROJINHERIT_FL)
>  
>  /* Flags that are appropriate for regular files (all but dir-specific ones). */
> -#define F2FS_REG_FLMASK		(~(F2FS_DIRSYNC_FL | F2FS_TOPDIR_FL))
> +#define F2FS_REG_FLMASK 	(~(F2FS_DIRSYNC_FL | F2FS_TOPDIR_FL |\
> +				   F2FS_PROJINHERIT_FL))

Hi Shilong,

Could you please add below diff as ext4 did?

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index efdafa886510..295ca5ed42d9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1759,6 +1759,9 @@ static int f2fs_ioc_getflags(struct file *filp, unsigned
long arg)

 	fsflags &= F2FS_GETTABLE_FS_FL;

+	if (S_ISREG(inode->i_mode))
+		fsflags &= ~FS_PROJINHERIT_FL;
+
 	return put_user(fsflags, (int __user *)arg);
 }

Thanks,

>  
>  /* Flags that are appropriate for non-directories/regular files. */
>  #define F2FS_OTHER_FLMASK	(F2FS_NODUMP_FL | F2FS_NOATIME_FL)
> 
