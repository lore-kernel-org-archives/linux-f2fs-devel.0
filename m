From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix a mount fail for wrong
	next_scan_nid
Date: Thu, 4 May 2017 11:05:08 +0800
Message-ID: <f5b22c07-cb01-5aea-782f-c40cbe907f6c@huawei.com>
References: <20170426075652.4249-1-heyunlei@huawei.com>
	<7822ea80-3064-0b8e-e3f0-ce5e16217c05@huawei.com>
	<20170503170424.GB93619@jaegeuk.local>
	<edf88000-54d0-3c56-8702-fd284d76bc6a@huawei.com>
	<20170504022420.GA2246@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1d675Q-0005eY-KO
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 May 2017 03:05:48 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d675M-0003YW-3w
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 May 2017 03:05:48 +0000
In-Reply-To: <20170504022420.GA2246@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/5/4 10:24, Jaegeuk Kim wrote:
> On 05/04, Chao Yu wrote:
>> On 2017/5/4 1:04, Jaegeuk Kim wrote:
>>> On 05/03, Chao Yu wrote:
>>>> Hi all,
>>>>
>>>> On 2017/4/26 15:56, Yunlei He wrote:
>>>>> -write_checkpoint
>>>>>    -do_checkpoint
>>>>>       -next_free_nid    <--- something wrong with next free nid
>>>>
>>>> Since we have figured out how next_scan_nid can be changed to a wrong value, so
>>>> how about add a bug_on here to detect potential issue for further fixing?
>>>
>>> I'll drop this patch for next merge window.
>>> So, what was the root cause of this?
>>
>> I don't know yet, :( maybe it was caused by bit-transition of cpu or memory.
> 
> Hmm, then this patch would be just fine, as I think. Even if nm_i->next_scan_nid
> was corrupted, we can set it back as normal.

IMO, for product, it's better to set it back, as we expect filesystem module has
fault tolerance itself, for upstream, it would be good to keep bug_on to  detect
further bug. Anyway, not a big deal. ;)

Thanks,

> 
> Thanks,
> 
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>> -f2fs_fill_super
>>>>>    -build_node_manager
>>>>>       -build_free_nids
>>>>>           -get_current_nat_page
>>>>>              -__get_meta_page   <--- attempt to access beyond end of device
>>>>>
>>>>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>>>>> ---
>>>>>  fs/f2fs/node.c | 3 +++
>>>>>  1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>>>>> index b99e318..98351a4 100644
>>>>> --- a/fs/f2fs/node.c
>>>>> +++ b/fs/f2fs/node.c
>>>>> @@ -1955,6 +1955,9 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
>>>>>  	int i = 0;
>>>>>  	nid_t nid = nm_i->next_scan_nid;
>>>>>  
>>>>> +	if (unlikely(nid >= nm_i->max_nid))
>>>>> +		nid = 0;
>>>>> +
>>>>>  	/* Enough entries */
>>>>>  	if (nm_i->nid_cnt[FREE_NID_LIST] >= NAT_ENTRY_PER_BLOCK)
>>>>>  		return;
>>>>>
>>>
>>> .
>>>
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
