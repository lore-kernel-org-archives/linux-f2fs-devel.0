From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] f2fs-tools: change to use #pragma
 pack(push, 1)
Date: Fri, 16 Mar 2018 16:26:25 +0800
Message-ID: <10115f6d-5ba5-7626-6e52-69d5b03e9194@huawei.com>
References: <20180314000839.33075-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1ewkhQ-00083I-3J
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 16 Mar 2018 08:26:52 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1ewkhM-00Em5C-OP
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 16 Mar 2018 08:26:52 +0000
In-Reply-To: <20180314000839.33075-1-jaegeuk@kernel.org>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: Hyojun Kim <hyojun@google.com>

On 2018/3/14 8:08, Jaegeuk Kim wrote:
> From: Hyojun Kim <hyojun@google.com>
> 
> It was reported that #pragma pack(1) could create unwanted
> influences. pack(push, 1) and pack(pop) are used instead.
> 
> Signed-off-by: Hyojun Kim <hyojun@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
