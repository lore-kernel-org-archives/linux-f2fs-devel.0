From: Sheng Yong <shengyong1@huawei.com>
Subject: Re: [PATCH] f2fs: fix potential corruption in area
 before F2FS_SUPER_OFFSET
Date: Mon, 29 Jan 2018 16:39:04 +0800
Message-ID: <1e4eddfb-f62c-4a19-aa72-9dffd48480d6@huawei.com>
References: <20180129080418.33490-1-shengyong1@huawei.com>
 <247cff44-995a-bec0-7482-e0fe475f6dd5@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1eg4yP-0000Ox-L2
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jan 2018 08:39:29 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eg4yN-0007kH-Sn
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jan 2018 08:39:29 +0000
In-Reply-To: <247cff44-995a-bec0-7482-e0fe475f6dd5@huawei.com>
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
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi, Chao

On 2018/1/29 16:27, Chao Yu wrote:
> On 2018/1/29 16:04, Sheng Yong wrote:
>> sb_getblk does not guarantee the buffer head is uptodate. If bh is not
>> uptodate, the data (may be used as boot code) in area before
> 
> Why boot code can be stored into the position f2fs superblock locates?
According to Ext4_Disk_Layout [1], the first 1024 bytes is used to install
boot sectors (may be used by some legacy bootloader, I'm not quite sure :(
> 
> And even we have updated the buffer, we will still commit superblock's
> datas into that buffer, boot code can be messed up anyway, right?
The first 1024 bytes are all set to 0 by mkfs, while __f2fs_commit_super only
updates bh->b_data from F2FS_SUPER_OFFSET, but not the whole 4KB area. If the
buffer head is not read from super block (4KB), there is a chance it may get
messed up.

Thanks,
Sheng
> 

[1] https://ext4.wiki.kernel.org/index.php/Ext4_Disk_Layout
> Thanks,
> 
>> F2FS_SUPER_OFFSET may get corrupted when super block is committed.
>>
>> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
>> ---
>>   fs/f2fs/super.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 8173ae688814..7def48cb2b22 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -2334,7 +2334,7 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
>>   	}
>>   
>>   	/* write back-up superblock first */
>> -	bh = sb_getblk(sbi->sb, sbi->valid_super_block ? 0: 1);
>> +	bh = sb_bread(sbi->sb, sbi->valid_super_block ? 0 : 1);
>>   	if (!bh)
>>   		return -EIO;
>>   	err = __f2fs_commit_super(bh, F2FS_RAW_SUPER(sbi));
>> @@ -2345,7 +2345,7 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
>>   		return err;
>>   
>>   	/* write current valid superblock */
>> -	bh = sb_getblk(sbi->sb, sbi->valid_super_block);
>> +	bh = sb_bread(sbi->sb, sbi->valid_super_block);
>>   	if (!bh)
>>   		return -EIO;
>>   	err = __f2fs_commit_super(bh, F2FS_RAW_SUPER(sbi));
>>
> 
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
