From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs-tools: do not count free_segs in
 flush_sit_entries
Date: Tue, 19 Jun 2018 20:12:06 +0800
Message-ID: <3f99ee39-c9d6-286a-f075-e566614aa336@huawei.com>
References: <20180613015150.197854-2-shengyong1@huawei.com>
 <20180613101359.1184-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fVFVJ-0000RW-3P
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 19 Jun 2018 12:12:57 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fVFVH-002miu-N2
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 19 Jun 2018 12:12:57 +0000
In-Reply-To: <20180613101359.1184-1-shengyong1@huawei.com>
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
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/6/13 18:13, Sheng Yong wrote:
> flush_sit_entries() is always called before write_checkpoint(). Since
> free_segs is counted in write_checkpoint, there is no need to do that
> in flush_sit_entries. Besides, the value of free_segs may be not
> correct if we skip uptodate seg_entries.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
