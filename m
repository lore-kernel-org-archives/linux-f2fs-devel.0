From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: read ahead nat blocks && flush more
 continuous nat io
Date: Wed, 31 Jan 2018 18:45:39 +0800
Message-ID: <13b1c615-e250-74bf-9cea-5e3a06aef926@huawei.com>
References: <1517383938-21055-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1egptz-0004yA-Qa
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 31 Jan 2018 10:46:03 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1egptt-0004oh-GX
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 31 Jan 2018 10:46:03 +0000
In-Reply-To: <1517383938-21055-1-git-send-email-heyunlei@huawei.com>
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
Cc: Wei Fang <fangwei1@huawei.com>

Hi Yunlei, Wei Fang,

On 2018/1/31 15:32, Yunlei He wrote:
> This patch including two changes:
> 1. We introduce nat journal to cache nat blocks which has less
> dirty nat entries, nat entry sets are ranked by dirty nat entry
> count if the count less than NAT_JOURNAL_ENTRIES. This method
> will break the continuity of nat blocks write back order, and
> this patch make a change of that prior to flush continuous nat
> blocks.

If we start to flush NAT blocks which is contiguous, but if there is very few
entries are dirty, we are facing bigger WA which may cause worse effect than
random 4K NAT block writes.

Or do you have numbers?

> 
> 2. Add read ahead nat blocks in case of a lot of serial synchronized
> read as below:

Looks LBAs are discrete? Can you check below comment?

> +	list_for_each_entry_safe(set, tmp, &sets, set_list) {
> +		block_t blk_addr;
> +
> +		nats_to_journal += set->entry_cnt;
> +
> +		if (nats_to_journal > NAT_JOURNAL_ENTRIES ||
> +						set->continue_io) {
> +			blk_addr = current_nat_addr(sbi,
> +					set->set * NAT_ENTRY_PER_BLOCK);

Actually, ra_meta_pages only accept nat block offset instead of blkaddr.

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
