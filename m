Return-Path: <SRS0=tUrj=AA=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AD0C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 19 Jun 2020 02:48:40 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A5520776;
	Fri, 19 Jun 2020 02:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="mB3QzZE7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="hN32WXZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A5520776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jm756-0004eA-5l; Fri, 19 Jun 2020 02:48:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jm755-0004e3-5W
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Jun 2020 02:48:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r/rGgoONKt0zGhx61U8mdVRYgg+z4TVVtvsAF9oixL4=; b=mB3QzZE76fDbAiUT2bpX/sndYu
 mmZgwmTbSf/j4GlygclxVL7eEsm7eQFnl0QBjznZM8mc6wt/wcClUMRtEA5lDgzFfxjn0ptnpgT1U
 7fuR3iMyYhH+xt3uC1PTqZHlM1YIBAs6Fn7VbobdvroiU0V27QXGIT2GEqnNc2gQokBc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=r/rGgoONKt0zGhx61U8mdVRYgg+z4TVVtvsAF9oixL4=; b=hN32WXZTZftJAscEIEUZm4fmBu
 2lf/dp8kDuQeUW3eLyOKWvPL4Mp7MeCkoCUB9XCBHegGrGfh8TWgDTWKEc/bwBYkeERtDEYO8Ks0n
 s+oyS1akcfgxnJyiJ0trwR/wm0/if3ETjDgT5naCAJT8GiP6AZ1fedNAA+hUC8n8UQp4=;
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jm752-009RUl-RP
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Jun 2020 02:48:39 +0000
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 91C94DE41C02577A07ED;
 Fri, 19 Jun 2020 10:48:20 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 19 Jun
 2020 10:48:16 +0800
To: Zac <zhaowuyun@wingtech.com>, <jaegeuk@kernel.org>
References: <1592484487-12072-1-git-send-email-zhaowuyun@wingtech.com>
 <4a2d19c4-1ede-0172-fe50-c8464ee341df@huawei.com>
 <000001d645e0$4aa645d0$dff2d170$@wingtech.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <ffcc8474-f2af-1934-9219-f4de6757e4a7@huawei.com>
Date: Fri, 19 Jun 2020 10:48:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <000001d645e0$4aa645d0$dff2d170$@wingtech.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1jm752-009RUl-RP
Subject: Re: [f2fs-dev] =?utf-8?b?5Zue5aSNOiBbUEFUQ0hdIGYyZnMtdG9vbHM6IHNl?=
 =?utf-8?q?t_cold_flag_for_non-dir_node?=
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/6/19 10:21, Zac wrote:
>> On 2020/6/18 20:48, zhaowuyun@wingtech.com wrote:
>>> From: Wuyun Zhao <zhaowuyun@wingtech.com>
>>
>> Thanks for the patch. :)
>>
>> Please add commit message here.
> 
> OK
> 
>>>
>>> Signed-off-by: Wuyun Zhao <zhaowuyun@wingtech.com>
>>> ---
>>>  fsck/dir.c  |  1 +
>>>  fsck/node.c |  1 +
>>>  fsck/node.h | 11 +++++++++++
>>>  3 files changed, 13 insertions(+)
>>>
>>> diff --git a/fsck/dir.c b/fsck/dir.c
>>> index 5f4f75e..dc03c98 100644
>>> --- a/fsck/dir.c
>>> +++ b/fsck/dir.c
>>> @@ -522,6 +522,7 @@ static void init_inode_block(struct f2fs_sb_info
>> *sbi,
>>>  	node_blk->footer.nid = cpu_to_le32(de->ino);
>>>  	node_blk->footer.flag = 0;
>>>  	node_blk->footer.cp_ver = ckpt->checkpoint_ver;
>>> +	set_cold_node(node_blk, S_ISDIR(mode));
>>>
>>>  	if (S_ISDIR(mode)) {
>>>  		make_empty_dir(sbi, node_blk);
>>> diff --git a/fsck/node.c b/fsck/node.c
>>> index 229a99c..1d291ca 100644
>>> --- a/fsck/node.c
>>> +++ b/fsck/node.c
>>> @@ -79,6 +79,7 @@ block_t new_node_block(struct f2fs_sb_info *sbi,
>>>  	node_blk->footer.ino = f2fs_inode->footer.ino;
>>>  	node_blk->footer.flag = cpu_to_le32(ofs << OFFSET_BIT_SHIFT);
>>>  	node_blk->footer.cp_ver = ckpt->checkpoint_ver;
>>> +	set_cold_node(node_blk, S_ISDIR(le16_to_cpu(f2fs_inode->i.i_mode)));
>>
>> How about wrapping these node footer fields assignment into a function?
>> then
>> we can reuse this in other places.
>>
>> void set_node_footer(nid, ino, ofs, ver, is_dir)
>> {
>> 	node_blk->footer.nid = cpu_to_le32(nid);
>> 	node_blk->footer.ino = f2fs_inode->footer.ino;
>> 	node_blk->footer.flag = cpu_to_le32(ofs << OFFSET_BIT_SHIFT);
>> 	node_blk->footer.cp_ver = ckpt->checkpoint_ver;
>> 	set_cold_node(node_blk, S_ISDIR(le16_to_cpu(f2fs_inode->i.i_mode)));
>> }
> 
> Ok, That's good.
> 
>>>
>>>  	type = CURSEG_COLD_NODE;
>>>  	if (IS_DNODE(node_blk)) {
>>> diff --git a/fsck/node.h b/fsck/node.h
>>> index 6bce1fb..99139b1 100644
>>> --- a/fsck/node.h
>>> +++ b/fsck/node.h
>>> @@ -161,6 +161,17 @@ static inline int is_node(struct f2fs_node
>> *node_blk, int type)
>>>  	return le32_to_cpu(node_blk->footer.flag) & (1 << type);
>>>  }
>>
>> Beside this, I think we need to use set_node_footer() in:
>> - f2fs_write_root_inode
>> - f2fs_write_qf_inode
>> - f2fs_write_lpf_inode
>>
>> as well to fix mkfs bugs.
> 
> the root inode and the lpf inode is dir, need to set cold flag? 

No, but it is worth to use set_node_footer(..., is_dir:true) for cleanup.

Thanks,

> 
>> Thanks,
>>
>>>
>>> +static inline void set_cold_node(struct f2fs_node *rn, bool is_dir)
>>> +{
>>> +	unsigned int flag = le32_to_cpu(rn->footer.flag);
>>> +
>>> +	if (is_dir)
>>> +		flag &= ~(0x1 << COLD_BIT_SHIFT);
>>> +	else
>>> +		flag |= (0x1 << COLD_BIT_SHIFT);
>>> +	rn->footer.flag = cpu_to_le32(flag);
>>> +}
>>> +
>>>  #define is_fsync_dnode(node_blk)	is_node(node_blk, FSYNC_BIT_SHIFT)
>>>  #define is_dent_dnode(node_blk)		is_node(node_blk,
>> DENT_BIT_SHIFT)
>>>
>>>
> 
> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
