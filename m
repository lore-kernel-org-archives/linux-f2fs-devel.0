From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [RFC PATCH v5 2/3] f2fs: introduce a new mount
 option test_dummy_encryption
Date: Fri, 16 Mar 2018 16:49:49 +0800
Message-ID: <656a3814-7454-f12a-ad4a-4bd673c17fa3@huawei.com>
References: <20180315105143.133050-1-shengyong1@huawei.com>
 <20180315105143.133050-3-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1ewl4D-0003c7-98
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 16 Mar 2018 08:50:25 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1ewl47-000h2H-HB
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 16 Mar 2018 08:50:25 +0000
In-Reply-To: <20180315105143.133050-3-shengyong1@huawei.com>
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
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org, ebiggers@google.com, tytso@mit.edu
Cc: linux-fscrypt@vger.kernel.org, miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/3/15 18:51, Sheng Yong wrote:
> This patch introduces a new mount option `test_dummy_encryption'
> to allow fscrypt to create a fake fscrypt context. This is used
> by xfstests.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
