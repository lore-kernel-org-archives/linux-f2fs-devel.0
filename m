From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [linux-next] [PATCH] Doc: f2fs: Fix typo in
 Documentation/filesystems/f2fs.txt
Date: Tue, 24 Jan 2017 13:36:42 +0900
Message-ID: <20170124043642.GD1566@jaegeuk.local>
References: <20170124034755.20965-1-standby24x7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170124034755.20965-1-standby24x7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masanari Iida <standby24x7@gmail.com>
Cc: linux-kernel@vger.kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net, corbet@lwn.net, linux-doc@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hello,

Applied to f2fs.git.

Thanks,

On 01/24, Masanari Iida wrote:
> This patch fix a typo in f2fs.txt
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  Documentation/filesystems/f2fs.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
> index d99faced79cb..0ab33d4c8406 100644
> --- a/Documentation/filesystems/f2fs.txt
> +++ b/Documentation/filesystems/f2fs.txt
> @@ -131,7 +131,7 @@ inline_dentry          Enable the inline dir feature: data in new created
>                         directory entries can be written into inode block. The
>                         space of inode block which is used to store inline
>                         dentries is limited to ~3.4k.
> -noinline_dentry        Diable the inline dentry feature.
> +noinline_dentry        Disable the inline dentry feature.
>  flush_merge	       Merge concurrent cache_flush commands as much as possible
>                         to eliminate redundant command issues. If the underlying
>  		       device handles the cache_flush command relatively slowly,
> -- 
> 2.11.0.453.g787f75f0567a
