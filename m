From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2] f2fs: relax migratepage for atomic
 written page
Date: Fri, 7 Jul 2017 07:57:29 +0800
Message-ID: <4f92014b-5265-2c60-51a6-f80f34dd1418@kernel.org>
References: <20170703230820.63929-1-jaegeuk@kernel.org>
	<20170706214926.GB395@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1dTGfQ-00038I-FP
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 06 Jul 2017 23:58:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dTGfP-0004aq-6o
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 06 Jul 2017 23:58:40 +0000
In-Reply-To: <20170706214926.GB395@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/7/7 5:49, Jaegeuk Kim wrote:
> In order to avoid lock contention for atomic written pages, we'd better give
> EBUSY in f2fs_migrate_page when mode is asynchronous. We expect it will be
> released soon as transaction commits.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> ---
> 
> Change log from v1:
>  - return -EBUSY when mode is MIGRATE_ASYNC or MIGRATE_SYNC_LIGHT
> 
>  fs/f2fs/data.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 85ac3a63cce6..74c31cb203e2 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2206,8 +2206,12 @@ int f2fs_migrate_page(struct address_space *mapping,
>  	BUG_ON(PageWriteback(page));
>  
>  	/* migrating an atomic written page is safe with the inmem_lock hold */
> -	if (atomic_written && !mutex_trylock(&fi->inmem_lock))
> -		return -EAGAIN;
> +	if (atomic_written) {
> +		if (mode != MIGRATE_SYNC)
> +			return -EBUSY;
> +		if (!mutex_trylock(&fi->inmem_lock))
> +			return -EAGAIN;
> +	}
>  
>  	/*
>  	 * A reference is expected if PagePrivate set when move mapping,
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
