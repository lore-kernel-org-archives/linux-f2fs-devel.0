From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix an infinite loop when flush nodes
 in cp
Date: Thu, 17 Nov 2016 14:43:44 +0800
Message-ID: <908f79ce-39b6-c7fb-b698-76b08d276423@huawei.com>
References: <20161116092624.17893-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1c7GQf-0000uE-Pf
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Nov 2016 06:44:13 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c7GQd-0002qU-Mu
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Nov 2016 06:44:13 +0000
In-Reply-To: <20161116092624.17893-1-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
Cc: heyunlei@huwei.com

On 2016/11/16 17:26, Yunlei He wrote:
> Thread A			Thread B
> 
> - write_checkpoint
>  - block_operations
>    -blk_start_plug
>     -sync_node_pages		- f2fs_do_sync_file
> 				 - fsync_node_pages
> 				  - f2fs_wait_on_page_writeback
> 
> Thread A wait for global F2FS_DIRTY_NODES decreased to zero,
> it start a plug list, some requests have been added to this list.
> Thread B lock one dirty node page, and wait this page write back.
> But this page has been in plug list of thread A with PG_writeback flag.
> Thread A keep on running and its plug list has no chance to finish,
> so it seems a deadlock between cp and fsync path.
> 
> This patch add a wait on page write back before set node page dirty
> to avoid this problem.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> Signed-off-by: Pengyang Hou <houpengyang@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>


------------------------------------------------------------------------------
