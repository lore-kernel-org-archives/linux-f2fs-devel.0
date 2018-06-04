From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] resize.f2fs: skip cursegs when finding next
 free block
Date: Mon, 4 Jun 2018 18:06:56 +0800
Message-ID: <3e7a35a8-0250-611f-f1b5-637eeed7d435@huawei.com>
References: <20180604081436.146277-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fPmOs-0000b8-0H
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Jun 2018 10:07:42 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fPmOq-00HYMv-HH
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Jun 2018 10:07:41 +0000
In-Reply-To: <20180604081436.146277-1-shengyong1@huawei.com>
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
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/6/4 16:14, Sheng Yong wrote:
> resize.f2fs (f2fs_defragment) tries to migrate blocks to new positions.
> However, if a curseg is selected, and f2fs_defragment is broken by any
> error, curseg->next_blkoff is left not updated.
> 
> To avoid this, we skip cursegs when finding next free block.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
