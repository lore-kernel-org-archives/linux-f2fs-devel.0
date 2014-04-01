From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 2/2] f2fs: use list_for_each_entry{_safe} for
 simplyfying code
Date: Tue, 01 Apr 2014 10:15:32 +0800
Message-ID: <533A2144.8040607@cn.fujitsu.com>
References: <000001cf4aff$baaf99e0$300ecda0$@samsung.com>
	<53393E47.5070600@cn.fujitsu.com>
	<000001cf4d4c$374e5f10$a5eb1d30$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1WUoNr-0000qY-GA
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Apr 2014 02:25:03 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WUoNp-00008D-HQ for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Apr 2014 02:25:03 +0000
In-Reply-To: <000001cf4d4c$374e5f10$a5eb1d30$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Yu,
On 04/01/2014 09:45 AM, Chao Yu wrote:

> Hi Gu,
> 
>> -----Original Message-----
>> From: Gu Zheng [mailto:guz.fnst@cn.fujitsu.com]
>> Sent: Monday, March 31, 2014 6:07 PM
>> To: Chao Yu
>> Cc: ???; linux-f2fs-devel@lists.sourceforge.net; linux-fsdevel@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: use list_for_each_entry{_safe} for simplyfying code
>>
>> Hi Yu,
>> On 03/29/2014 11:33 AM, Chao Yu wrote:
>>
>>> This patch use list_for_each_entry{_safe} instead of list_for_each{_safe} for
>>> simplfying code.
>>>
>>> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
>>> ---
>>>  fs/f2fs/checkpoint.c |   37 ++++++++++++++-----------------------
>>>  fs/f2fs/node.c       |   16 ++++++----------
>>>  fs/f2fs/recovery.c   |    6 ++----
>>>  fs/f2fs/segment.c    |    6 ++----
>>>  4 files changed, 24 insertions(+), 41 deletions(-)
>>>
>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>> index d877f46..4aa521a 100644
>>> --- a/fs/f2fs/checkpoint.c
>>> +++ b/fs/f2fs/checkpoint.c
>>> @@ -308,16 +308,15 @@ void release_orphan_inode(struct f2fs_sb_info *sbi)
>>>
>>>  void add_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
>>>  {
>>> -	struct list_head *head, *this;
>>> -	struct orphan_inode_entry *new = NULL, *orphan = NULL;
>>> +	struct list_head *head;
>>> +	struct orphan_inode_entry *new, *orphan;
>>>
>>>  	new = f2fs_kmem_cache_alloc(orphan_entry_slab, GFP_ATOMIC);
>>>  	new->ino = ino;
>>>
>>>  	spin_lock(&sbi->orphan_inode_lock);
>>>  	head = &sbi->orphan_inode_list;
>>> -	list_for_each(this, head) {
>>> -		orphan = list_entry(this, struct orphan_inode_entry, list);
>>> +	list_for_each_entry(orphan, head, list) {
>>>  		if (orphan->ino == ino) {
>>>  			spin_unlock(&sbi->orphan_inode_lock);
>>>  			kmem_cache_free(orphan_entry_slab, new);
>>> @@ -326,14 +325,10 @@ void add_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
>>>
>>>  		if (orphan->ino > ino)
>>>  			break;
>>> -		orphan = NULL;
>>>  	}
>>>
>>> -	/* add new_oentry into list which is sorted by inode number */
>>> -	if (orphan)
>>> -		list_add(&new->list, this->prev);
>>> -	else
>>> -		list_add_tail(&new->list, head);
>>> +	/* add new orphan entry into list which is sorted by inode number */
>>> +	list_add_tail(&new->list, &orphan->list);
>>
>> It seems that the logic can not be changed here, otherwise the orphan list will not be in order
>> if
>> the new ino is bigger than all the in-list ones.
>> E.g.
>> ino:5
>> 1-->2-->3-->4
>> ==>
>> 1-->2-->3-->5-->4
> 
> As I checked, if new ino is bigger than all, it will break from list_for_each_entry because
> &orphan->list is pointing to head. So list_add_tail can add the new entry before head to make
> this list in order.

Oh...Yes, you are right.
Thanks for correcting me.

Regards,
Gu

> 
> Thanks.
> 
>>
>> Regards,
>> Gu
>>
> 
> [snip]
> 
> 



------------------------------------------------------------------------------
