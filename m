From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/2] f2fs: fix to update node page under
	cp_rwsem
Date: Sat, 27 Aug 2016 16:30:30 +0800
Message-ID: <4a9f9515-c1e2-aab0-d573-c3a4eda6aed7@huawei.com>
References: <1472228072-4555-1-git-send-email-chao@kernel.org>
	<1472228072-4555-2-git-send-email-chao@kernel.org>
	<20160826170455.GB88444@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1bdZ2C-0000Zn-8t
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 27 Aug 2016 08:32:12 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bdZ28-0003Kp-HL
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 27 Aug 2016 08:32:12 +0000
In-Reply-To: <20160826170455.GB88444@jaegeuk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2016/8/27 1:04, Jaegeuk Kim wrote:
> On Sat, Aug 27, 2016 at 12:14:32AM +0800, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> Update node page under cp_rwsem in order to keep data consistency
>> during writting checkpoint.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/inode.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>> index 9ac5efc..1057c73 100644
>> --- a/fs/f2fs/inode.c
>> +++ b/fs/f2fs/inode.c
>> @@ -377,8 +377,11 @@ retry:
>>  		goto retry;
>>  	}
>>  
>> -	if (err)
>> +	if (err) {
>> +		f2fs_lock_op(sbi);
>>  		update_inode_page(inode);
>> +		f2fs_unlock_op(sbi);
>> +	}
> 
> Any corner case?

No, just follow the old rule.

> Now, it allows updating node page when checkpoint is doing.

Oh, so for current rule, during checkpoint it:
1. allows updating meta info of inode which is not related to metadata of
filesystem (e.g. i_size, i_block, i_nlink..)
2. does not allow updating meta info of inode which is related to metadata of
filesystem (i_addr, i_nid..)

Is my understanding right?

Thanks,

> 
> Thanks,
> 
>>  	sb_end_intwrite(inode->i_sb);
>>  no_delete:
>>  	stat_dec_inline_xattr(inode);
>> -- 
>> 2.7.2
> 
> .
> 


------------------------------------------------------------------------------
