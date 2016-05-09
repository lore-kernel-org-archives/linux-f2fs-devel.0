From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 5/6] f2fs: enable inline_dentry by default
Date: Mon, 9 May 2016 16:04:51 -0700
Message-ID: <20160509230451.GB7448@jaegeuk.gateway>
References: <20160509115635.123946-1-yuchao0@huawei.com>
	<20160509115635.123946-5-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1azuEX-00047n-0U
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 09 May 2016 23:05:01 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1azuEW-0007aK-A9
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 09 May 2016 23:05:00 +0000
Content-Disposition: inline
In-Reply-To: <20160509115635.123946-5-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Mon, May 09, 2016 at 07:56:34PM +0800, Chao Yu wrote:
> Make inline_dentry as default mount option to improve space usage and
> IO performance in scenario of numerous small directory.

Hmm, I've not much tested this so far.
Let me take time to consider this for a while.

Thanks,

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 28c8992..4a4f4bd 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -824,6 +824,7 @@ static void default_options(struct f2fs_sb_info *sbi)
>  
>  	set_opt(sbi, BG_GC);
>  	set_opt(sbi, INLINE_DATA);
> +	set_opt(sbi, INLINE_DENTRY);
>  	set_opt(sbi, EXTENT_CACHE);
>  
>  #ifdef CONFIG_F2FS_FS_XATTR
> -- 
> 2.8.2.311.gee88674

------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
