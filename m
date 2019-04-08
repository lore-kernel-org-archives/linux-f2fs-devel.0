From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid accessing xattr across the
 boundary
Date: Mon, 8 Apr 2019 20:14:43 +0800
Message-ID: <60f10416-4055-edb6-0e84-88eca3ea50bd@huawei.com>
References: <20190408085016.13042-1-huangrandall@google.com>
 <bc8b164b-4787-cf81-9b47-334e7e0be630@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bc8b164b-4787-cf81-9b47-334e7e0be630@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Randall Huang <huangrandall@google.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019/4/8 20:03, Chao Yu wrote:
> Hi Randall,
> 
> On 2019/4/8 16:50, Randall Huang wrote:
>> When we traverse xattr entries via __find_xattr(),
>> if the raw filesystem content is faked or any hardware failure occurs,
>> out-of-bound error can be detected by KASAN.
>> Fix the issue by introducing boundary check.
>>
>> [   38.402878] c7   1827 BUG: KASAN: slab-out-of-bounds in f2fs_getxattr+0x518/0x68c
>> [   38.402891] c7   1827 Read of size 4 at addr ffffffc0b6fb35dc by task
>> [   38.402935] c7   1827 Call trace:
>> [   38.402952] c7   1827 [<ffffff900809003c>] dump_backtrace+0x0/0x6bc
>> [   38.402966] c7   1827 [<ffffff9008090030>] show_stack+0x20/0x2c
>> [   38.402981] c7   1827 [<ffffff900871ab10>] dump_stack+0xfc/0x140
>> [   38.402995] c7   1827 [<ffffff9008325c40>] print_address_description+0x80/0x2d8
>> [   38.403009] c7   1827 [<ffffff900832629c>] kasan_report_error+0x198/0x1fc
>> [   38.403022] c7   1827 [<ffffff9008326104>] kasan_report_error+0x0/0x1fc
>> [   38.403037] c7   1827 [<ffffff9008325000>] __asan_load4+0x1b0/0x1b8
>> [   38.403051] c7   1827 [<ffffff90085fcc44>] f2fs_getxattr+0x518/0x68c
>> [   38.403066] c7   1827 [<ffffff90085fc508>] f2fs_xattr_generic_get+0xb0/0xd0
>> [   38.403080] c7   1827 [<ffffff9008395708>] __vfs_getxattr+0x1f4/0x1fc
>> [   38.403096] c7   1827 [<ffffff9008621bd0>] inode_doinit_with_dentry+0x360/0x938
>> [   38.403109] c7   1827 [<ffffff900862d6cc>] selinux_d_instantiate+0x2c/0x38
>> [   38.403123] c7   1827 [<ffffff900861b018>] security_d_instantiate+0x68/0x98
>> [   38.403136] c7   1827 [<ffffff9008377db8>] d_splice_alias+0x58/0x348
>> [   38.403149] c7   1827 [<ffffff900858d16c>] f2fs_lookup+0x608/0x774
>> [   38.403163] c7   1827 [<ffffff900835eacc>] lookup_slow+0x1e0/0x2cc
>> [   38.403177] c7   1827 [<ffffff9008367fe0>] walk_component+0x160/0x520
>> [   38.403190] c7   1827 [<ffffff9008369ef4>] path_lookupat+0x110/0x2b4
>> [   38.403203] c7   1827 [<ffffff900835dd38>] filename_lookup+0x1d8/0x3a8
>> [   38.403216] c7   1827 [<ffffff900835eeb0>] user_path_at_empty+0x54/0x68
>> [   38.403229] c7   1827 [<ffffff9008395f44>] SyS_getxattr+0xb4/0x18c
>> [   38.403241] c7   1827 [<ffffff9008084200>] el0_svc_naked+0x34/0x38
>>
>> Bug: 126558260
>>
>> Signed-off-by: Randall Huang <huangrandall@google.com>
>> ---
>>  fs/f2fs/xattr.c | 22 ++++++++++++++++------
>>  1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
>> index 848a785abe25..0531c1e38275 100644
>> --- a/fs/f2fs/xattr.c
>> +++ b/fs/f2fs/xattr.c
>> @@ -202,12 +202,17 @@ static inline const struct xattr_handler *f2fs_xattr_handler(int index)
>>  	return handler;
>>  }
>>  
>> -static struct f2fs_xattr_entry *__find_xattr(void *base_addr, int index,
>> -					size_t len, const char *name)
>> +static struct f2fs_xattr_entry *__find_xattr(void *base_addr,
>> +				int base_addr_limit, int index,
> 
> unsigned int max_size,
> 
>> +				size_t len, const char *name)
>>  {
>>  	struct f2fs_xattr_entry *entry;
>> +	void *max_addr = base_addr + ENTRY_SIZE(XATTR_ENTRY(base_addr)) +
>> +		base_addr_limit - 1;
> 
> If I'm not missing something, shouldn't it be?
> 
> void *max_addr = base_addr + max_size;
> 
>>  
>>  	list_for_each_xattr(entry, base_addr) {
>> +		if ((void *)entry + sizeof(__u32) > max_addr)
>> +			return NULL;
>>  		if (entry->e_name_index != index)
>>  			continue;
>>  		if (entry->e_name_len != len)
>> @@ -337,9 +342,9 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
>>  	else
>>  		cur_addr = txattr_addr;
>>  
>> -	*xe = __find_xattr(cur_addr, index, len, name);
>> +	*xe = __find_xattr(cur_addr, XATTR_PADDING_SIZE, index, len, name);
> 
> max_size = *base_size - (txattr_addr - cur_addr);

max_size = *base_size - (cur_addr - txattr_addr);

> *xe = __find_xattr(cur_addr, max_size, index, len, name);
> 
>>  check:
>> -	if (IS_XATTR_LAST_ENTRY(*xe)) {
>> +	if (!*xe || IS_XATTR_LAST_ENTRY(*xe)) {
> 
> If xattr entry across boundary of max xattr space size, maybe we'd better return -EFAULT
> which can be distinguished from a real -ENODATA error, latter, we can set SBI_NEED_FSCK
> to give a repairing hint to fsck. :)
> 
>>  		err = -ENODATA;
>>  		goto out;
>>  	}
>> @@ -606,9 +611,14 @@ static int __f2fs_setxattr(struct inode *inode, int index,
>>  		return error;
>>  
>>  	/* find entry with wanted name. */
>> -	here = __find_xattr(base_addr, index, len, name);
>> +	here = __find_xattr(base_addr, inline_xattr_size(inode) +
>> +			VALID_XATTR_BLOCK_SIZE + XATTR_PADDING_SIZE,
>> +			index, len, name);
> 
> unsigned int size = F2FS_I(inode)->i_xattr_nid ? VALID_XATTR_BLOCK_SIZE : 0;
> unsigned int max_size = inline_xattr_size(inode) + size + XATTR_PADDING_SIZE;
> 
> here = __find_xattr(..., max_size, ...);
> 
> if (!here)
> 	return -EFAULT;
> 
> Thanks,
> 
>>  
>> -	found = IS_XATTR_LAST_ENTRY(here) ? 0 : 1;
>> +	if (!here)
>> +		found = 0;
>> +	else
>> +		found = IS_XATTR_LAST_ENTRY(here) ? 0 : 1;
>>  
>>  	if (found) {
>>  		if ((flags & XATTR_CREATE)) {
>>
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
