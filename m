From: Chao Yu <chao@kernel.org>
Subject: Re: [RFC PATCH 1/2] f2fs: clean up f2fs_sb_has_xxx
 functions
Date: Thu, 8 Feb 2018 21:21:12 +0800
Message-ID: <9c79a87f-dcdc-a18e-4bfc-b2fabe536ada@kernel.org>
References: <20180206043118.134137-1-shengyong1@huawei.com>
 <20180206043118.134137-2-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <chao@kernel.org>) id 1ejm8u-0005fi-BJ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 08 Feb 2018 13:21:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ejm8r-0002MO-VQ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 08 Feb 2018 13:21:36 +0000
In-Reply-To: <20180206043118.134137-2-shengyong1@huawei.com>
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
Cc: miaoxie@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/2/6 12:31, Sheng Yong wrote:
> This patch introduces F2FS_FEATURE_FUNCS to clean up the definitions of
> different f2fs_sb_has_xxx functions.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
