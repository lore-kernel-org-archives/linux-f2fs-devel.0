From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] dump.f2fs: fix a wrong report for dump an
 {d, id, did}node
Date: Thu, 8 Mar 2018 11:45:27 +0800
Message-ID: <e47ab27c-b716-9f6d-9c6c-c14123fa623a@huawei.com>
References: <1520395194-20843-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1etmV1-001ZYe-Fm
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 08 Mar 2018 03:45:47 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1etmUx-003MrS-Pd
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 08 Mar 2018 03:45:47 +0000
In-Reply-To: <1520395194-20843-1-git-send-email-heyunlei@huawei.com>
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
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/3/7 11:59, Yunlei He wrote:
> fix a wrong report for dump an {d,id,did}node like this:
> 
> [print_node_info: 283] Node ID [0x6820:26656] is direct node or indirect node.
> [0]                     [0x 16b6684 : 23815812]
> [1]                     [0x 16b6685 : 23815813]
> [2]                     [0x 16b6686 : 23815814]
> [3]                     [0x 16b6687 : 23815815]
> [4]                     [0x 16b6688 : 23815816]
> [5]                     [0x 16b6689 : 23815817]
> [6]                     [0x 16b668a : 23815818]
> [7]                     [0x 16b668b : 23815819]
> [8]                     [0x 16b668c : 23815820]
> [9]                     [0x 16b668d : 23815821]
> [10]                    [0x 16b668e : 23815822]
> Invalid (i)node block
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
