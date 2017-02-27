From: Kinglong Mee <kinglongmee@gmail.com>
Subject: Re: [PATCH 3/3] f2fs: drop calling alloc_nid_failed when
 no nid is allocated
Date: Mon, 27 Feb 2017 11:08:47 +0800
Message-ID: <bd012d3e-e8c1-60c9-46d6-0d0c156c49e2@gmail.com>
References: <77d8220f-8cf4-0af4-3390-cd28fbeb6437@gmail.com>
	<e1626669-e3bb-c2a4-f8bd-5b882332b033@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1ciBgY-00073O-NM
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 03:09:14 +0000
Received: from mail-io0-f194.google.com ([209.85.223.194])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ciBgW-0002Pq-El
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 03:09:14 +0000
Received: by mail-io0-f194.google.com with SMTP id v13so4727476iov.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sun, 26 Feb 2017 19:09:12 -0800 (PST)
In-Reply-To: <e1626669-e3bb-c2a4-f8bd-5b882332b033@huawei.com>
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

On 2/27/2017 10:21, Chao Yu wrote:
> On 2017/2/25 19:23, Kinglong Mee wrote:
>> If hsize is less than or equal to inlien_size, and i_xattr_nid is valid, 
>> the new_nid is not allocated (no alloc_nid is called).
>>
>>        if (hsize > inline_size && !F2FS_I(inode)->i_xattr_nid)
>>                 if (!alloc_nid(sbi, &new_nid))
>>                         return -ENOSPC;
>>
>> Although it's harmless calling alloc_nid_failed, it's better drop them.
>>
>> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
>> ---
>>  fs/f2fs/xattr.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
>> index 7298a44..fd9dc99 100644
>> --- a/fs/f2fs/xattr.c
>> +++ b/fs/f2fs/xattr.c
>> @@ -428,19 +428,18 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
>>  		/* no need to use xattr node block */
>>  		if (hsize <= inline_size) {
>>  			err = truncate_xattr_node(inode, ipage);
>> -			alloc_nid_failed(sbi, new_nid);
> 
> Should keep this since new_nid was assigned above?

alloc_nid is called when, 


403         if (hsize > inline_size && !F2FS_I(inode)->i_xattr_nid)
404                 if (!alloc_nid(sbi, &new_nid))
405                         return -ENOSPC;

if (hsize <= inline_size), alloc_nid isn't called.

thanks,
Kinglong Mee
> 
>> +			f2fs_bug_on(sbi, new_nid);
>>  			return err;
>>  		}
>>  	}
>>  
>>  	/* write to xattr node block */
>>  	if (F2FS_I(inode)->i_xattr_nid) {
>> +		f2fs_bug_on(sbi, new_nid);
>>  		xpage = get_node_page(sbi, F2FS_I(inode)->i_xattr_nid);
>> -		if (IS_ERR(xpage)) {
>> -			alloc_nid_failed(sbi, new_nid);
>> +		if (IS_ERR(xpage))
>>  			return PTR_ERR(xpage);
>> -		}
>> -		f2fs_bug_on(sbi, new_nid);
> 
> Cleanup here looks good to me.
> 
> Thanks,
> 
>> +
>>  		f2fs_wait_on_page_writeback(xpage, NODE, true);
>>  	} else {
>>  		struct dnode_of_data dn;
>>
> 
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
