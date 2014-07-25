From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 2/2] f2fs: fix to put root inode in error
 path of fill_super
Date: Fri, 25 Jul 2014 13:58:55 +0800
Message-ID: <53D1F21F.1010507@cn.fujitsu.com>
References: <003b01cfa7c4$b7408040$25c180c0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1XAYiv-0001o3-S8
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Jul 2014 06:11:21 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XAYiu-0006FG-0e for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Jul 2014 06:11:21 +0000
In-Reply-To: <003b01cfa7c4$b7408040$25c180c0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 07/25/2014 12:55 PM, Chao Yu wrote:

> We should put root inode correctly in error path of fill_super, otherwise we
> may encounter a leak case of inode resource.

Good catch, and it also fixed the incorrect 'goto'.

> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>

Reviewed-by: Gu Zheng <guz.fnst@cn.fujitsu.com>

> ---
>  fs/f2fs/super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 870fe19..34649aa 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1033,8 +1033,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  		goto free_node_inode;
>  	}
>  	if (!S_ISDIR(root->i_mode) || !root->i_blocks || !root->i_size) {
> +		iput(root);
>  		err = -EINVAL;
> -		goto free_root_inode;
> +		goto free_node_inode;
>  	}
>  
>  	sb->s_root = d_make_root(root); /* allocate root dentry */



------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
