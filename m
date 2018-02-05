From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: enable to gc page whose inode
 already atomic commit
Date: Mon, 5 Feb 2018 10:53:13 +0800
Message-ID: <f4e7b403-4945-a7f9-6bdc-214dc61c9160@huawei.com>
References: <1517626068-49739-1-git-send-email-yunlong.song@huawei.com>
 <a094cd40-d042-2a43-4e9a-e34c31e61d28@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yunlong.song@huawei.com>) id 1eiWvS-0006wh-4c
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 05 Feb 2018 02:54:34 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eiWvQ-0008G5-H9
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 05 Feb 2018 02:54:34 +0000
In-Reply-To: <a094cd40-d042-2a43-4e9a-e34c31e61d28@kernel.org>
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
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com
Cc: shengyong1@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, heyunlei@huawei.com, miaoxie@huawei.com

Is it necessary to add a lock here? What's the problem of this patch (no 
lock at all)? Anyway, the problem is expected to be fixed asap, since 
attackers can easily write an app with only atomic start and no atomic 
commit, which will cause f2fs run into loop gc if the disk layout is 
much fragmented, since f2fs_gc will select the same target victim all 
the time (e.g. one block of target victim belongs to the opened atomic 
file, and it will not be moved and do_garbage_collect will finally 
return 0, and that victim is selected again next time) and goto gc_more 
time and time again, which will block all the fs ops (all the fs ops 
will hang up in f2fs_balance_fs).

On 2018/2/4 22:56, Chao Yu wrote:
> On 2018/2/3 10:47, Yunlong Song wrote:
>> If inode has already started to atomic commit, then set_page_dirty will
>> not mix the gc pages with the inmem atomic pages, so the page can be
>> gced safely.
> 
> Let's avoid Ccing fs mailing list if the patch didn't change vfs common
> codes.
> 
> As you know, the problem here is mixed dnode block flushing w/o writebacking
> gced data block, result in making transaction unintegrated.
> 
> So how about just using dio_rwsem[WRITE] during atomic committing to exclude
> GCing data block of atomic opened file?
> 
> Thanks,
> 
>>
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>> ---
>>   fs/f2fs/data.c | 5 ++---
>>   fs/f2fs/gc.c   | 6 ++++--
>>   2 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 7435830..edafcb6 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -1580,14 +1580,13 @@ bool should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
>>   		return true;
>>   	if (S_ISDIR(inode->i_mode))
>>   		return true;
>> -	if (f2fs_is_atomic_file(inode))
>> -		return true;
>>   	if (fio) {
>>   		if (is_cold_data(fio->page))
>>   			return true;
>>   		if (IS_ATOMIC_WRITTEN_PAGE(fio->page))
>>   			return true;
>> -	}
>> +	} else if (f2fs_is_atomic_file(inode))
>> +		return true;
>>   	return false;
>>   }
>>   
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index b9d93fd..84ab3ff 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -622,7 +622,8 @@ static void move_data_block(struct inode *inode, block_t bidx,
>>   	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
>>   		goto out;
>>   
>> -	if (f2fs_is_atomic_file(inode))
>> +	if (f2fs_is_atomic_file(inode) &&
>> +		!f2fs_is_commit_atomic_write(inode))
>>   		goto out;
>>   
>>   	if (f2fs_is_pinned_file(inode)) {
>> @@ -729,7 +730,8 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
>>   	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
>>   		goto out;
>>   
>> -	if (f2fs_is_atomic_file(inode))
>> +	if (f2fs_is_atomic_file(inode) &&
>> +		!f2fs_is_commit_atomic_write(inode))
>>   		goto out;
>>   	if (f2fs_is_pinned_file(inode)) {
>>   		if (gc_type == FG_GC)
>>
> 
> .
> 

-- 
Thanks,
Yunlong Song


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
