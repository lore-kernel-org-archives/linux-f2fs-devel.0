From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/4] mkfs.f2fs: make sure clean all reset
 dnodes
Date: Thu, 23 Feb 2017 17:25:42 +0800
Message-ID: <0bc48733-da21-5cf6-4135-5ed910223f54@huawei.com>
References: <20170214020520.18091-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cgpeu-0003xT-N5
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 09:25:56 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cgpet-0004JR-GX
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 09:25:56 +0000
In-Reply-To: <20170214020520.18091-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On 2017/2/14 10:05, Jaegeuk Kim wrote:
> From: Kinglong Mee <kinglongmee@gmail.com>
> 
> memset(raw_node, 0, F2FS_BLKSIZE) sets the next_blkaddr to zero,
> so that, only one reset dnode is cleaned always.
> 
> Fixes: ad042d9194f5 "mkfs.f2fs: reset dnode with zeros",
> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
