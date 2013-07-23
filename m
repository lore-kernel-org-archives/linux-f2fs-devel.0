From: Nikola Pajkovsky <npajkovs@redhat.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: use list_for_each rather than
	list_for_each_safe, in remove_orphan_inode()
Date: Tue, 23 Jul 2013 09:34:18 +0200
Message-ID: <m3ob9trapx.fsf@redhat.com>
References: <51E8F7A6.7030708@cn.fujitsu.com> <m3d2qa7gj6.fsf@redhat.com>
	<51EDD6F9.7070207@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <npajkovs@redhat.com>) id 1V1X7B-0000fm-Av
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Jul 2013 07:34:33 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V1X79-0008Ba-Aq for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Jul 2013 07:34:33 +0000
In-Reply-To: <51EDD6F9.7070207@cn.fujitsu.com> (Gu Zheng's message of "Tue, 23
	Jul 2013 09:06:01 +0800")
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, f2fs <linux-f2fs-devel@lists.sourceforge.net>

Gu Zheng <guz.fnst@cn.fujitsu.com> writes:

> On 07/22/2013 11:36 PM, Nikola Pajkovsky wrote:
>
>> Gu Zheng <guz.fnst@cn.fujitsu.com> writes:
>> 
>>> As we remove the target single node, so list_for_each is enought, in order to
>>> clean up, we use list_for_each_entry instead.
>>>
>>> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
>>> ---
>>>  fs/f2fs/checkpoint.c |    5 ++---
>>>  1 files changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>> index 290db04..87f7bc2 100644
>>> --- a/fs/f2fs/checkpoint.c
>>> +++ b/fs/f2fs/checkpoint.c
>>> @@ -237,13 +237,12 @@ out:
>>>  
>>>  void remove_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
>>>  {
>>> -	struct list_head *this, *next, *head;
>>> +	struct list_head *head;
>>>  	struct orphan_inode_entry *orphan;
>>>  
>>>  	mutex_lock(&sbi->orphan_inode_mutex);
>>>  	head = &sbi->orphan_inode_list;
>>> -	list_for_each_safe(this, next, head) {
>>> -		orphan = list_entry(this, struct orphan_inode_entry, list);
>>> +	list_for_each_entry(orphan, head, list) {
>>>  		if (orphan->ino == ino) {
>>>  			list_del(&orphan->list);
>>>  			kmem_cache_free(orphan_entry_slab, orphan);
>> 
>> you have meant list_for_each_entry_safe, haven't you?
>
> No that, here list_for_each_entry is suitable, because we delete only one entry.

yeah, you're correct.

-- 
Nikola

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
