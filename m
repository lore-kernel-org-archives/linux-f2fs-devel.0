Return-Path: <SRS0=6WiR=KV=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDBFC47082
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 May 2021 15:03:09 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF92613BC;
	Wed, 26 May 2021 15:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF92613BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1llv3p-00009L-S0; Wed, 26 May 2021 15:03:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1llv3p-00009E-0G
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 26 May 2021 15:03:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w/KXvh4P/tJfe3TMp0UtPT9yZvi4ur5VfF+UQ9nwChg=; b=dRKO7/YR9hrsKw1p3PoRdIYc/b
 g08vsINeFBXxdRvRQy4yYpA1qIg2Ww73qArojzkbMHMHmCLsfraqVOk5fQVKr4z3NGiJLDlIZE3Lq
 P8VdZ5zfpzkVjaXRfkrNwblK8ka5kVZsiZJqyj5D/8M5WB8eG4P9Eq1/S7nlKO0q+z5E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=w/KXvh4P/tJfe3TMp0UtPT9yZvi4ur5VfF+UQ9nwChg=; b=AV7Cry0La4MTm80jOu2k+Ypj2c
 f/F5O+U5MXp6G7qto+81cyptckabJerEwlfljtVihfWndL80h8Lm2iEJDcW0AzVWdiohxQ+lHrMKN
 U6TFq+3pM7Uz0gjNQF0/qVThAf8I9otLm8wc8z+EfqNW/Znm/YRg75W3r25eTWt/GnF4=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1llv3j-0005kP-DM
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 26 May 2021 15:03:06 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 857D6613BC;
 Wed, 26 May 2021 15:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622041375;
 bh=ME8zkKRVZO70XmKWmbJmC8KJO/3nsnIkTtNBmvoBI6g=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=OS2ttHJ6yJDUKeJAu7RjjIQTAJpnjG9Cv9QKpD004FLxBALHfCpp/q8wsvbMPPxG8
 ufBdoVC93Wo3BIPzPUGZ+j4qk/rbdCA2UQXmlfhPBPAaVSuED3DCW1jLbSDbZK/CWz
 bEJhcAkvL+N/H98G1TU1vj3Vo7GIGY5LkYAdvuZbVgx6a0ldoSBVimmOBofFkLfXaY
 mtBYBKW466Zoa8VQ1I1QB5n93C6SQYkNUzAR3WBNeSeXlSAAU7yi6NNCDS0r102aMT
 mgHIHnkJx3Jtl6syQeYKPJqfNkSksQfTYbTG+PtzacpTD7LNsLJzjZCd8I83WS7pcn
 QEl89eUZ8lWQQ==
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
References: <20210526062927.52629-1-yuchao0@huawei.com>
 <YK5NXdyjgB6EFY5Q@google.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <e4c1df88-f1f4-99e0-6f83-fa0f3110d737@kernel.org>
Date: Wed, 26 May 2021 23:02:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YK5NXdyjgB6EFY5Q@google.com>
Content-Language: en-US
X-Headers-End: 1llv3j-0005kP-DM
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: swap: remove dead codes
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/5/26 21:30, Jaegeuk Kim wrote:
> On 05/26, Chao Yu wrote:
>> After commit af4b6b8edf6a ("f2fs: introduce check_swap_activate_fast()"),
>> we will never run into original logic of check_swap_activate() before
>> f2fs supports non 4k-sized page, so let's delete those dead codes.
> 
> Why not keeping this for large page support in future maybe?

Well, if so, at that time, it would be better to refactor
check_swap_activate_fast() implementation based on f2fs_map_block() rather
than refactoring check_swap_activate() implementation based on low efficient
bmap()?

Thanks,

