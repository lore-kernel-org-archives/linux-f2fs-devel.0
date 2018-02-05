From: guoweichao <guoweichao@huawei.com>
Subject: Re: [PATCH] f2fs: report cp block corrupted
Date: Mon, 5 Feb 2018 10:04:07 +0800
Message-ID: <2c6d21c2-93ed-e06a-b8dc-f92dcd9d88f6@huawei.com>
References: <20180203121253.112629-1-guoweichao@huawei.com>
 <3cdcec19-0a20-d55e-c3a4-85f0564ae457@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <guoweichao@huawei.com>) id 1eiW9J-00060p-M6
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 05 Feb 2018 02:04:49 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eiW9F-0006iE-Ng
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 05 Feb 2018 02:04:49 +0000
In-Reply-To: <3cdcec19-0a20-d55e-c3a4-85f0564ae457@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org, Chao Yu <yuchao0@huawei.com>
Cc: heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net


Hi Chao,
On 2018/2/4 23:16, Chao Yu wrote:
> On 2018/2/3 20:12, Weichao Guo wrote:
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
>> This inconsistency may be found after several reboots long time later
>> and the kernel log about cp block crc invalid has disappeared. This
>> makes the root cause of the inconsistency is hard to locate. Let us
>> separate such other part issues from f2fs logical bugs in debug version.
>>
>> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
>> ---
>>  fs/f2fs/checkpoint.c | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index 512dca8..15baba75 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -730,6 +730,7 @@ static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
>>  	unsigned long blk_size = sbi->blocksize;
>>  	size_t crc_offset = 0;
>>  	__u32 crc = 0;
>> +	int err = 0;
>>
>>  	*cp_page = get_meta_page(sbi, cp_addr);
>>  	*cp_block = (struct f2fs_checkpoint *)page_address(*cp_page);
>> @@ -737,18 +738,22 @@ static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
>>  	crc_offset = le32_to_cpu((*cp_block)->checksum_offset);
>>  	if (crc_offset > (blk_size - sizeof(__le32))) {
>>  		f2fs_msg(sbi->sb, KERN_WARNING,
>> -			"invalid crc_offset: %zu", crc_offset);
>> -		return -EINVAL;
>> +			"invalid crc_offset: %zu at blk_addr: 0x%x",
>> +				crc_offset, cp_addr);
>> +		err = -EINVAL;
>> +		f2fs_bug_on(sbi, 1);
> 
> return -EINVAL?

At first, I just added f2fs_bug_on before return -EINVAL. But the pclint check tools report
unreachable code warnings. It seems that this suggestion should be ignored. I will resend a
new version of this patch.

Thanks,
> 
>>  	}
>>
>>  	crc = cur_cp_crc(*cp_block);
>>  	if (!f2fs_crc_valid(sbi, crc, *cp_block, crc_offset)) {
>> -		f2fs_msg(sbi->sb, KERN_WARNING, "invalid crc value");
>> -		return -EINVAL;
>> +		f2fs_msg(sbi->sb, KERN_WARNING,
>> +			"invalid crc value at blk_addr: 0x%x", cp_addr);
>> +		err = -EINVAL;
>> +		f2fs_bug_on(sbi, 1);
> 
> Ditto,
> 
> Thanks,
> 
>>  	}
>>
>>  	*version = cur_cp_version(*cp_block);
>> -	return 0;
>> +	return err;
>>  }
>>
>>  static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
>> --
>> 2.10.1
>>
>>
>> ------------------------------------------------------------------------------
>> Check out the vibrant tech community on one of the world's most
>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
