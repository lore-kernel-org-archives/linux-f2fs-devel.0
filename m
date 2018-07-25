From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 2/3] f2fs: quota: decrease the lock
 granularity of statfs_project
Date: Wed, 25 Jul 2018 23:41:39 +0800
Message-ID: <58d96b9e-3714-5838-d577-81d1c43bfe72@kernel.org>
References: <20180724121754.19920-1-shengyong1@huawei.com>
 <20180724121754.19920-2-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1fiLvG-0003O9-Bj
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Jul 2018 15:41:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fiLvG-008HGn-7d
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Jul 2018 15:41:54 +0000
In-Reply-To: <20180724121754.19920-2-shengyong1@huawei.com>
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
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/7/24 20:17, Sheng Yong wrote:
> According to fs/quota/dquot.c, `dq_data_lock' protects mem_dqinfo
> structures and modifications of dquot pointers in the inode, and
> `dquot->dq_dqb_lock' protects data from dq_dqb.
> 
> We should use dquot->dq_dqb_lock in statfs_project instead of
> dq_dat_lock.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
