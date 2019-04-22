From: Hagbard Celine <hagbardcelin@gmail.com>
Subject: Re: Possible issues with fsck of f2fs root
Date: Mon, 22 Apr 2019 09:11:31 +0200
Message-ID: <CADoWrG9FZ-MN5v2a9V3EZJ9Cj6L5CBadV836D2=MGockXsgQ_g@mail.gmail.com>
References: <CADoWrG-0GWtwqaW7rsPWLDYcoAsvXhwRa9zVib9bN94g1LLw6Q@mail.gmail.com>
 <20190416185353.GA56890@jaegeuk-macbookpro.roam.corp.google.com>
 <14c1ba5f-a636-27f6-9240-55cdef2c8c26@huawei.com>
 <20190421102703.GC7295@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <hagbardcelin@gmail.com>) id 1hIT77-0002GG-Ix
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 22 Apr 2019 07:11:41 +0000
Received: from mail-lf1-f65.google.com ([209.85.167.65])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hIT76-0055Ew-5J
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 22 Apr 2019 07:11:41 +0000
Received: by mail-lf1-f65.google.com with SMTP id i68so8291393lfi.10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 22 Apr 2019 00:11:39 -0700 (PDT)
In-Reply-To: <20190421102703.GC7295@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

With this patch the one problem with opening the device in RO mode is fixed.
But as far as I can understand it will still only check the fs, not fix it.


2019-04-21 12:27 GMT+02:00, Jaegeuk Kim <jaegeuk@kernel.org>:

>
> New version of the patch is:
>
> From 3221692b060649378f1f69b898ed85a814af3dbf Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Tue, 16 Apr 2019 11:46:31 -0700
> Subject: [PATCH] fsck.f2fs: open ro disk if we want to check fs only
>
> This patch fixes the "open failure" issue on ro disk, reported by Hagbard.
>
> "
>  If I boot with kernel option "ro rootfstype=f2fs
>  I get the following halfway trough boot:
>
>   * Checking local filesystems  ...
>  Info: Use default preen mode
>  Info: Mounted device!
>  Info: Check FS only due to RO
>          Error: Failed to open the device!
>   * Filesystems couldn't be fixed
> "
>
> Reported-by: Hagbard Celine <hagbardcelin@gmail.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  lib/libf2fs.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
> index d30047f..853e713 100644
> --- a/lib/libf2fs.c
> +++ b/lib/libf2fs.c
> @@ -789,6 +789,15 @@ void get_kernel_uname_version(__u8 *version)
>  #endif /* APPLE_DARWIN */
>
>  #ifndef ANDROID_WINDOWS_HOST
> +static int open_check_fs(char *path, int flag)
> +{
> +	if (c.func != FSCK || c.fix_on || c.auto_fix)
> +		return -1;
> +
> +	/* allow to open ro */
> +	return open(path, O_RDONLY | flag);
> +}
> +
>  int get_device_info(int i)
>  {
>  	int32_t fd = 0;
> @@ -810,8 +819,11 @@ int get_device_info(int i)
>  	if (c.sparse_mode) {
>  		fd = open(dev->path, O_RDWR | O_CREAT | O_BINARY, 0644);
>  		if (fd < 0) {
> -			MSG(0, "\tError: Failed to open a sparse file!\n");
> -			return -1;
> +			fd = open_check_fs(dev->path, O_BINARY);
> +			if (fd < 0) {
> +				MSG(0, "\tError: Failed to open a sparse file!\n");
> +				return -1;
> +			}
>  		}
>  	}
>
> @@ -825,10 +837,15 @@ int get_device_info(int i)
>  			return -1;
>  		}
>
> -		if (S_ISBLK(stat_buf->st_mode) && !c.force)
> +		if (S_ISBLK(stat_buf->st_mode) && !c.force) {
>  			fd = open(dev->path, O_RDWR | O_EXCL);
> -		else
> +			if (fd < 0)
> +				fd = open_check_fs(dev->path, O_EXCL);
> +		} else {
>  			fd = open(dev->path, O_RDWR);
> +			if (fd < 0)
> +				fd = open_check_fs(dev->path, 0);
> +		}
>  	}
>  	if (fd < 0) {
>  		MSG(0, "\tError: Failed to open the device!\n");
> --
> 2.19.0.605.g01d371f741-goog
>
>
