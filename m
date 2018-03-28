From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] fsck.f2fs: simplify fsck_chk_quota_node in
 PREEN_MODE_1
Date: Wed, 28 Mar 2018 11:02:24 +0800
Message-ID: <2f9955d6-a83a-6729-45ea-802c9489f3c0@huawei.com>
References: <20180326124737.231210-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f11MI-00083L-0k
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Mar 2018 03:02:42 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f11MG-00ApFa-FS
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Mar 2018 03:02:41 +0000
In-Reply-To: <20180326124737.231210-1-zhengjunling@huawei.com>
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
To: Junling Zheng <zhengjunling@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/3/26 20:47, Junling Zheng wrote:
> Do not do fsck_chk_node_blk to simplify fsck_chk_quota_node in
> PREEN_MODE_1, as well as fsck_chk_orphan_node.
> 
> Signed-off-by: Junling Zheng <zhengjunling@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
