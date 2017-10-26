From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: fix to keep backward compatibility of
 flexible inline xattr feature
Date: Thu, 26 Oct 2017 19:25:39 +0800
Message-ID: <fc58a8ae-2fa9-f8b2-2a75-3b729ef628e5@kernel.org>
References: <20171025103124.63162-1-yuchao0@huawei.com>
 <20171026084243.GA54331@jaegeuk-macbookpro.roam.corp.google.com>
 <37f397bd-fa5b-c7f0-bb20-ea3be98437cd@huawei.com>
 <20171026091108.GC54331@jaegeuk-macbookpro.roam.corp.google.com>
 <20171026100257.GA60038@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1e7gIP-0003js-8A
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Oct 2017 11:25:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e7gIO-000064-5g
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Oct 2017 11:25:57 +0000
In-Reply-To: <20171026100257.GA60038@jaegeuk-macbookpro.roam.corp.google.com>
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

On 2017/10/26 18:02, Jaegeuk Kim wrote:
> Hi Chao,
> 
> On 10/26, Jaegeuk Kim wrote:
>> On 10/26, Chao Yu wrote:
>>> Hi Jaegeuk,
>>>
>>> On 2017/10/26 16:42, Jaegeuk Kim wrote:
>>>> Hi Chao,
>>>>
>>>> It seems this is a critical problem, so let me integrate this patch with your
>>>> initial patch "f2fs: support flexible inline xattr size".
>>>> Let me know, if you have any other concern.
>>>
>>> Better. ;)
>>>
>>> Please add commit message of this patch into initial patch "f2fs: support
>>> flexible inline xattr size".
> 
> BTW, I read the patch again, and couldn't catch the problem actually.
> We didn't assign inline_xattr all the time, instead do if inline_xattr

But you can see, MAX_INLINE_DATA is calculated as below, in where we will always
reserve F2FS_INLINE_XATTR_ADDRS of 200 bytes, now we will change
F2FS_INLINE_XATTR_ADDRS to F2FS_INLINE_XATTR_ADDRS(inode) which is an flexible
size, so MAX_INLINE_DATA could be calculated to expand 200 bytes than before,

It is okay for regular or symlink inode generated in old kernel to enlarge
MAX_INLINE_DATA in new kernel, as reserved 200 bytes in inode are zero all the
time, for directory, it will be problematic because our layout of inline
dentry page is fixed and calculated according to MAX_INLINE_DATA, so if
MAX_INLINE_DATA is enlarged, fields offset in dentry structure will relocate,
result in incompatibility.

#define MAX_INLINE_DATA(inode)	(sizeof(__le32) * \
				(CUR_ADDRS_PER_INODE(inode) - \
				DEF_INLINE_RESERVED_SIZE - \
				F2FS_INLINE_XATTR_ADDRS))

> is set. Have you done some tests with this? I'm failing tests with these
> changes.

Oh, sorry, I just tested with this patch without the modification of f2fs-tools,
fstest didn't report any errors so far.

Thanks,

