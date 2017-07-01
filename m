From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: avoid unnecessary function call
Date: Sat, 1 Jul 2017 00:39:32 -0700
Message-ID: <20170701073932.GA85052@jaegeuk-macbookpro.roam.corp.google.com>
References: <22a88618.4a1.15cfb3e2aeb.Coremail.kernelpatch@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1dRD0F-00060b-Da
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 01 Jul 2017 07:39:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dRD0E-0008Nx-JT
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 01 Jul 2017 07:39:39 +0000
Content-Disposition: inline
In-Reply-To: <22a88618.4a1.15cfb3e2aeb.Coremail.kernelpatch@126.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Tiezhu Yang <kernelpatch@126.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 07/01, Tiezhu Yang wrote:
> It should call the function fscrypt_fname_free_buffer() in the exception
> handling only after the function fscrypt_fname_alloc_buffer() returns 0,
> otherwise it is unnecessary.

Hi, fscrypt_fname_free_buffer returns if crypto_str is null. So, this flow
has no problem, which would be a quite conventional flow, no?

Thanks,

> Signed-off-by: Tiezhu Yang <kernelpatch@126.com>
> ---
>  fs/f2fs/namei.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index c31b40e..3225a82 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -1036,12 +1036,12 @@ static const char *f2fs_encrypted_get_link(struct dentry *dentry,
>  
>  	res = fscrypt_fname_disk_to_usr(inode, 0, 0, &cstr, &pstr);
>  	if (res)
> -		goto errout;
> +		goto out;
>  
>  	/* this is broken symlink case */
>  	if (unlikely(pstr.name[0] == 0)) {
>  		res = -ENOENT;
> -		goto errout;
> +		goto out;
>  	}
>  
>  	paddr = pstr.name;
> @@ -1052,8 +1052,9 @@ static const char *f2fs_encrypted_get_link(struct dentry *dentry,
>  	put_page(cpage);
>  	set_delayed_call(done, kfree_link, paddr);
>  	return paddr;
> -errout:
> +out:
>  	fscrypt_fname_free_buffer(&pstr);
> +errout:
>  	put_page(cpage);
>  	return ERR_PTR(res);
>  }
> -- 
> 1.8.3.1

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
