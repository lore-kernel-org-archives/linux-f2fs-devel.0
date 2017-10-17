From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: avoid stale fi->gdirty_list pointer
Date: Tue, 17 Oct 2017 21:15:07 +0800
Message-ID: <dc7a59ca-ae19-c401-ae60-517034d9e9ca@kernel.org>
References: <20171013021411.25850-1-jaegeuk@kernel.org>
 <7a1ee4f5-78c3-fcb8-c4ef-97c7d49e5a07@huawei.com>
 <20171016230626.GB94030@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1e4RiO-0001OY-Eb
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Oct 2017 13:15:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e4RiM-0005uo-0K
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Oct 2017 13:15:24 +0000
In-Reply-To: <20171016230626.GB94030@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/10/17 7:06, Jaegeuk Kim wrote:
> On 10/16, Chao Yu wrote:
>> On 2017/10/13 10:14, Jaegeuk Kim wrote:
>>> When doing fault injection test, f2fs_evict_inode() didn't remove gdirty_list
>>> which incurs a kernel panic due to wrong pointer access.
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>
>> Minor thing, how about reverting judgment condition for readability?
>>
>> if (is_set_ckpt_flags(sbi, CP_ERROR_FLAG))
>> 	f2fs_inode_synced()
> 
> We don't need to expect such the errored corner case first. ;)

Alright, making compiler being aware of this by using {un,}likely? :)

Thanks,

> 
>> else
>> 	f2fs_bug_on()
>>
>> Thanks,
>>
>>> ---
>>>  fs/f2fs/inode.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>>> index f6db9d533ca4..1ae5396c97d6 100644
>>> --- a/fs/f2fs/inode.c
>>> +++ b/fs/f2fs/inode.c
>>> @@ -535,6 +535,8 @@ void f2fs_evict_inode(struct inode *inode)
>>>  
>>>  	if (!is_set_ckpt_flags(sbi, CP_ERROR_FLAG))
>>>  		f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE));
>>> +	else
>>> +		f2fs_inode_synced(inode);
>>>  
>>>  	/* ino == 0, if f2fs_new_inode() was failed t*/
>>>  	if (inode->i_ino)
>>>
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