> 
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>   fs/f2fs/data.c | 171 +------------------------------------------------
>>   1 file changed, 3 insertions(+), 168 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 3058c7e28b11..9c23fde93b76 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -3830,67 +3830,7 @@ int f2fs_migrate_page(struct address_space *mapping,
>>   #endif
>>   
>>   #ifdef CONFIG_SWAP
>> -static int f2fs_is_file_aligned(struct inode *inode)
>> -{
>> -	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>> -	block_t main_blkaddr = SM_I(sbi)->main_blkaddr;
>> -	block_t cur_lblock;
>> -	block_t last_lblock;
>> -	block_t pblock;
>> -	unsigned long nr_pblocks;
>> -	unsigned int blocks_per_sec = BLKS_PER_SEC(sbi);
>> -	unsigned int not_aligned = 0;
>> -	int ret = 0;
>> -
>> -	cur_lblock = 0;
>> -	last_lblock = bytes_to_blks(inode, i_size_read(inode));
>> -
>> -	while (cur_lblock < last_lblock) {
>> -		struct f2fs_map_blocks map;
>> -
>> -		memset(&map, 0, sizeof(map));
>> -		map.m_lblk = cur_lblock;
>> -		map.m_len = last_lblock - cur_lblock;
>> -		map.m_next_pgofs = NULL;
>> -		map.m_next_extent = NULL;
>> -		map.m_seg_type = NO_CHECK_TYPE;
>> -		map.m_may_create = false;
>> -
>> -		ret = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_FIEMAP);
>> -		if (ret)
>> -			goto out;
>> -
>> -		/* hole */
>> -		if (!(map.m_flags & F2FS_MAP_FLAGS)) {
>> -			f2fs_err(sbi, "Swapfile has holes\n");
>> -			ret = -ENOENT;
>> -			goto out;
>> -		}
>> -
>> -		pblock = map.m_pblk;
>> -		nr_pblocks = map.m_len;
>> -
>> -		if ((pblock - main_blkaddr) & (blocks_per_sec - 1) ||
>> -			nr_pblocks & (blocks_per_sec - 1)) {
>> -			if (f2fs_is_pinned_file(inode)) {
>> -				f2fs_err(sbi, "Swapfile does not align to section");
>> -				ret = -EINVAL;
>> -				goto out;
>> -			}
>> -			not_aligned++;
>> -		}
>> -
>> -		cur_lblock += nr_pblocks;
>> -	}
>> -	if (not_aligned)
>> -		f2fs_warn(sbi, "Swapfile (%u) is not align to section: \n"
>> -			"\t1) creat(), 2) ioctl(F2FS_IOC_SET_PIN_FILE), 3) fallocate()",
>> -			not_aligned);
>> -out:
>> -	return ret;
>> -}
>> -
>> -static int check_swap_activate_fast(struct swap_info_struct *sis,
>> +static int check_swap_activate(struct swap_info_struct *sis,
>>   				struct file *swap_file, sector_t *span)
>>   {
>>   	struct address_space *mapping = swap_file->f_mapping;
>> @@ -3907,6 +3847,8 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
>>   	unsigned int not_aligned = 0;
>>   	int ret = 0;
>>   
>> +	f2fs_bug_on(sbi, PAGE_SIZE != F2FS_BLKSIZE);
>> +
>>   	/*
>>   	 * Map all the blocks into the extent list.  This code doesn't try
>>   	 * to be very smart.
>> @@ -3986,113 +3928,6 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
>>   	return ret;
>>   }
>>   
>> -/* Copied from generic_swapfile_activate() to check any holes */
>> -static int check_swap_activate(struct swap_info_struct *sis,
>> -				struct file *swap_file, sector_t *span)
>> -{
>> -	struct address_space *mapping = swap_file->f_mapping;
>> -	struct inode *inode = mapping->host;
>> -	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>> -	unsigned blocks_per_page;
>> -	unsigned long page_no;
>> -	sector_t probe_block;
>> -	sector_t last_block;
>> -	sector_t lowest_block = -1;
>> -	sector_t highest_block = 0;
>> -	int nr_extents = 0;
>> -	int ret = 0;
>> -
>> -	if (PAGE_SIZE == F2FS_BLKSIZE)
>> -		return check_swap_activate_fast(sis, swap_file, span);
>> -
>> -	ret = f2fs_is_file_aligned(inode);
>> -	if (ret)
>> -		goto out;
>> -
>> -	blocks_per_page = bytes_to_blks(inode, PAGE_SIZE);
>> -
>> -	/*
>> -	 * Map all the blocks into the extent list.  This code doesn't try
>> -	 * to be very smart.
>> -	 */
>> -	probe_block = 0;
>> -	page_no = 0;
>> -	last_block = bytes_to_blks(inode, i_size_read(inode));
>> -	while ((probe_block + blocks_per_page) <= last_block &&
>> -			page_no < sis->max) {
>> -		unsigned block_in_page;
>> -		sector_t first_block;
>> -		sector_t block = 0;
>> -
>> -		cond_resched();
>> -
>> -		block = probe_block;
>> -		ret = bmap(inode, &block);
>> -		if (ret)
>> -			goto out;
>> -		if (!block)
>> -			goto bad_bmap;
>> -		first_block = block;
>> -
>> -		/*
>> -		 * It must be PAGE_SIZE aligned on-disk
>> -		 */
>> -		if (first_block & (blocks_per_page - 1)) {
>> -			probe_block++;
>> -			goto reprobe;
>> -		}
>> -
>> -		for (block_in_page = 1; block_in_page < blocks_per_page;
>> -					block_in_page++) {
>> -
>> -			block = probe_block + block_in_page;
>> -			ret = bmap(inode, &block);
>> -			if (ret)
>> -				goto out;
>> -			if (!block)
>> -				goto bad_bmap;
>> -
>> -			if (block != first_block + block_in_page) {
>> -				/* Discontiguity */
>> -				probe_block++;
>> -				goto reprobe;
>> -			}
>> -		}
>> -
>> -		first_block >>= (PAGE_SHIFT - inode->i_blkbits);
>> -		if (page_no) {	/* exclude the header page */
>> -			if (first_block < lowest_block)
>> -				lowest_block = first_block;
>> -			if (first_block > highest_block)
>> -				highest_block = first_block;
>> -		}
>> -
>> -		/*
>> -		 * We found a PAGE_SIZE-length, PAGE_SIZE-aligned run of blocks
>> -		 */
>> -		ret = add_swap_extent(sis, page_no, 1, first_block);
>> -		if (ret < 0)
>> -			goto out;
>> -		nr_extents += ret;
>> -		page_no++;
>> -		probe_block += blocks_per_page;
>> -reprobe:
>> -		continue;
>> -	}
>> -	ret = nr_extents;
>> -	*span = 1 + highest_block - lowest_block;
>> -	if (page_no == 0)
>> -		page_no = 1;	/* force Empty message */
>> -	sis->max = page_no;
>> -	sis->pages = page_no - 1;
>> -	sis->highest_bit = page_no - 1;
>> -out:
>> -	return ret;
>> -bad_bmap:
>> -	f2fs_err(sbi, "Swapfile has holes\n");
>> -	return -EINVAL;
>> -}
>> -
>>   static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
>>   				sector_t *span)
>>   {
>> -- 
>> 2.29.2


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
