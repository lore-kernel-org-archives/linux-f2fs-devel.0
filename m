From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: handle error case when adding xattr
 entry
Date: Wed, 18 Oct 2017 09:47:42 +0800
Message-ID: <de3db7b8-51cf-08be-1117-af08bf87a55e@huawei.com>
References: <20171016230642.94228-1-jaegeuk@kernel.org>
 <cfca102c-fcd9-4d43-80a7-1684a59f5e95@kernel.org>
 <20171017164154.GA5509@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e4dUE-0000qb-UF
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 Oct 2017 01:49:34 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e4dUC-0003ao-Mk
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 Oct 2017 01:49:34 +0000
In-Reply-To: <20171017164154.GA5509@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/10/18 0:41, Jaegeuk Kim wrote:
> On 10/17, Chao Yu wrote:
>> On 2017/10/17 7:06, Jaegeuk Kim wrote:
>>> This patch fixes recovering incomplete xattr entries remaining in inline xattr
>>> and xattr block, caused by any kind of errors.
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/xattr.c | 48 ++++++++++++++++++++++++++++--------------------
>>>  1 file changed, 28 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
>>> index e74a4d7f744a..5a9c5e6ad714 100644
>>> --- a/fs/f2fs/xattr.c
>>> +++ b/fs/f2fs/xattr.c
>>> @@ -389,10 +389,11 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
>>>  {
>>>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>  	size_t inline_size = inline_xattr_size(inode);
>>> -	void *xattr_addr;
>>> +	struct page *in_page = NULL;
>>> +	void *xattr_addr, *inline_addr;
>>>  	struct page *xpage;
>>>  	nid_t new_nid = 0;
>>> -	int err;
>>> +	int err = 0;
>>>  
>>>  	if (hsize > inline_size && !F2FS_I(inode)->i_xattr_nid)
>>>  		if (!alloc_nid(sbi, &new_nid))
>>> @@ -400,30 +401,30 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
>>>  
>>>  	/* write to inline xattr */
>>>  	if (inline_size) {
>>> -		struct page *page = NULL;
>>> -		void *inline_addr;
>>> -
>>>  		if (ipage) {
>>>  			inline_addr = inline_xattr_addr(inode, ipage);
>>> -			f2fs_wait_on_page_writeback(ipage, NODE, true);
>>> -			set_page_dirty(ipage);
>>>  		} else {
>>> -			page = get_node_page(sbi, inode->i_ino);
>>> -			if (IS_ERR(page)) {
>>> +			in_page = get_node_page(sbi, inode->i_ino);
>>> +			if (IS_ERR(in_page)) {
>>>  				alloc_nid_failed(sbi, new_nid);
>>> -				return PTR_ERR(page);
>>> +				return PTR_ERR(in_page);
>>>  			}
>>> -			inline_addr = inline_xattr_addr(inode, page);
>>> -			f2fs_wait_on_page_writeback(page, NODE, true);
>>> +			inline_addr = inline_xattr_addr(inode, in_page);
>>>  		}
>>> -		memcpy(inline_addr, txattr_addr, inline_size);
>>> -		f2fs_put_page(page, 1);
>>>  
>>> +		f2fs_wait_on_page_writeback(ipage ? ipage : in_page,
>>> +							NODE, true);
>>>  		/* no need to use xattr node block */
>>>  		if (hsize <= inline_size) {
>>>  			err = truncate_xattr_node(inode, ipage);
>>
>> truncate_xattr_node(inode, ipage ? ipage : in_page);
> 
> No, that should be ipage.

I just noted that dn.inode_page_locked in truncate_xattr_node will be set wrong,
but, anyway, it looks that won't be problem because we didn't use inode_page_locked
later.

There is no more users of ipage in truncate_xattr_node, so no matter we passing,
there will be safe for us, right?

Thanks,

> 
> Thanks,
> 
>> Please add:
>>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>
>> Thanks,
>>
>>>  			alloc_nid_failed(sbi, new_nid);
>>> -			return err;
>>> +			if (err) {
>>> +				f2fs_put_page(in_page, 1);
>>> +				return err;
>>> +			}
>>> +			memcpy(inline_addr, txattr_addr, inline_size);
>>> +			set_page_dirty(ipage ? ipage : in_page);
>>> +			goto in_page_out;
>>>  		}
>>>  	}
>>>  
>>> @@ -432,7 +433,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
>>>  		xpage = get_node_page(sbi, F2FS_I(inode)->i_xattr_nid);
>>>  		if (IS_ERR(xpage)) {
>>>  			alloc_nid_failed(sbi, new_nid);
>>> -			return PTR_ERR(xpage);
>>> +			goto in_page_out;
>>>  		}
>>>  		f2fs_bug_on(sbi, new_nid);
>>>  		f2fs_wait_on_page_writeback(xpage, NODE, true);
>>> @@ -442,17 +443,24 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
>>>  		xpage = new_node_page(&dn, XATTR_NODE_OFFSET);
>>>  		if (IS_ERR(xpage)) {
>>>  			alloc_nid_failed(sbi, new_nid);
>>> -			return PTR_ERR(xpage);
>>> +			goto in_page_out;
>>>  		}
>>>  		alloc_nid_done(sbi, new_nid);
>>>  	}
>>> -
>>>  	xattr_addr = page_address(xpage);
>>> +
>>> +	if (inline_size)
>>> +		memcpy(inline_addr, txattr_addr, inline_size);
>>>  	memcpy(xattr_addr, txattr_addr + inline_size, VALID_XATTR_BLOCK_SIZE);
>>> +
>>> +	if (inline_size)
>>> +		set_page_dirty(ipage ? ipage : in_page);
>>>  	set_page_dirty(xpage);
>>> -	f2fs_put_page(xpage, 1);
>>>  
>>> -	return 0;
>>> +	f2fs_put_page(xpage, 1);
>>> +in_page_out:
>>> +	f2fs_put_page(in_page, 1);
>>> +	return err;
>>>  }
>>>  
>>>  int f2fs_getxattr(struct inode *inode, int index, const char *name,
>>>
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
