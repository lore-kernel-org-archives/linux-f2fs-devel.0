From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: Replace strncpy with memcpy
Date: Mon, 2 Jul 2018 09:53:28 +0800
Message-ID: <0250de00-adf7-7b43-5f7c-44704119e2f9@huawei.com>
References: <1530478626-15753-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530478626-15753-1-git-send-email-linux@roeck-us.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/7/2 4:57, Guenter Roeck wrote:
> gcc 8.1.0 complains:
> 
> fs/f2fs/namei.c: In function 'f2fs_update_extension_list':
> fs/f2fs/namei.c:257:3: warning:
> 	'strncpy' output truncated before terminating nul copying
> 	as many bytes from a string as its length
> fs/f2fs/namei.c:249:3: warning:
> 	'strncpy' output truncated before terminating nul copying
> 	as many bytes from a string as its length
> 
> Using strncpy() is indeed less than perfect since the length of data to
> be copied has already been determined with strlen(). Replace strncpy()
> with memcpy() to address the warning and optimize the code a little.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  fs/f2fs/namei.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 231b7f3ea7d3..e75607544f7c 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -246,7 +246,7 @@ int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
>  		return -EINVAL;
>  
>  	if (hot) {
> -		strncpy(extlist[count], name, strlen(name));
> +		memcpy(extlist[count], name, strlen(name));

How about replacing with strcpy(extlist[count], name)? Because name length has
already been checked before f2fs_update_extension_list, it should be valid, and
will not cause overflow during copying.

Thanks,

>  		sbi->raw_super->hot_ext_count = hot_count + 1;
>  	} else {
>  		char buf[F2FS_MAX_EXTENSION][F2FS_EXTENSION_LEN];
> @@ -254,7 +254,7 @@ int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
>  		memcpy(buf, &extlist[cold_count],
>  				F2FS_EXTENSION_LEN * hot_count);
>  		memset(extlist[cold_count], 0, F2FS_EXTENSION_LEN);
> -		strncpy(extlist[cold_count], name, strlen(name));
> +		memcpy(extlist[cold_count], name, strlen(name));
>  		memcpy(&extlist[cold_count + 1], buf,
>  				F2FS_EXTENSION_LEN * hot_count);
>  		sbi->raw_super->extension_count = cpu_to_le32(cold_count + 1);
> 
