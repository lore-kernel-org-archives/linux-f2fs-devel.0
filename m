Return-Path: <SRS0=MO+R=IV=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E55C433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 Mar 2021 13:56:40 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5994E6199F;
	Tue, 23 Mar 2021 13:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5994E6199F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lOhWQ-0000Mz-P4; Tue, 23 Mar 2021 13:56:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1lOhWP-0000Mj-SG
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 23 Mar 2021 13:56:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rx9kgaZb+bgnOxaSkCx+gVKC93JmPftdrzb7m++xRDY=; b=VCIwgEyZ2GnmRBMnDfT978PcMq
 pafHcjLxqL5mRjkOOZ1OJ9nO/+zGOMvwVC/Kv4TLfTCN7DmGaGZY0RcKHr4SgxEWmSGXKYIZKj0E5
 1W7P8cXQkkWVU08smxBM9DBlycvgrRb0dhQS0nvIOcGoMPwgUORkl+UmkbHn1CRR8JHg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rx9kgaZb+bgnOxaSkCx+gVKC93JmPftdrzb7m++xRDY=; b=LnB6QaQv104HjEUQCPODOwmBHE
 zIdT7+STl67Mj8PEoEyEjeBHxDJoYusBOI+X2rckpCdly85sOqG5r5653Dhadym9czp4unvh7AdZ0
 13GX/5tp89AtaBI4ghT0iaK+4uUMiOREUJpw5SSr5XPOHlwVvRC+1WYYtGEZYi12Q09U=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lOhWL-001G6X-38
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 23 Mar 2021 13:56:37 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B19C6199F;
 Tue, 23 Mar 2021 13:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616507787;
 bh=8lKy2kI8+VRpgd7UaH5wsraNigVbnf5gjlgvvdBwnBE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=ctFllR8M5ADN0PQZGilMeRK2vxtz2PfkIZU/rB+oJPFpyrze0z1jirtPfRojTZe7E
 K01johJh0sVT0XKGOnU64IktnMSgnZxXU6wiax1/38dRhg6j9LaGsV+yG++7q64tUw
 14WWIO+Jldbd+pHJ1SwnvFwRfEx1aqP6ADIeycO+RrYseD/Nv8OHdh3TwN/IupPFoU
 6kRJOLAcnAsFBY5rNa4gFBXu70qInd+nqc7T2yaYnRG2tfJyzRgngYsW6zq4D/UxLY
 AWmdUbpOuu3HFsgdh5IOBweu2byr8HoJbL/Yv5vkutu2kCphIuxIcoWwgifginyA+H
 kpnt6hN17p83g==
To: jaegeuk@kernel.org
References: <20210305095601.96591-1-yuchao0@huawei.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <d9c118eb-45b3-7f35-70bd-cb016957e6e8@kernel.org>
Date: Tue, 23 Mar 2021 21:56:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210305095601.96591-1-yuchao0@huawei.com>
Content-Language: en-US
X-Headers-End: 1lOhWL-001G6X-38
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to align to section for
 fallocate() on pinned file
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

On 2021/3/5 17:56, Chao Yu wrote:
> Now, fallocate() on a pinned file only allocates blocks which aligns
> to segment rather than section, so GC may try to migrate pinned file's
> block, and after several times of failure, pinned file's block could
> be migrated to other place, however user won't be aware of such
> condition, and then old obsolete block address may be readed/written
> incorrectly.
> 
> To avoid such condition, let's try to allocate pinned file's blocks
> with section alignment.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>

Jaegeuk,

Could you please check and apply below diff into original patch?

---
  fs/f2fs/file.c | 10 +++++-----
  1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 236f3f69681a..24fa68fdcaa0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1648,13 +1648,13 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
  		return 0;

  	if (f2fs_is_pinned_file(inode)) {
-		block_t len = (map.m_len >> sbi->log_blocks_per_seg) <<
-					sbi->log_blocks_per_seg;
+		block_t sec_blks = BLKS_PER_SEC(sbi);
+		block_t len = rounddown(map.m_len, sec_blks);

-		if (map.m_len % sbi->blocks_per_seg)
-			len += sbi->blocks_per_seg;
+		if (map.m_len % sec_blks)
+			len += sec_blks;

-		map.m_len = sbi->blocks_per_seg;
+		map.m_len = sec_blks;
  next_alloc:
  		if (has_not_enough_free_secs(sbi, 0,
  			GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi)))) {
-- 
2.22.1




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
