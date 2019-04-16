From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs-tools: fix an improper #ifdef wrap for
 Android
Date: Tue, 16 Apr 2019 13:35:12 -0700
Message-ID: <20190416203512.GE56890@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190416075958.11857-1-qkrwngud825@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1hGUnY-00060b-3W
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Apr 2019 20:35:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hGUnW-009eSg-F7
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Apr 2019 20:35:19 +0000
Content-Disposition: inline
In-Reply-To: <20190416075958.11857-1-qkrwngud825@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Park Ju Hyung <qkrwngud825@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 04/16, Park Ju Hyung wrote:
> Commit 595fd57a4fd3 ("f2fs-tools: get kernel version via uname(2)")
> introduced support for reading kernel version without /proc/version's
> presence but improperly wrapped an #ifdef macro for Android, causing
> f2fs-tools usage on every Android devices to display
> "Info: No support kernel version!".
> 
> Fix this by properly wrapping the problematic #ifdef macro.
> 
> Also remove 'c.kd = -2' as it will be set to -1 upon open(2) failure
> and the rest of the source code isn't doing anything special with
> 'kd == -2'.
> 
> Additionally, show the message when uname(2) also fails from
> get_kernel_uname_version().
> 
> Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
> ---
>  lib/libf2fs.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
> index 60b84e0..61fc7ec 100644
> --- a/lib/libf2fs.c
> +++ b/lib/libf2fs.c
> @@ -751,23 +751,23 @@ void get_kernel_version(__u8 *version)
>  
>  void get_kernel_uname_version(__u8 *version)
>  {
> +	memset(version, 0, VERSION_LEN);
> +
>  #ifdef HAVE_SYS_UTSNAME_H
>  	struct utsname buf;
>  
> -	memset(version, 0, VERSION_LEN);
> -	if (uname(&buf))
> -		return;
> -
> +	if (uname(&buf) == 0) {
>  #if !defined(WITH_KERNEL_VERSION)
> -	snprintf((char *)version,
> -		VERSION_LEN, "%s %s", buf.release, buf.version);
> +		snprintf((char *)version,
> +			VERSION_LEN, "%s %s", buf.release, buf.version);
>  #else
> -	snprintf((char *)version,
> -		VERSION_LEN, "%s", buf.release);
> +		snprintf((char *)version,
> +			VERSION_LEN, "%s", buf.release);
>  #endif
> -#else
> -	memset(version, 0, VERSION_LEN);
> +	}
>  #endif
> +
> +	MSG(0, "\tInfo: Unable to get the kernel version!\n");
>  }
>  
>  #if defined(__linux__) && defined(_IO) && !defined(BLKGETSIZE)
> @@ -845,15 +845,11 @@ int get_device_info(int i)
>  		}
>  	}
>  
> -	if (c.kd == -1) {
>  #if !defined(WITH_ANDROID) && defined(__linux__)
> +	// If this fails, we'll retry with get_kernel_uname_version()
> +	if (c.kd == -1)
>  		c.kd = open("/proc/version", O_RDONLY);
>  #endif
> -		if (c.kd < 0) {
> -			MSG(0, "\tInfo: No support kernel version!\n");
> -			c.kd = -2;

If there are multiple devices, we don't need to get the version redundantly.

> -		}
> -	}
>  
>  	if (c.sparse_mode) {
>  		dev->total_sectors = c.device_size / dev->sector_size;
> -- 
> 2.21.0
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
