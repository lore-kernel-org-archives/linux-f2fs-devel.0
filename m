From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 1/5] f2fs: relax node version check for victim
 data in gc
Date: Mon, 27 Mar 2017 16:18:26 +0800
Message-ID: <f5823a24-4ea5-4e21-52eb-14c8d3761db5@huawei.com>
References: <20170325075933.21072-1-jaegeuk@kernel.org>
 <2b848126-cf2c-2145-083a-ae5ca77356b6@huawei.com>
 <20170325212742.GA24857@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20170325212742.GA24857@jaegeuk.local>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/3/26 5:27, Jaegeuk Kim wrote:
> On 03/25, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2017/3/25 15:59, Jaegeuk Kim wrote:
>>> - has_not_enough_free_secs
>>> node_secs: 0  dent_secs: 0  freed:0  free_segments:103  reserved:104
>>>
>>>           - f2fs_gc
>>>              - get_victim_by_default
>>> alloc_mode 0, gc_mode 1, max_search 2672, offset 4654, ofs_unit 1
>>>
>>>                 - do_garbage_collect
>>> start_segno 3976, end_segno 3977   type 0
>>>
>>>                   - is_alive
>>> nid 22797, blkaddr 2131882, ofs_in_node 0, version 0x8/0x0
>>>
>>>                    - gc_data_segment 766, segno 3976, block 512/426 not alive
>>>
>>> So, this patch fixes subtle corrupted case where node version does not match
>>> to summary version which results in infinite loop by gc.
>>>
>>> Reported-by: Yunlei He <heyunlei@huawei.com>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/gc.c | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index 939be88a8833..bbeee41aaf73 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -551,8 +551,10 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>>  	get_node_info(sbi, nid, dni);
>>>  
>>>  	if (sum->version != dni->version) {
>>
>> If the node was been truncated, we will increase its version number, since it
>> was been truncated, so it will never be writebacked to storage, so the version
>> in summary will not be updated.
> 
> That's covered by node page lock, so we shouldn't be reached out to this point.
> Let's think more about this.

Yes, agreed. ;)

Thanks,

> 
> Thanks,
> 
>> So this case can happen, shouldn't we just set SBI_NEED_FSCK for the case:
>> sum->version != dni->version - 1
>>
>> Thanks,
>>
>>> -		f2fs_put_page(node_page, 1);
>>> -		return false;
>>> +		f2fs_msg(sbi->sb, KERN_WARNING,
>>> +				"%s: valid data with mismatched node version.",
>>> +				__func__);
>>> +		set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>  	}
>>>  
>>>  	*nofs = ofs_of_node(node_page);
>>>
> 
> .
> 
