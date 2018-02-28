From: guoweichao <guoweichao@huawei.com>
Subject: Re: [PATCH] f2fs: report cp block corrupted & add a
 backup of cp2
Date: Wed, 28 Feb 2018 20:33:00 +0800
Message-ID: <31b51255-b868-fc17-b0da-077ef82a5b5c@huawei.com>
References: <20180226154429.3292-1-guoweichao@huawei.com>
 <20180228045735.GB81737@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <guoweichao@huawei.com>) id 1er0vQ-001UQ3-6B
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Feb 2018 12:33:36 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1er0vN-007tXF-VB
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Feb 2018 12:33:36 +0000
In-Reply-To: <20180228045735.GB81737@jaegeuk-macbookpro.roam.corp.google.com>
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
Cc: heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

On 2018/2/28 12:57, Jaegeuk Kim wrote:
> On 02/26, Weichao Guo wrote:
>> There is a potential inconsistent metadata case due to a cp block
>> crc invalid in the latest checkpoint caused by hardware issues:
>> 1) write nodes into segment x;
>> 2) write checkpoint A;
>> 3) remove nodes in segment x;
>> 4) write checkpoint B;
>> 5) issue discard or write datas into segment x;
>> 6) sudden power-cut;
>> 7) use checkpoint A after reboot as checkpoint B is invalid
>>
>> This inconsistency may be found after several reboots long time
>> later and the kernel log about cp block crc invalid has disappeared.
>> This makes the root cause of the inconsistency is hard to locate.
>> Let us separate such other part issues from f2fs logical bugs in
>> debug version, and try to validate the checkpoint with the backup
>> when cp2 is corrupted.
> 
> How can you guarantee it happened caused by real power-cut during checkpoint?
it is caused by system panic or SPO before or during checkpoint and a cp block
corrupted when rebooting. 
> Does it really make sense to write addition block at every checkpoint?
My purpose of adding a backup is to distinguish a real corrupted cp block
and other blocks in checkpoint when crc invalid is reported.
Anyway, adding a third CP block is a little tricky. Forget it.

IMO, protecting the whole checkpoint with crc and parity methods should be
an enhancement for F2FS stability.

Thanks,
Weichao
> 
>>
>> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
>> ---
>>  fs/f2fs/checkpoint.c | 27 +++++++++++++++++++++++----
>>  1 file changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index 512dca8..81c4acd 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -761,15 +761,29 @@ static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
>>  
>>  	err = get_checkpoint_version(sbi, cp_addr, &cp_block,
>>  					&cp_page_1, version);
>> -	if (err)
>> +	if (err) {
>> +		f2fs_msg(sbi->sb, KERN_WARNING,
>> +			"corrupted cp1 at blk_addr: 0x%x", cp_addr);
>> +		f2fs_bug_on(sbi, 1);
>>  		goto invalid_cp1;
>> +	}
>>  	pre_version = *version;
>>  
>>  	cp_addr += le32_to_cpu(cp_block->cp_pack_total_block_count) - 1;
>>  	err = get_checkpoint_version(sbi, cp_addr, &cp_block,
>>  					&cp_page_2, version);
>> -	if (err)
>> -		goto invalid_cp2;
>> +	if (err) {
>> +		err = get_checkpoint_version(sbi, cp_addr + 1, &cp_block,
>> +							&cp_page_2, version);
>> +		if (err) {
>> +			goto invalid_cp2;
>> +		}
>> +		else if (*version == pre_version) {
>> +			f2fs_msg(sbi->sb, KERN_WARNING,
>> +				"corrupted cp2 at blk_addr: 0x%x", cp_addr);
>> +			f2fs_bug_on(sbi, 1);
>> +		}
>> +	}
>>  	cur_version = *version;
>>  
>>  	if (cur_version == pre_version) {
>> @@ -1302,7 +1316,12 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>  	}
>>  
>>  	/* writeout checkpoint block */
>> -	update_meta_page(sbi, ckpt, start_blk);
>> +	update_meta_page(sbi, ckpt, start_blk++);
>> +	/* writeout a backup of cp2 if available */
>> +	if (!enabled_nat_bits(sbi, cpc) ||
>> +		(ckpt->cp_pack_total_block_count + 1 <=
>> +			sbi->blocks_per_seg - NM_I(sbi)->nat_bits_blocks))
>> +		update_meta_page(sbi, ckpt, start_blk);
>>  
>>  	/* wait for previous submitted node/meta pages writeback */
>>  	wait_on_all_pages_writeback(sbi);
>> -- 
>> 2.10.1
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
