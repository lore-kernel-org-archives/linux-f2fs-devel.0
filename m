From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 1/3] f2fs: early check broken symlink length
	in	the encrypted case
Date: Tue, 29 Dec 2015 09:52:49 +0800
Message-ID: <00a701d141db$c2f7d480$48e77d80$@samsung.com>
References: <1451345497-65784-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aDjUU-0002FW-S2
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Dec 2015 01:54:22 +0000
Received: from [203.254.224.24] (helo=mailout1.samsung.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aDjUS-0003Vp-OG
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Dec 2015 01:54:22 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O0301L4QJXTIJA0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Dec 2015 10:53:53 +0900 (KST)
In-reply-to: <1451345497-65784-1-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, December 29, 2015 7:32 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 1/3] f2fs: early check broken symlink length in the encrypted case
> 
> If link is broken, its len is zero, and we don't need to move forward.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/namei.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index fb41c80..5cc4128 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -931,7 +931,7 @@ static const char *f2fs_encrypted_follow_link(struct dentry *dentry, void
> **cook
>  {
>  	struct page *cpage = NULL;
>  	char *caddr, *paddr = NULL;
> -	struct f2fs_str cstr;
> +	struct f2fs_str cstr = FSTR_INIT(NULL, 0);
>  	struct f2fs_str pstr = FSTR_INIT(NULL, 0);
>  	struct inode *inode = d_inode(dentry);
>  	struct f2fs_encrypted_symlink_data *sd;
> @@ -952,6 +952,12 @@ static const char *f2fs_encrypted_follow_link(struct dentry *dentry, void
> **cook
>  	/* Symlink is encrypted */
>  	sd = (struct f2fs_encrypted_symlink_data *)caddr;
>  	cstr.len = le16_to_cpu(sd->len);
> +
> +	/* this is broken symlink case */
> +	if (cstr.len == 0) {

This case seems rare, can we add unlikely here?

> +		res = -ENOENT;
> +		goto errout;
> +	}
>  	cstr.name = kmalloc(cstr.len, GFP_NOFS);
>  	if (!cstr.name) {
>  		res = -ENOMEM;
> @@ -960,7 +966,7 @@ static const char *f2fs_encrypted_follow_link(struct dentry *dentry, void
> **cook
>  	memcpy(cstr.name, sd->encrypted_path, cstr.len);
> 
>  	/* this is broken symlink case */
> -	if (cstr.name[0] == 0 && cstr.len == 0) {
> +	if (cstr.name[0] == 0) {

ditto.

Thanks,

>  		res = -ENOENT;
>  		goto errout;
>  	}
> --
> 2.5.4 (Apple Git-61)
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
