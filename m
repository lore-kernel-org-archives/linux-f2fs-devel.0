From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/3] f2fs: init local extent_info to avoid
 stale stack info in tp
Date: Fri, 24 Feb 2017 19:09:49 +0800
Message-ID: <5f0e441d-af45-5cbd-fb04-da9b198c384e@huawei.com>
References: <20170223091807.36175-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1chDlI-0001Rb-F6
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Feb 2017 11:10:08 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1chDlF-00082g-L5
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Feb 2017 11:10:08 +0000
In-Reply-To: <20170223091807.36175-1-houpengyang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Hou Pengyang <houpengyang@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/2/23 17:18, Hou Pengyang wrote:
> To avoid such stale(fops, blk, len) info in f2fs_lookup_extent_tree_end tp
> 
> dio-23095 [005] ...1 17878.856859: f2fs_lookup_extent_tree_end: 
> 			dev = (259,30), ino = 856, pgofs = 0, 
> 			ext_info(fofs: 3441207040, blk: 4294967232, len: 3481143808)
> 
> Signed-off-by: Hou Pengyang <houpengyang@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
