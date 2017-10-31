From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [RFC PATCH 6/8] fsck.f2fs: introduce new option
 --dry-run
Date: Tue, 31 Oct 2017 19:10:19 +0800
Message-ID: <339434e4-1ffd-a010-ce15-ecbbe0984123@huawei.com>
References: <20171031013824.46544-1-shengyong1@huawei.com>
 <20171031013824.46544-6-shengyong1@huawei.com>
 <9ebcb886-ae85-6cb0-2a61-df3d2a585df1@huawei.com>
 <856efe58-e45a-ee50-6227-c4a8c25405a8@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e9URV-00063d-Mw
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 11:10:49 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e9URP-00054v-1A
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 11:10:49 +0000
In-Reply-To: <856efe58-e45a-ee50-6227-c4a8c25405a8@huawei.com>
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
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/10/31 17:19, Sheng Yong wrote:
> 
> 
> On 2017/10/31 15:57, Chao Yu wrote:
>> On 2017/10/31 9:38, Sheng Yong wrote:
>>> With --dry-run enabled, fsck.f2fs will do all checks and "fixes" except
>>> that all fixes will not be written to storage at last.
>>>
>>> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
>>> ---
>>>   fsck/main.c       | 14 +++++++++++++-
>>>   include/f2fs_fs.h |  1 +
>>>   lib/libf2fs.c     |  1 +
>>>   lib/libf2fs_io.c  |  3 +++
>>>   4 files changed, 18 insertions(+), 1 deletion(-)
>>>
>>>   
> [...]
>>>   static int is_mounted(const char *mpt, const char *device)
>>> diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
>>> index 50ff171..8a79672 100644
>>> --- a/lib/libf2fs_io.c
>>> +++ b/lib/libf2fs_io.c
>>> @@ -129,6 +129,9 @@ int dev_write(void *buf, __u64 offset, size_t len)
>>>   {
>>>   	int fd;
>>>   
>>> +	if (c.dry_run)
>>> +		return 0;
>>> +
>>>   	if (c.sparse_mode)
>>>   		return dev_write_sparse(buf, offset, len);
>>
>> Do we need to cover dev_write_block?
> dev_write_block calls dev_write. So dev_write_block is also covered by intercepting
> write in dev_write. :)

Correct. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
> Thanks,
> Sheng
>>
>> Thanks,
>>
>>>   
>>>
>>
>>
>> .
>>
> 
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
