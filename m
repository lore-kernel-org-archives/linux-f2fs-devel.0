From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2] f2fs: handle newly created page when
 revoking inmem pages
Date: Wed, 10 Jan 2018 23:08:51 +0800
Message-ID: <8a0db638-ebe0-c7bd-5019-c00c87e4964e@kernel.org>
References: <CGME20180110074852epcas2p43c4891c689db01ff6fc46291a4dcfb75@epcas2p4.samsung.com>
 <1515570550-4497-1-git-send-email-daeho.jeong@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <chao@kernel.org>) id 1eZHzt-0000mn-J3
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Jan 2018 15:08:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eZHzs-0002OM-Ti
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Jan 2018 15:08:57 +0000
In-Reply-To: <1515570550-4497-1-git-send-email-daeho.jeong@samsung.com>
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
To: Daeho Jeong <daeho.jeong@samsung.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/1/10 15:49, Daeho Jeong wrote:
> When committing inmem pages is successful, we revoke already committed
> blocks in __revoke_inmem_pages() and finally replace the committed
> ones with the old blocks using f2fs_replace_block(). However, if
> the committed block was newly created one, the address of the old
> block is NEW_ADDR and __f2fs_replace_block() cannot handle NEW_ADDR
> as new_blkaddr properly and a kernel panic occurrs.
> 
> Signed-off-by: Daeho Jeong <daeho.jeong@samsung.com>
> Tested-by: Shu Tan <shu.tan@samsung.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
