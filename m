Return-Path: <SRS0=A+6L=NE=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826C7C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 Aug 2021 01:36:27 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3861960FBF;
	Fri, 13 Aug 2021 01:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3861960FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mEM7V-0003PT-GW; Fri, 13 Aug 2021 01:36:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mEM7U-0003PN-27
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Aug 2021 01:36:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kKTNCgq5+YbGuHfqYciCxXpUM7CnumLqRVu4WrFIHHU=; b=hb+La+XeU6xuGh7mZs7SuBbBDU
 gOZDUO26xRaylzOXlGjHuaXKfu6zJS+/3G61KQAGrTG132Lt0ZLPscyQ8vUsy4qXIetNQVDxg19wI
 D1I4FPK26FbqHKGYklEXCGc/BNz9ibBNPrFEmZ7JHt2zi3Vnyvr0ln/jESNNDOgYBkhY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kKTNCgq5+YbGuHfqYciCxXpUM7CnumLqRVu4WrFIHHU=; b=QUQbdMeV2ja+2k8vcchjJ13XnU
 JvQxvyN5NoC8UlPFuQVmcnTNyOTOKG2Jp3+BUb4+wC+Mc4gzrqmnZ9gYBq8RLyleQrfehkj7NaG5j
 vyw4b8OB5eZdgZ+4t4ClOMWnce/N/Cg3kKA6zZYVkSd0Sf3PCxl7OJ0wyaRG6Wb7aGgg=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mEM7S-004ine-BY
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Aug 2021 01:36:24 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BF7A610A4;
 Fri, 13 Aug 2021 01:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628818576;
 bh=baJNqejVqzZd44v6etDgga14hQrVlPGyofOBsLbrV2E=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=jEkYd60hvmde4R68gll5ftC3TI+a5lYKqBJJim/ZS7zJnZB8ZAWrRxbZqTFaofZ8M
 UFC/w47ygk+4ROEi3Y3g+3y/l0nP2DCqNBfH9p/QQ8xT80kzj/VyvSAr9I4kvrPLmC
 k079RklNGSaxrjNqYHS7HRbXANhsbLxPNBeUAc1pUNa83iAj2dWqGgaIqnyGAV8b8y
 NQw8EiQIAcVZXdwefTs8wscIt2NDkWYJLCfgegRUjwwh6U9JBhGXjniKQnKxMiLiEW
 b/QnXG+DlgxwvSavwUlWFG+QU5NIM7emJWhAJ0bB+MzcD63eLPEchCUvjLC5QlNwBP
 qz9nMrtP6GJ0Q==
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20210729122522.149960-1-changfengnan@vivo.com>
 <9b1f01f4-66ed-3976-3efb-bd5fee347681@kernel.org>
 <YRWPetjv8PqbzzF/@google.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <3b339c10-f4bc-48f4-4c77-84e904dfa9cb@kernel.org>
Date: Fri, 13 Aug 2021 09:36:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRWPetjv8PqbzzF/@google.com>
Content-Language: en-US
X-Headers-End: 1mEM7S-004ine-BY
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix missing inplace count in overwrite
 with direct io
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
Cc: Fengnan Chang <changfengnan@vivo.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/8/13 5:15, Jaegeuk Kim wrote:
> On 08/06, Chao Yu wrote:
>> On 2021/7/29 20:25, Fengnan Chang wrote:
>>> For now, overwrite file with direct io use inplace policy, but not
>>> counted, fix it.
>>
>> IMO, LFS/SSR/IPU stats in debugfs was for buffered write, maybe we
>> need to add separated one for DIO.
> 
> Do we really need to monitor DIO stats?

Similar reason as we did for buffered IO?

Thanks,

> 
>>
>> Jaegeuk, thoughts?
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
>>> ---
>>>    fs/f2fs/data.c | 6 ++++++
>>>    fs/f2fs/f2fs.h | 2 ++
>>>    2 files changed, 8 insertions(+)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index d2cf48c5a2e4..60510acf91ec 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -1477,6 +1477,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>>>    		if (flag == F2FS_GET_BLOCK_DIO)
>>>    			f2fs_wait_on_block_writeback_range(inode,
>>>    						map->m_pblk, map->m_len);
>>> +		if (!f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO &&
>>> +				map->m_may_create)
>>> +			stat_add_inplace_blocks(sbi, map->m_len);
>>>    		goto out;
>>>    	}
>>> @@ -1526,6 +1529,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>>>    			blkaddr = dn.data_blkaddr;
>>>    			set_inode_flag(inode, FI_APPEND_WRITE);
>>>    		}
>>> +		if (!create && !f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO &&
>>> +				map->m_may_create)
>>> +			stat_inc_inplace_blocks(sbi);
>>>    	} else {
>>>    		if (create) {
>>>    			if (unlikely(f2fs_cp_error(sbi))) {
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 867f2c5d9559..3a9df28e6fd7 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -3804,6 +3804,8 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
>>>    		((sbi)->block_count[(curseg)->alloc_type]++)
>>>    #define stat_inc_inplace_blocks(sbi)					\
>>>    		(atomic_inc(&(sbi)->inplace_count))
>>> +#define stat_add_inplace_blocks(sbi, count)				\
>>> +		(atomic_add(count, &(sbi)->inplace_count))
>>>    #define stat_update_max_atomic_write(inode)				\
>>>    	do {								\
>>>    		int cur = F2FS_I_SB(inode)->atomic_files;	\
>>>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
