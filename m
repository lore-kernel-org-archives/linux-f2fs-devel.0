From: Kinglong Mee <kinglongmee@gmail.com>
Subject: Re: [PATCH] f2fs: copy all valid xattr data includes the
 last zero
Date: Wed, 22 Mar 2017 18:26:26 +0800
Message-ID: <6706117f-59d5-25e3-947c-97edd0ca8c32@gmail.com>
References: <b70f5f84-a4e9-c0e2-d654-5a257eeffa35@gmail.com>
	<20170320030842.GB45667@jaegeuk.local>
	<10384529-5d09-712c-abba-a981be074072@gmail.com>
	<20170321161830.GB61126@jaegeuk.local>
	<9ed8366e-28f7-edf4-5078-54638d2c8990@huawei.com>
	<cab19337-7713-de29-c59a-398e75077b51@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cqdTV-00054a-67
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Mar 2017 10:26:41 +0000
Received: from mail-io0-f194.google.com ([209.85.223.194])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cqdTT-0001PF-Cr
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Mar 2017 10:26:41 +0000
Received: by mail-io0-f194.google.com with SMTP id f103so9781991ioi.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 22 Mar 2017 03:26:39 -0700 (PDT)
In-Reply-To: <cab19337-7713-de29-c59a-398e75077b51@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 3/22/2017 18:16, Chao Yu wrote:
> On 2017/3/22 16:42, Chao Yu wrote:
>> On 2017/3/22 0:18, Jaegeuk Kim wrote:
>>> On 03/20, Kinglong Mee wrote:
>>>> On 3/20/2017 11:08, Jaegeuk Kim wrote:
>>>>> Hi Kinglong,
>>>>>
>>>>> On 03/18, Kinglong Mee wrote:
>>>>>> It's better coping all valid xattr data includes the last zero. 
>>>>>
>>>>> Why do we need this?
>>>>>
>>>>> The size of txattr_addr would be larger than the space we need.
>>>>>
>>>>> Thanks,
>>>>>
>>>>>>
>>>>>> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
>>>>>> ---
>>>>>>  fs/f2fs/xattr.c | 4 ++--
>>>>>>  fs/f2fs/xattr.h | 4 ++--
>>>>>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
>>>>>> index aff7619..41785c9 100644
>>>>>> --- a/fs/f2fs/xattr.c
>>>>>> +++ b/fs/f2fs/xattr.c
>>>>>> @@ -249,7 +249,7 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
>>>>>>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>>>>  	void *cur_addr, *txattr_addr, *last_addr = NULL;
>>>>>>  	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
>>>>>> -	unsigned int size = xnid ? VALID_XATTR_BLOCK_SIZE : 0;
>>>>
>>>> Here maybe does not copy the last zero.
>>>
>>> The below kzalloc() will make it zero. Any problem?
>>
>> There is no problem without this change, but anyway, IMO, it needs to do cleanup
>> as it can provider better readability making allocated size and copied size be
>> consistent among lookup_all_xattrs, read_all_xattrs and write_all_xattrs.
>>
>> And since during allocation we have initialize memory with zero, so I prefer to
>> not copy extra reserved xattr space.
>>
>> Jaegeuk, Kinglong, how about changing like below:
>>
>> ---
>>  fs/f2fs/xattr.c | 27 ++++++++++++---------------
>>  fs/f2fs/xattr.h |  3 ++-
>>  2 files changed, 14 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
>> index aff7619e3f96..308b06664068 100644
>> --- a/fs/f2fs/xattr.c
>> +++ b/fs/f2fs/xattr.c
>> @@ -250,15 +250,13 @@ static int lookup_all_xattrs(struct inode *inode, struct
>> page *ipage,
>>  	void *cur_addr, *txattr_addr, *last_addr = NULL;
>>  	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
>>  	unsigned int size = xnid ? VALID_XATTR_BLOCK_SIZE : 0;
>> -	unsigned int inline_size = 0;
>> +	unsigned int inline_size = inline_xattr_size(inode);
>>  	int err = 0;
>>
>> -	inline_size = inline_xattr_size(inode);
>> -
>>  	if (!size && !inline_size)
>>  		return -ENODATA;
>>
>> -	txattr_addr = kzalloc(inline_size + size + sizeof(__u32),
>> +	txattr_addr = kzalloc(inline_size + size + RESERVED_XATTR_SIZE,
>>  							GFP_F2FS_ZERO);
>>  	if (!txattr_addr)
>>  		return -ENOMEM;
>> @@ -328,13 +326,14 @@ static int read_all_xattrs(struct inode *inode, struct
>> page *ipage,
>>  {
>>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>  	struct f2fs_xattr_header *header;
>> -	size_t size = PAGE_SIZE, inline_size = 0;
>> +	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
>> +	unsigned int size = xnid ? VALID_XATTR_BLOCK_SIZE : 0;
> 
> Here, always should assign size with VALID_XATTR_BLOCK_SIZE for enospc case in
> inline xattr space while adding new xattr entry.
> 
> unsigned int size = VALID_XATTR_BLOCK_SIZE;

It's better that mine.

Reviewed-by: Kinglong Mee <kinglongmee@gmail.com>

Thanks,
Kinglong Mee

> 
> Thanks,
> 
>> +	unsigned int inline_size = inline_xattr_size(inode);
>>  	void *txattr_addr;
>>  	int err;
>>
>> -	inline_size = inline_xattr_size(inode);
>> -
>> -	txattr_addr = kzalloc(inline_size + size, GFP_F2FS_ZERO);
>> +	txattr_addr = kzalloc(inline_size + size + RESERVED_XATTR_SIZE,
>> +							GFP_F2FS_ZERO);
>>  	if (!txattr_addr)
>>  		return -ENOMEM;
>>
>> @@ -358,19 +357,19 @@ static int read_all_xattrs(struct inode *inode, struct
>> page *ipage,
>>  	}
>>
>>  	/* read from xattr node block */
>> -	if (F2FS_I(inode)->i_xattr_nid) {
>> +	if (xnid) {
>>  		struct page *xpage;
>>  		void *xattr_addr;
>>
>>  		/* The inode already has an extended attribute block. */
>> -		xpage = get_node_page(sbi, F2FS_I(inode)->i_xattr_nid);
>> +		xpage = get_node_page(sbi, xnid);
>>  		if (IS_ERR(xpage)) {
>>  			err = PTR_ERR(xpage);
>>  			goto fail;
>>  		}
>>
>>  		xattr_addr = page_address(xpage);
>> -		memcpy(txattr_addr + inline_size, xattr_addr, PAGE_SIZE);
>> +		memcpy(txattr_addr + inline_size, xattr_addr, size);
>>  		f2fs_put_page(xpage, 1);
>>  	}
>>
>> @@ -392,14 +391,12 @@ static inline int write_all_xattrs(struct inode *inode,
>> __u32 hsize,
>>  				void *txattr_addr, struct page *ipage)
>>  {
>>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>> -	size_t inline_size = 0;
>> +	size_t inline_size = inline_xattr_size(inode);
>>  	void *xattr_addr;
>>  	struct page *xpage;
>>  	nid_t new_nid = 0;
>>  	int err;
>>
>> -	inline_size = inline_xattr_size(inode);
>> -
>>  	if (hsize > inline_size && !F2FS_I(inode)->i_xattr_nid)
>>  		if (!alloc_nid(sbi, &new_nid))
>>  			return -ENOSPC;
>> @@ -454,7 +451,7 @@ static inline int write_all_xattrs(struct inode *inode,
>> __u32 hsize,
>>  	}
>>
>>  	xattr_addr = page_address(xpage);
>> -	memcpy(xattr_addr, txattr_addr + inline_size, MAX_XATTR_BLOCK_SIZE);
>> +	memcpy(xattr_addr, txattr_addr + inline_size, VALID_XATTR_BLOCK_SIZE);
>>  	set_page_dirty(xpage);
>>  	f2fs_put_page(xpage, 1);
>>
>> diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
>> index d5a94928c116..1e7db8d0806e 100644
>> --- a/fs/f2fs/xattr.h
>> +++ b/fs/f2fs/xattr.h
>> @@ -73,7 +73,8 @@ struct f2fs_xattr_entry {
>>  				!IS_XATTR_LAST_ENTRY(entry);\
>>  				entry = XATTR_NEXT_ENTRY(entry))
>>  #define MAX_XATTR_BLOCK_SIZE	(PAGE_SIZE - sizeof(struct node_footer))
>> -#define VALID_XATTR_BLOCK_SIZE	(MAX_XATTR_BLOCK_SIZE - sizeof(__u32))
>> +#define RESERVED_XATTR_SIZE	(sizeof(__u32))
>> +#define VALID_XATTR_BLOCK_SIZE	(MAX_XATTR_BLOCK_SIZE - RESERVED_XATTR_SIZE)
>>  #define MIN_OFFSET(i)		XATTR_ALIGN(inline_xattr_size(i) +	\
>>  						VALID_XATTR_BLOCK_SIZE)
>>
> 
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
