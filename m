From: Andrey Tsyvarev <tsyvarev@ispras.ru>
Subject: Re: f2fs: Possible use-after-free when umount filesystem
Date: Tue, 22 Jul 2014 14:04:18 +0400
Message-ID: <53CE3722.60307@ispras.ru>
References: <52F320FC.50803@ispras.ru> <534BC29B.3020408@ispras.ru>
	<53CCF1EC.30008@ispras.ru> <53CDC9AF.2050605@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tsyvarev@ispras.ru>) id 1X9Wv9-0003S4-Uu
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Jul 2014 10:03:43 +0000
Received: from smtp.ispras.ru ([83.149.199.79])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X9Wv8-0000uv-55 for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Jul 2014 10:03:43 +0000
In-Reply-To: <53CDC9AF.2050605@cn.fujitsu.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-f2fs-devel@lists.sourceforge.net

Hi Gu,

>> Investigation shows, that f2fs_evict_inode, when called for 'meta_inode', uses invalidate_mapping_pages() for 'node_inode'.
>> But 'node_inode' is deleted before 'meta_inode' in f2fs_put_super via iput().
>>
>> It seems that in common usage scenario this use-after-free is benign, because 'node_inode' remains partially valid data even after kmem_cache_free().
>> But things may change if, while 'meta_inode' is evicted in one f2fs filesystem, another (mounted) f2fs filesystem requests inode from cache, and formely
>> 'node_inode' of the first filesystem is returned.
> The analysis seems reasonable. Have you tried to swap the reclaim order of node_inde
> and meta_inode?
>
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 870fe19..e114418 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -430,8 +430,8 @@ static void f2fs_put_super(struct super_block *sb)
>          if (sbi->s_dirty && get_pages(sbi, F2FS_DIRTY_NODES))
>                  write_checkpoint(sbi, true);
>   
> -       iput(sbi->node_inode);
>          iput(sbi->meta_inode);
> +       iput(sbi->node_inode);
>   
>          /* destroy f2fs internal modules */
>          destroy_node_manager(sbi);
>
> Thanks,
> Gu

With reclaim order of node_inode and meta_inode swapped, use-after-free 
error disappears.

But shouldn't initialization order of these inodes be swapped too?
As meta_inode uses node_inode, it seems logical that it should be 
initialized after it.

-- 
Best regards,

Andrey Tsyvarev
Linux Verification Center, ISPRAS
web:http://linuxtesting.org


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
