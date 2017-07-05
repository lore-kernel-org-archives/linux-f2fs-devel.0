From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: avoid deadlock caused by lock
 order of page and lock_op
Date: Wed, 5 Jul 2017 10:58:53 +0800
Message-ID: <dd02d51c-ce5b-5b1a-eb12-847ef7b3cfc7@kernel.org>
References: <20170624162522.48931-1-jaegeuk@kernel.org>
	<f572292c-026a-7167-89b4-864b60d05865@huawei.com>
	<20170626145433.GA8560@jaegeuk-macbookpro.roam.corp.google.com>
	<060e5c2d-50cd-9f76-9efc-0cdec0d3df3b@kernel.org>
	<20170701072827.GB83795@jaegeuk-macbookpro.roam.corp.google.com>
	<556d8042-92f3-cb02-26c4-69e89b781c8c@kernel.org>
	<20170701142722.GA901@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1dSaXw-0003Zw-Ab
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Jul 2017 03:00:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dSaXu-0001CK-Ud
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Jul 2017 03:00:08 +0000
In-Reply-To: <20170701142722.GA901@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/7/1 22:27, Jaegeuk Kim wrote:
> On 07/01, Chao Yu wrote:
>> On 2017/7/1 15:28, Jaegeuk Kim wrote:
>>> On 06/26, Chao Yu wrote:
>>>> Hi Jaegeuk,
>>>>
>>>> On 2017/6/26 22:54, Jaegeuk Kim wrote:
>>>>> Hi Chao,
>>>>>
>>>>> On 06/26, Chao Yu wrote:
>>>>>> Hi Jaegeuk,
>>>>>>
>>>>>> On 2017/6/25 0:25, Jaegeuk Kim wrote:
>>>>>>> - punch_hole
>>>>>>>  - fill_zero
>>>>>>>   - f2fs_lock_op
>>>>>>>   - get_new_data_page
>>>>>>>    - lock_page
>>>>>>>
>>>>>>> - f2fs_write_data_pages
>>>>>>>  - lock_page
>>>>>>>  - do_write_data_page
>>>>>>>   - f2fs_lock_op
>>>>>>
>>>>>> Good catch!
>>>>>>
>>>>>> With this implementation, page writeback can fail due to concurrent checkpoint,
>>>>>> this will make fsync/atomic_commit which trigger synchronous write failed randomly.
>>>>>>
>>>>>> How about unifying the lock order in punch_hole as one in writepages for regular
>>>>>> inode? We can add one more parameter in get_new_data_page to indicate whether
>>>>>> callee needs to lock cp_rwsem.
>>>>>
>>>>> Currently, there would be some places to keep cp_rwsem -> page.lock, which seems
>>>>> not simple to change the lock order with page.lock -> cp_rwsem. IMO, we can retry
>>>>> flushing data in f2fs_sync_file, once it gets -EAGAIN.
>>>>>
>>>>> Any thoughts?
>>>>
>>>> What about adding inode_lock in f2fs_sync_file to exclude other
>>>> foreground operation which have reversed lock order? Atomic_commit is OK
>>>> since it has inode_lock in its path.
>>>
>>> I have concerned about performance regression, if we do that.
>>
>> I think fsync vs write or fsync vs fsync scenarios are unusual, so is
>> there any usecase?
> 
> Well, that'd be common to call multiple fsync calls at the same time.
> Like dbench or tiotest?

Do you have test numbers of dbench/tiotest with inode:lock in fsync?

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>>>> ---
>>>>>>>  fs/f2fs/data.c | 5 +++--
>>>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>>>> index 7d3af48d34a9..9141bd19a902 100644
>>>>>>> --- a/fs/f2fs/data.c
>>>>>>> +++ b/fs/f2fs/data.c
>>>>>>> @@ -1404,8 +1404,9 @@ int do_write_data_page(struct f2fs_io_info *fio)
>>>>>>>  		}
>>>>>>>  	}
>>>>>>>  
>>>>>>> -	if (fio->need_lock == LOCK_REQ)
>>>>>>> -		f2fs_lock_op(fio->sbi);
>>>>>>> +	/* Deadlock due to between page->lock and f2fs_lock_op */
>>>>>>> +	if (fio->need_lock == LOCK_REQ && !f2fs_trylock_op(fio->sbi))
>>>>>>> +		return -EAGAIN;
>>>>>>>  
>>>>>>>  	err = get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
>>>>>>>  	if (err)
>>>>>>>
>>>>>
>>>>> ------------------------------------------------------------------------------
>>>>> Check out the vibrant tech community on one of the world's most
>>>>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>>>>> _______________________________________________
>>>>> Linux-f2fs-devel mailing list
>>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>>>

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
