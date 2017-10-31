From: Sheng Yong <shengyong1@huawei.com>
Subject: Re: [RFC PATCH 7/8] fsck.f2fs: introduce
 sanity_check_inode
Date: Tue, 31 Oct 2017 17:21:19 +0800
Message-ID: <93bd4aa0-f81d-14ba-b5db-c051be4d9f8c@huawei.com>
References: <20171031013824.46544-1-shengyong1@huawei.com>
 <20171031013824.46544-7-shengyong1@huawei.com>
 <c609e8f2-520f-a5ed-8a9e-f624de3cff63@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <shengyong1@huawei.com>)
 id 1e9SnM-0000J4-Rx
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 09:25:16 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e9SnK-0006Ws-Ll
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 09:25:16 +0000
In-Reply-To: <c609e8f2-520f-a5ed-8a9e-f624de3cff63@huawei.com>
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



On 2017/10/31 16:04, Chao Yu wrote:
> On 2017/10/31 9:38, Sheng Yong wrote:
>> f2fs_iget checks if i_mode is valid. If it is not, the file cannot be
>> accessed as well as deleted. To make sure such files can be removed,
>> fsck adds the same check, and removes incorrect inode blocks.
>>
>> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
>> ---
>>   fsck/fsck.c  | 21 +++++++++++++++++++++
>>   fsck/mount.c |  4 ++--
>>   2 files changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/fsck/fsck.c b/fsck/fsck.c
>> index 56a47be..77490d8 100644
>> --- a/fsck/fsck.c
>> +++ b/fsck/fsck.c
>> @@ -458,6 +458,25 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
>>   	return 0;
>>   }
>>   
>> +static int sanity_check_inode(struct f2fs_sb_info *sbi, struct f2fs_node *node)
>> +{
>> +	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
>> +	struct f2fs_inode *fi = &node->i;
>> +
>> +	if (!(le16_to_cpu(fi->i_mode) & S_IFMT)) {
>> +		ASSERT_MSG("i_mode is not valid. [0x%x]", le16_to_cpu(fi->i_mode));
>> +		goto remove_node;
>> +	}
>> +
>> +	return 0;
>> +
>> +remove_node:> +	f2fs_set_bit(le32_to_cpu(node->footer.ino), fsck->nat_area_bitmap);
>> +	fsck->chk.valid_blk_cnt--;
>> +	fsck->chk.valid_node_cnt--;
>> +	return -EINVAL;
>> +}
>> +
>>   static int fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 ino,
>>   					u32 x_nid, u32 *blk_cnt)
>>   {
>> @@ -500,6 +519,8 @@ int fsck_chk_node_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
>>   		goto err;
>>   
>>   	if (ntype == TYPE_INODE) {
>> +		if (sanity_check_inode(sbi, node_blk))
>> +			goto err;
>>   		fsck_chk_inode_blk(sbi, nid, ftype, node_blk, blk_cnt, &ni);
>>   	} else {
>>   		switch (ntype) {
>> diff --git a/fsck/mount.c b/fsck/mount.c
>> index a9cd581..45341bc 100644
>> --- a/fsck/mount.c
>> +++ b/fsck/mount.c
>> @@ -1985,7 +1985,7 @@ void nullify_nat_entry(struct f2fs_sb_info *sbi, u32 nid)
>>   		if (le32_to_cpu(nid_in_journal(journal, i)) == nid) {
>>   			memset(&nat_in_journal(journal, i), 0,
>>   					sizeof(struct f2fs_nat_entry));
>> -			FIX_MSG("Remove nid [0x%x] in nat journal\n", nid);
>> +			FIX_MSG("Remove nid [0x%x] in nat journal", nid);
>>   			return;
>>   		}
>>   	}
>> @@ -2005,7 +2005,7 @@ void nullify_nat_entry(struct f2fs_sb_info *sbi, u32 nid)
>>   	} else {
>>   		memset(&nat_block->entries[entry_off], 0,
>>   					sizeof(struct f2fs_nat_entry));
>> -		FIX_MSG("Remove nid [0x%x] in NAT\n", nid);
>> +		FIX_MSG("Remove nid [0x%x] in NAT", nid);
> 
> How about moving all message printing modification into one patch?
OK. I'll split these changes into different patches :)

thanks,
Sheng
> 
> Thanks,
> 
>>   	}
>>   
>>   	ret = dev_write_block(nat_block, block_addr);
>>
> 
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
