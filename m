From: "Tiezhu Yang" <kernelpatch@126.com>
Subject: Re: [PATCH] f2fs: introduce get_checkpoint_version for
	cleanup
Date: Tue, 27 Sep 2016 06:26:39 +0800 (CST)
Message-ID: <511a76a6.78e.157689b6eac.Coremail.kernelpatch@126.com>
References: <628ee378.2f42.15760c102b3.Coremail.kernelpatch@126.com>
	<20160926185716.GC33149@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kernelpatch@126.com>) id 1boeMr-0005Sl-Qz
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Sep 2016 22:27:21 +0000
Received: from m15-36.126.com ([220.181.15.36])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1boeMp-0001Q3-Pi for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Sep 2016 22:27:21 +0000
In-Reply-To: <20160926185716.GC33149@jaegeuk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

At 2016-09-27 02:57:16, "Jaegeuk Kim" <jaegeuk@kernel.org> wrote:
>Hi Tiezhu,
>
>On Sun, Sep 25, 2016 at 05:50:44PM +0800, Tiezhu Yang wrote:
>> There exists almost same codes when get the value of pre_version
>> and cur_version in function validate_checkpoint, this patch adds
>> get_checkpoint_version to clean up redundant codes.
>> 
>> Signed-off-by: Tiezhu Yang <kernelpatch@126.com>
>> ---
>>  fs/f2fs/checkpoint.c | 52 ++++++++++++++++++++++++++++------------------------
>>  1 file changed, 28 insertions(+), 24 deletions(-)
>> 
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index a655d75..facede2 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -666,45 +666,49 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
>>  	}
>>  }
>>  
>> -static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
>> -				block_t cp_addr, unsigned long long *version)
>> +static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
>> +			struct f2fs_checkpoint *cp_block, struct page *cp_page,
>> +			unsigned long long *version)
>>  {
>> -	struct page *cp_page_1, *cp_page_2 = NULL;
>>  	unsigned long blk_size = sbi->blocksize;
>> -	struct f2fs_checkpoint *cp_block;
>> -	unsigned long long cur_version = 0, pre_version = 0;
>> -	size_t crc_offset;
>> +	size_t crc_offset = 0;
>>  	__u32 crc = 0;
>>  
>> -	/* Read the 1st cp block in this CP pack */
>> -	cp_page_1 = get_meta_page(sbi, cp_addr);
>> +	cp_page = get_meta_page(sbi, cp_addr);
>> +	cp_block = (struct f2fs_checkpoint *)page_address(cp_page);
>>  
>> -	/* get the version number */
>> -	cp_block = (struct f2fs_checkpoint *)page_address(cp_page_1);
>>  	crc_offset = le32_to_cpu(cp_block->checksum_offset);
>>  	if (crc_offset >= blk_size)
>> -		goto invalid_cp1;
>> +		return -1;
>
>How about using -EINVAL with a kernel message?

OK, thanks for your suggestion, I will send a v2 patch.

Thanks,
>
>>  
>>  	crc = le32_to_cpu(*((__le32 *)((unsigned char *)cp_block + crc_offset)));
>>  	if (!f2fs_crc_valid(sbi, crc, cp_block, crc_offset))
>> -		goto invalid_cp1;
>> +		return -1;
>
>ditto.
>
>> -	pre_version = cur_cp_version(cp_block);
>> +	*version = cur_cp_version(cp_block);
>> +	return 0;
>> +}
>>  
>> -	/* Read the 2nd cp block in this CP pack */
>> -	cp_addr += le32_to_cpu(cp_block->cp_pack_total_block_count) - 1;
>> -	cp_page_2 = get_meta_page(sbi, cp_addr);
>> +static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
>> +				block_t cp_addr, unsigned long long *version)
>> +{
>> +	struct page *cp_page_1 = NULL, *cp_page_2 = NULL;
>> +	struct f2fs_checkpoint *cp_block = NULL;
>> +	unsigned long long cur_version = 0, pre_version = 0;
>> +	int ret = 0;
>
>	int err;
>
>>  
>> -	cp_block = (struct f2fs_checkpoint *)page_address(cp_page_2);
>> -	crc_offset = le32_to_cpu(cp_block->checksum_offset);
>> -	if (crc_offset >= blk_size)
>> -		goto invalid_cp2;
>> +	ret = get_checkpoint_version(sbi, cp_addr, cp_block,
>> +					cp_page_1, version);
>> +	if (ret == -1)
>
>	if (err)
>
>> +		goto invalid_cp1;
>> +	pre_version = *version;
>>  
>> -	crc = le32_to_cpu(*((__le32 *)((unsigned char *)cp_block + crc_offset)));
>> -	if (!f2fs_crc_valid(sbi, crc, cp_block, crc_offset))
>> +	cp_addr += le32_to_cpu(cp_block->cp_pack_total_block_count) - 1;
>> +	ret = get_checkpoint_version(sbi, cp_addr, cp_block,
>> +					cp_page_2, version);
>> +	if (ret == -1)
>
>	if (err)
>
>>  		goto invalid_cp2;
>> -
>> -	cur_version = cur_cp_version(cp_block);
>> +	cur_version = *version;
>>  
>>  	if (cur_version == pre_version) {
>>  		*version = cur_version;
>> -- 
>> 1.8.3.1
------------------------------------------------------------------------------
