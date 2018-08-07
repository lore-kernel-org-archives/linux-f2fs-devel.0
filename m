From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [RFC PATCH 2/3] f2fs-tools: rename CHECKSUM_OFFSET
 to CHKSUM_OFFSET_CP
Date: Tue, 7 Aug 2018 18:07:03 +0800
Message-ID: <9dbef41b-2c9a-6e4f-8df7-df36c6060993@huawei.com>
References: <20180807091718.192688-1-zhengjunling@huawei.com>
 <20180807091718.192688-2-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fmytc-0005wV-8i
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Aug 2018 10:07:20 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fmyta-00CcFm-DW
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Aug 2018 10:07:20 +0000
In-Reply-To: <20180807091718.192688-2-zhengjunling@huawei.com>
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

On 2018/8/7 17:17, Junling Zheng wrote:
> This patch renamed CHECKSUM_OFFSET to CHKSUM_OFFSET_CP.

Hmm... How about CP_CHECKSUM_OFFSET?

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
