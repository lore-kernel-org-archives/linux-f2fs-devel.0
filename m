From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 0/3] optimize f2fs IPU v2
Date: Mon, 24 Apr 2017 14:55:12 +0800
Message-ID: <9b8155f5-51bf-a5e1-b915-ec9a6d598b25@huawei.com>
References: <20170422092223.118496-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1d2XuQ-0000Vo-5a
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Apr 2017 06:55:42 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187]
	helo=dggrg01-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d2XuO-0006gO-Ud
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Apr 2017 06:55:42 +0000
In-Reply-To: <20170422092223.118496-1-houpengyang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Hou Pengyang <houpengyang@huawei.com>, jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

The patchset looks good to me.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

On 2017/4/22 17:22, Hou Pengyang wrote:
> For IPU, there is no need to read dnode, these three patches are to fix this
> issue.
> 
> patch 1): Reconstruct code in do_write_data_page, code logic stays unchanged,
> patch 2): Under high-probability IPU scenario, we check extent_tree first
> patch 3): Unlock dnode before IPU
> 
> v1->v2:
> 1) fix 
> 		if(f2fs_encrypt_page())
> 			XXX
> 	to 
> 		err = f2fs_encrypt_page() 
> 		if (err)
> 			XXX
> 
> 	otherwise do_write_data_page would return a wrong return value.
> 		
> 2) extract need_in_place_block(fio, page) for IPU checking.
> 
> Hou Pengyang (3):
>   f2fs: reconstruct code to write a data page
>   f2fs: lookup extent cache first under IPU scenario
>   f2fs: unlock dnode before IPU
> 
>  fs/f2fs/data.c | 109 ++++++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 84 insertions(+), 25 deletions(-)
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
