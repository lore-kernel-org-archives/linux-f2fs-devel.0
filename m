From: Hou Pengyang <houpengyang@huawei.com>
Subject: Re: [PATCH v2 0/5] f2fs: improve performance of NAT/SIT
 flushing during cp
Date: Fri, 9 Jun 2017 21:48:27 +0800
Message-ID: <593AA72B.2080103@huawei.com>
References: <20170520122435.17574-1-houpengyang@huawei.com>
	<20170524041425.GB30325@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1dJKHP-0003GE-5q
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 09 Jun 2017 13:48:47 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dJKHN-0000fj-M7
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 09 Jun 2017 13:48:47 +0000
In-Reply-To: <20170524041425.GB30325@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/5/24 12:14, Jaegeuk Kim wrote:
> Hi Pengyang,
>
> Could you please shed a light on some performance gains by this?

Hi, Jaegeuk,
Sorry for replying so late.

I've tested the duration of nat-radix-tree traveling and list-sort of
nat-entry, it is about *100us* averagely during fragmentation(arm64 mobile).

100us seems nobody for CP, but I still think it make senses for scenario
where massive dirty nat_entries exist in system(corner case, hard to 
produce).

Thanks,
>
> Thanks,
>
> On 05/20, Hou Pengyang wrote:
>> This patches are to designed to optimize NAT/SIT flushing procedure:
>>
>> patch 1) -- patch 3):
>>
>> during flush_nat_entries, we do:
>> 1) gang_lookup a radix tree, find all the dirty nat_entry_set;
>> 2) sort nat_entry_set by nat_entry_set->entry_cnt, in order to
>>      write to journal as much as possible to avoid unnessary IO.
>>
>> This patch optimize the look_up & sort algorithm by introducing an array:
>>
>>      f2fs_nm_info->dirty_set[NAT_ENTRY_PER_BLOCK+1];
>>      (struct list_head dirty_set[NAT_ENTRY_PER_BLOCK + 1])
>>
>> dirty_set[1] links all nat_entry_set whose entry_cnt is 1
>> dirty_set[2] links all nat_entry_set whose entry_cnt is 2
>> ......
>> dirty_set[N] links all nat_entry_set whose entry_cnt is N
>>
>> as one NAT block has NAT_ENTRY_PER_BLOCK entries at MOST, so there should NOT
>> be one nat_entry_set whose entry_cnt is larger than NAT_ENTRY_PER_BLOCK.
>>
>> So it is enough for f2fs_nm_info->dirty_set to link all nat_entry_sets in system.
>>
>> Update:
>>      we update nat_entry_set in real-time, e.g originally nat_entry_set->entry_cnt is
>> 1, and licked by dirty_set[1]; then call __set_nat_cache_dirty to increase nat_entry's
>> entry_cnt, we move this nat_entry_set ot dirty_set[2]'s tail, no need to compare.
>>
>> Flush:
>>      when flush dirty nat_entry_set, we just flush nat_entry_set from
>> f2fs_nm_info->dirty_set[0] to f2fs_nm_info->dirty_set[NAT_ENTRY_PER_BLOCK], where
>> gang_lookup and sort can be avoid.
>>
>> footprint of this algorithm:  sizeof(struct list_head)*NAT_ENTRY_PER_BLOCK
>>                                = 8*455 = 3.6k bytes
>>
>> Same for SIT.
>>
>> In patch 5), we use array to manage sit_entry_sets instead of list, which
>> can avoid list travel, and there is no need to alloc/free lab memory.
>> It is low footrpint consuming.
>>
>> Hou Pengyang (5):
>>    f2fs: use bucket sort to avoid tree lookup and list sort when nat flushing
>>    f2fs: reconstruct sit flushing code
>>    f2fs: use bucket sort to avoid list sort when flush sit entries
>>    f2fs: avoid unnecessary to_journal checking
>>    f2fs: use an array to record sit_entry_set info to make sort fast
>>
>>   fs/f2fs/f2fs.h    |   5 +-
>>   fs/f2fs/node.c    |  79 ++++++++-----------
>>   fs/f2fs/segment.c | 227 ++++++++++++++++++++++++++----------------------------
>>   fs/f2fs/segment.h |   2 +-
>>   4 files changed, 147 insertions(+), 166 deletions(-)
>>
>> --
>> 2.10.1
>>
>>
>> ------------------------------------------------------------------------------
>> Check out the vibrant tech community on one of the world's most
>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>
> .
>



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
