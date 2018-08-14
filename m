From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [RFC PATCH v2 3/4] f2fs-tools: unify the writeback
 of superblock
Date: Tue, 14 Aug 2018 15:43:36 +0800
Message-ID: <6f8338ee-007b-1635-0fde-82cf1d011dc6@huawei.com>
References: <20180814065616.33278-1-zhengjunling@huawei.com>
 <20180814065616.33278-3-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fpTzd-0000Ql-DC
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Aug 2018 07:43:53 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fpTzb-00H5gz-RY
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Aug 2018 07:43:53 +0000
In-Reply-To: <20180814065616.33278-3-zhengjunling@huawei.com>
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
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/8/14 14:56, Junling Zheng wrote:
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
