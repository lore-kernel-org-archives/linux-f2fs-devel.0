From: Chao Yu <chao@kernel.org>
Subject: Re: [RFC PATCH v3 3/5] f2fs-tools: unify the writeback
 of superblock
Date: Thu, 30 Aug 2018 23:43:25 +0800
Message-ID: <de17b694-fd06-bdf5-a98b-c93187786ebe@kernel.org>
References: <20180830033733.236460-1-zhengjunling@huawei.com>
 <20180830033733.236460-3-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1fvP6k-0001xO-Q1
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 15:43:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fvP6f-003RCa-Eo
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 15:43:42 +0000
In-Reply-To: <20180830033733.236460-3-zhengjunling@huawei.com>
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
To: Junling Zheng <zhengjunling@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/8/30 11:37, Junling Zheng wrote:
> Introduce __write_superblock() to support updating specified one
> superblock or both, thus we can wrapper it in update_superblock() and
> f2fs_write_super_block to unify all places where sb needs to be updated.
> 
> Signed-off-by: Junling Zheng <zhengjunling@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
