From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [RFC PATCH v2 1/2] f2fs: do not set LOST_PINO for
 newly created dir
Date: Mon, 26 Jun 2017 19:16:16 +0800
Message-ID: <391f10aa-72ca-ea69-a66e-df63970099b9@huawei.com>
References: <20170626024136.211772-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1dPS18-0004Yi-Mp
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Jun 2017 11:17:18 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dPS16-0003OB-E9
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Jun 2017 11:17:18 +0000
In-Reply-To: <20170626024136.211772-1-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/6/26 10:41, Sheng Yong wrote:
> Since directories will be written back with checkpoint and fsync a
> directory will always write CP, there is no need to set LOST_PINO
> after creating a directory.

Needs to cover rename/rename2?

Thanks,

> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> ---
>  fs/f2fs/dir.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 94756f55a97e..37f9c7f55605 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -415,7 +415,8 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
>  	 * We lost i_pino from now on.
>  	 */
>  	if (is_inode_flag_set(inode, FI_INC_LINK)) {
> -		file_lost_pino(inode);
> +		if (!S_ISDIR(inode->i_mode))
> +			file_lost_pino(inode);
>  		/*
>  		 * If link the tmpfile to alias through linkat path,
>  		 * we should remove this inode from orphan list.
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
