From: heyunlei <heyunlei@huawei.com>
Subject: Re: [PATCH] f2fs: update inode info to inode page for
 new file
Date: Thu, 4 Jan 2018 01:54:32 +0000
Message-ID: <42B685BFA705F94C860C6DD0752F056548304133@DGGEMA503-MBX.china.huawei.com>
References: <1514973784-16037-1-git-send-email-heyunlei@huawei.com>
 <20180103214410.GE30014@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1eWuk5-0003dl-0N
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Jan 2018 01:54:49 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187] helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eWuk3-0001Y2-GZ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Jan 2018 01:54:48 +0000
In-Reply-To: <20180103214410.GE30014@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: zh-CN
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: "Jianing (Euler)" <ning.jia@huawei.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>



>-----Original Message-----
>From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
>Sent: Thursday, January 04, 2018 5:44 AM
>To: heyunlei
>Cc: Yuchao (T); linux-f2fs-devel@lists.sourceforge.net; Wangbintian; Jianing (Euler)
>Subject: Re: [f2fs-dev][PATCH] f2fs: update inode info to inode page for new file
>
>On 01/03, Yunlei He wrote:
>> 			|
>> 			| 1. creat a new file A ,(with dirty inode
>> 			|    && dirty inode page && xattr info)
>> 			| 2. backgroud wb write back file A inode
>> 	last checkpoint	|    page (without update from inode cache)
>
>f2fs_sync_inode_meta() would flush dirty inode cache, no?

f2fs_sync_inode_meta() would flush dirty inode cache in write new checkpoint.
But here bdi flusher would write back zero inode page without update from inode cache.

Thanks.

>
>
>> 			| 3. fsync file A, write back inode page of
>> 			|    file A with inode cache info
>> 			| 4. sudden power off before new checkpoint
>>
>> In this case, recovery process will try to recover a zero inode
>> page. Inline xattr flag of file A will be miss and xattr info
>> will be taken as blkaddr index.
>>
>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>> ---
>>  fs/f2fs/dir.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
>> index 724304d..d04dcac 100644
>> --- a/fs/f2fs/dir.c
>> +++ b/fs/f2fs/dir.c
>> @@ -427,6 +427,8 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
>>  			remove_orphan_inode(F2FS_I_SB(dir), inode->i_ino);
>>  		f2fs_i_links_write(inode, true);
>>  	}
>> +
>> +	update_inode(inode, page);
>>  	return page;
>>
>>  put_error:
>> --
>> 1.9.1

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
