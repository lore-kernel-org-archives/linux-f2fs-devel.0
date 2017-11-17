From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: let f2fs also gc atomic file to avoid
 loop gc
Date: Fri, 17 Nov 2017 13:47:57 +0800
Message-ID: <b23fdd96-667b-45ef-b7f4-396f054cb692@huawei.com>
References: <1510108497-58331-1-git-send-email-yunlong.song@huawei.com>
 <239f770e-53f0-69c6-fc1d-67aeb9a1065a@huawei.com>
 <a26c3d6a-5720-31d0-da29-73cf45e2ade0@huawei.com>
 <d5c26f31-2e0c-8b4d-c7f4-b11ff38c20fb@huawei.com>
 <383339b7-528d-3085-1399-1f1694178c15@huawei.com>
 <415c8c26-498e-b3f6-2907-fc1ca8c63ad9@huawei.com>
 <05a5bbc0-c54d-8460-bf1a-678357778360@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eFZWq-0007vu-H2
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Nov 2017 05:49:28 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eFZWo-0002IJ-0K
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Nov 2017 05:49:28 +0000
In-Reply-To: <05a5bbc0-c54d-8460-bf1a-678357778360@huawei.com>
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
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: linux-fsdevel@vger.kernel.org, miaoxie@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/11/17 11:30, Yunlong Song wrote:
> How about add file_write_and_wait_range in __write_node_page as following:
> if (atomic && !test_opt(sbi, NOBARRIER)) {
>      file_write_and_wait_range(file, 0, LLONG_MAX);

Nope, GCed encrypted data wouldn't be cached in inode page cache.

I don't think adding raw code to flush data here is a good implementation,
it incurs complicated lock dependency relation. Instead, IMO, it will be
better to use inmem_lock to avoid race in between GC and atomic commit flow.

Thanks,

>      fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
> }
> 
> The all the GCed data will be flushed to non-volatile before last node 
> write with REQ_PREFLUSH | REQ_FUA.
> 
> On 2017/11/17 11:20, Chao Yu wrote:
>> On 2017/11/17 11:04, Yunlong Song wrote:
>>> The atomic commit will trigger:
>>>       -f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true)
>>>           -file_write_and_wait_range(file, 0, LLONG_MAX)
>>>           -fsync_node_pages
>>>               -__write_node_page
>>>                   -REQ_PREFLUSH | REQ_FUA
>>>
>>> So data is flushed to non-volatile before  last node write with > REQ_PREFLUSH | REQ_FUA,
>> I mean GCed data.
>>
>> - file_write_and_wait_range
>> 					- move_data_block
>> 					 - f2fs_submit_page_write
>> 					  - f2fs_update_data_blkaddr
>> 					   - set_page_dirty
>>   - fsync_node_pages
>>
>> Thanks,
>>
>>> we do not need to worry about the inconsistent problem. Right?
>>>
>>> On 2017/11/17 10:49, Chao Yu wrote:
>>>> On 2017/11/17 8:58, Yunlong Song wrote:
>>>>> Is there any problem if just deleting the judgement condition in this patch?
>>>> IIRC, dirty node comes from data segment GC can be writebacked & flushed during
>>>> atomic commit, but related data will still be in inner bio cache, after later
>>>> SPOR, data would be inconsistent.
>>>>
>>>> Thanks,
>>>>
>>>>> On 2017/11/8 17:28, Chao Yu wrote:
>>>>>> On 2017/11/8 10:34, Yunlong Song wrote:
>>>>>>> If some files are opened with atomic flag and have not commited yet, at
>>>>>>> the same time, if all the target victim segments have at least one page
>>>>>>> of these atomic files, then f2fs gc will fail to do gc and hangs in the
>>>>>>> process of go to gc_more, since gc_date_segment will not move any data
>>>>>>> and get_valid_blocks will never be 0, then do_garbage_collect will
>>>>>>> always return 0.
>>>>>> Oh, I added this judgment condition to avoid ruining atomic write by data
>>>>>> GC, could we find another way to solve this issue? BTW, if there is direct
>>>>>> IO, we will also skip data segment GC.
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>>>>>> ---
>>>>>>>     fs/f2fs/gc.c | 6 ------
>>>>>>>     1 file changed, 6 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>>>>> index 5d5bba4..3fdcd04 100644
>>>>>>> --- a/fs/f2fs/gc.c
>>>>>>> +++ b/fs/f2fs/gc.c
>>>>>>> @@ -621,9 +621,6 @@ static void move_data_block(struct inode *inode, block_t bidx,
>>>>>>>     	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
>>>>>>>     		goto out;
>>>>>>>     
>>>>>>> -	if (f2fs_is_atomic_file(inode))
>>>>>>> -		goto out;
>>>>>>> -
>>>>>>>     	set_new_dnode(&dn, inode, NULL, NULL, 0);
>>>>>>>     	err = get_dnode_of_data(&dn, bidx, LOOKUP_NODE);
>>>>>>>     	if (err)
>>>>>>> @@ -718,9 +715,6 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
>>>>>>>     	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
>>>>>>>     		goto out;
>>>>>>>     
>>>>>>> -	if (f2fs_is_atomic_file(inode))
>>>>>>> -		goto out;
>>>>>>> -
>>>>>>>     	if (gc_type == BG_GC) {
>>>>>>>     		if (PageWriteback(page))
>>>>>>>     			goto out;
>>>>>>>
>>>>>> .
>>>>>>
>>>> .
>>>>
>>
>> .
>>
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