> 
>>>
>>> And please fix related issue in f2fs-tools with below diff code:
>>
>> Okay, merged.
>>
>> Thanks,
>>
>>>
>>> ---
>>>  include/f2fs_fs.h | 9 ++++++---
>>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
>>> index 2db7495804fd..a0e15ba85d97 100644
>>> --- a/include/f2fs_fs.h
>>> +++ b/include/f2fs_fs.h
>>> @@ -1047,11 +1047,14 @@ static inline int __get_extra_isize(struct f2fs_inode *inode)
>>>  extern struct f2fs_configuration c;
>>>  static inline int get_inline_xattr_addrs(struct f2fs_inode *inode)
>>>  {
>>> -	if (!(inode->i_inline & F2FS_INLINE_XATTR))
>>> +	if ((c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) &&
>>> +		(c.feature & cpu_to_le32(F2FS_FEATURE_FLEXIBLE_INLINE_XATTR)))
>>> +		return le16_to_cpu(inode->i_inline_xattr_size);
>>> +	else if (!(inode->i_inline & F2FS_INLINE_XATTR) &&
>>> +		(S_ISREG(inode->i_mode) || S_ISLNK(inode->i_mode)))
>>>  		return 0;
>>> -	if (!(c.feature & cpu_to_le32(F2FS_FEATURE_FLEXIBLE_INLINE_XATTR)))
>>> +	else
>>>  		return DEFAULT_INLINE_XATTR_ADDRS;
>>> -	return le16_to_cpu(inode->i_inline_xattr_size);
>>>  }
>>>
>>>  #define get_extra_isize(node)	__get_extra_isize(&node->i)
>>> -- 
>>>
>>> Thanks,
>>>
>>>>
>>>> Thanks,
>>>>
>>>> On 10/25, Chao Yu wrote:
>>>>> Previously, in inode layout, we will always reserve 200 bytes for inline
>>>>> xattr space no matter the inode enables inline xattr feature or not, due
>>>>> to this reason, max inline size of inode is fixed, but now, if inline
>>>>> xattr is not enabled, max inline size of inode will be enlarged by 200
>>>>> bytes, for regular and symlink inode, it will be safe to reuse resevered
>>>>> space as they are all zero, but for directory, we need to keep the
>>>>> reservation for stablizing directory structure.
>>>>>
>>>>> Reported-by: Sheng Yong <shengyong1@huawei.com>
>>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>>> ---
>>>>>  fs/f2fs/f2fs.h  |  5 +----
>>>>>  fs/f2fs/inode.c | 15 ++++++++++++---
>>>>>  fs/f2fs/namei.c |  2 ++
>>>>>  3 files changed, 15 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>> index 2af1d31ae74b..7ddd0d085e3b 100644
>>>>> --- a/fs/f2fs/f2fs.h
>>>>> +++ b/fs/f2fs/f2fs.h
>>>>> @@ -2393,10 +2393,7 @@ static inline int get_extra_isize(struct inode *inode)
>>>>>  static inline int f2fs_sb_has_flexible_inline_xattr(struct super_block *sb);
>>>>>  static inline int get_inline_xattr_addrs(struct inode *inode)
>>>>>  {
>>>>> -	if (!f2fs_has_inline_xattr(inode))
>>>>> -		return 0;
>>>>> -	if (!f2fs_sb_has_flexible_inline_xattr(F2FS_I_SB(inode)->sb))
>>>>> -		return DEFAULT_INLINE_XATTR_ADDRS;
>>>>> +
>>>>>  	return F2FS_I(inode)->i_inline_xattr_size;
>>>>>  }
>>>>>  
>>>>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>>>>> index bb876737e653..7f31b22c9efa 100644
>>>>> --- a/fs/f2fs/inode.c
>>>>> +++ b/fs/f2fs/inode.c
>>>>> @@ -232,10 +232,19 @@ static int do_read_inode(struct inode *inode)
>>>>>  	fi->i_extra_isize = f2fs_has_extra_attr(inode) ?
>>>>>  					le16_to_cpu(ri->i_extra_isize) : 0;
>>>>>  
>>>>> -	if (!f2fs_has_inline_xattr(inode))
>>>>> -		fi->i_inline_xattr_size = 0;
>>>>> -	else if (f2fs_sb_has_flexible_inline_xattr(sbi->sb))
>>>>> +	/*
>>>>> +	 * Previously, we will always reserve DEFAULT_INLINE_XATTR_ADDRS size
>>>>> +	 * space for inline xattr datas, if inline xattr is not enabled, we
>>>>> +	 * can expect all zero in reserved area, so for regular or symlink,
>>>>> +	 * it will be safe to reuse reserved area, but for directory, we
>>>>> +	 * should keep the reservation for stablizing directory structure.
>>>>> +	 */
>>>>> +	if (f2fs_has_extra_attr(inode) &&
>>>>> +		f2fs_sb_has_flexible_inline_xattr(sbi->sb))
>>>>>  		fi->i_inline_xattr_size = le16_to_cpu(ri->i_inline_xattr_size);
>>>>> +	else if (!f2fs_has_inline_xattr(inode) &&
>>>>> +		(S_ISREG(inode->i_mode) || S_ISLNK(inode->i_mode)))
>>>>> +		fi->i_inline_xattr_size = 0;
>>>>>  	else
>>>>>  		fi->i_inline_xattr_size = DEFAULT_INLINE_XATTR_ADDRS;
>>>>>  
>>>>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>>>>> index e6f86d5d97b9..a1c56a14c191 100644
>>>>> --- a/fs/f2fs/namei.c
>>>>> +++ b/fs/f2fs/namei.c
>>>>> @@ -91,6 +91,8 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
>>>>>  		f2fs_sb_has_flexible_inline_xattr(sbi->sb) &&
>>>>>  		f2fs_has_inline_xattr(inode))
>>>>>  		F2FS_I(inode)->i_inline_xattr_size = sbi->inline_xattr_size;
>>>>> +	else
>>>>> +		F2FS_I(inode)->i_inline_xattr_size = 0;
>>>>>  
>>>>>  	if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode))
>>>>>  		set_inode_flag(inode, FI_INLINE_DATA);
>>>>> -- 
>>>>> 2.13.1.388.g69e6b9b4f4a9
>>>>
>>>> .
>>>>

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
