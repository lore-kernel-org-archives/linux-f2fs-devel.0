From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] fsck.f2fs: check extent of inline
 data/dentry inode
Date: Mon, 9 Jul 2018 09:41:16 +0800
Message-ID: <976695d2-7e99-20da-b61b-ed18697e4233@huawei.com>
References: <20180703101005.200396-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fcLBX-0007IY-Hv
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Jul 2018 01:41:51 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fcLBV-00GPwV-9W
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Jul 2018 01:41:51 +0000
In-Reply-To: <20180703101005.200396-1-shengyong1@huawei.com>
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
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org, wen.xu@gatech.edu
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/7/3 18:10, Sheng Yong wrote:
> Check extent for inline data/dentry inode. If an inode contains inline
> data/dentry, it should have no extent.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200175
> Reported-by: Wen Xu <wen.xu@gatech.edu>
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
