From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: add additional sanity check in
 f2fs_acl_from_disk()
Date: Tue, 4 Sep 2018 21:28:22 -0700
Message-ID: <20180905042822.GA17417@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180830133331.5503-1-cgxu519@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fxPQh-0005mJ-GL
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Sep 2018 04:28:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fxPQg-001JbT-5R
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Sep 2018 04:28:35 +0000
Content-Disposition: inline
In-Reply-To: <20180830133331.5503-1-cgxu519@gmx.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chengguang Xu <cgxu519@gmx.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 08/30, Chengguang Xu wrote:
> Add additinal sanity check for irregular case(e.g. corruption).
> If size of extended attribution is smaller than size of acl header,
> then return -EINVAL.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> ---
>  fs/f2fs/acl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
> index 111824199a88..79e9ea773070 100644
> --- a/fs/f2fs/acl.c
> +++ b/fs/f2fs/acl.c
> @@ -53,6 +53,9 @@ static struct posix_acl *f2fs_acl_from_disk(const char *value, size_t size)
>  	struct f2fs_acl_entry *entry = (struct f2fs_acl_entry *)(hdr + 1);
>  	const char *end = value + size;
>  
> +	if (size < sizeof(f2fs_acl_header))

		sizeof(struct f2fs_acl_header)

I fixed the above, and merged.

Thanks,

> +		return ERR_PTR(-EINVAL);
> +
>  	if (hdr->a_version != cpu_to_le32(F2FS_ACL_VERSION))
>  		return ERR_PTR(-EINVAL);
>  
> -- 
> 2.17.1

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
