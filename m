From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 4/4] f2fs: unlock dnode before IPU
Date: Tue, 25 Apr 2017 14:27:46 -0700
Message-ID: <20170425212746.GB1568@jaegeuk.local>
References: <20170425124515.160446-1-houpengyang@huawei.com>
	<20170425124515.160446-5-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1d3805-0005mT-5r
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Apr 2017 21:27:57 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d3802-0006OP-KJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Apr 2017 21:27:57 +0000
Content-Disposition: inline
In-Reply-To: <20170425124515.160446-5-houpengyang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Hou Pengyang <houpengyang@huawei.com>
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 04/25, Hou Pengyang wrote:
> Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
> ---
>  fs/f2fs/data.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 9bf9c7d..1d7157b 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1381,9 +1381,11 @@ int do_write_data_page(struct f2fs_io_info *fio)
>  	 */
>  	if (need_inplace_update(fio)) {
>  		f2fs_bug_on(fio->sbi, fio->cp_rwsem_locked);
> +		f2fs_put_dnode(&dn);
>  		err = rewrite_data_page(fio);
>  		trace_f2fs_do_write_data_page(fio->page, IPU);
>  		set_inode_flag(inode, FI_UPDATE_WRITE);
> +		return err;
>  	} else {

We don't need else phrase here.
I changed and merged it.

Thanks,

>  		if (!fio->cp_rwsem_locked)
>  			f2fs_lock_op(fio->sbi);
> -- 
> 2.10.1
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
