From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: fix a bug when using namehash to
 locate dentry bucket
Date: Thu, 25 Aug 2016 22:13:31 +0800
Message-ID: <b77fe368-8e6e-3130-1078-b2eb3e2492e4@kernel.org>
References: <1472128929-86774-1-git-send-email-liushuoran@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bcvPh-0001lU-Dk
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Aug 2016 14:13:49 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bcvPf-0006HO-BL
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Aug 2016 14:13:49 +0000
In-Reply-To: <1472128929-86774-1-git-send-email-liushuoran@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Shuoran Liu <liushuoran@huawei.com>, jaegeuk@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2016/8/25 20:42, Shuoran Liu wrote:
> In the following scenario,
> 
> 1) we don't have the key and doing a lookup for encrypted file,
> 2) and the encrypted filename is big name
> 
> we should use fname->hash as name hash value instead of what is
> calculated by fname->disk_name. Because in such case,
> fname->disk_name is empty.

Your signiture is missing here.

Anyway that's a good catch!

Acked-by: Chao Yu <yuchao0@huawei.com>

> ---
>  fs/f2fs/dir.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 9054aea..b3e6f7f 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -172,7 +172,10 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
>  	int max_slots;
>  	f2fs_hash_t namehash;
>  
> -	namehash = f2fs_dentry_hash(&name);
> +	if(fname->hash)
> +		namehash = cpu_to_le32(fname->hash);
> +	else
> +		namehash = f2fs_dentry_hash(&name);
>  
>  	nbucket = dir_buckets(level, F2FS_I(dir)->i_dir_level);
>  	nblock = bucket_blocks(level);
> 

------------------------------------------------------------------------------
