Return-Path: <SRS0=WM5+=KH=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DAAC433B4
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 May 2021 18:02:30 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4DFD61412;
	Wed, 12 May 2021 18:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DFD61412
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lgtBk-0003uB-PS; Wed, 12 May 2021 18:02:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1lgtBj-0003tx-MP
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 12 May 2021 18:02:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WO1hxpIZLoy2PZvR492AVf5BliPCyhS6bFpystoQCT0=; b=gGSpj3GbPg5QeSa7ZLnEqSBnvv
 R1x+VnZ0insz0NJbxpQlIe5tOMQ2akwXhYuY6QK1EE133Nm58BEa6PsNpGt6rMLwOsPs/OG0VJO7u
 KvwBh97U4v1L1h0eD8K0N3sizdSHhdZdO1SgdiMIQLkqb2au6dJWi6OXp4oUYyGG2gN8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WO1hxpIZLoy2PZvR492AVf5BliPCyhS6bFpystoQCT0=; b=ZDX5dYrEINVxHZ6nH8j4hROaGg
 4sNrBHEhIlT67h2+4Y9/wq0oePT6mSF/6cEYzFDDhb0B2cKl7JU0tcqdZPgoNxtZ1uMjoFtMLOKqR
 3mpeA7fiorg192MUUqKqdTaTbHfj/zZiziNAmPUHUqfICJyNLar4RHm+T348B1+9Xuqw=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lgtBb-0003sv-GX
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 12 May 2021 18:02:27 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A799C6143A;
 Wed, 12 May 2021 18:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620842534;
 bh=7DwgLrnohZjPcydKnsR47VZjiVTucTumvxGrzG42tcg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FobJlcNHVBjnA6JhT1VHCwmKPYsSWGeg/aYNsyqaLsfb8NM+pBdE3A7PPEf87oVvN
 BHy97N43NqAlQR++IPJZE/gydzovv83eQimYApkiAqY1S9XxmP+nDrlzsM80vJAr0y
 8m+1maszXMDrwewb1JnKNQwebTr5afK/742snIXg79aldOPxwM3HsFuV7BN0UhmsSF
 JSTrlN++jyrFEgTD125TGYYBwmb70QKBBWhgPNDjWiC2NRVZ7lCTAwyWAK7/MmJP53
 759gN4hEErAxLcmMj13/5X4Fxj8LxpxLhf7/bU/TTG8Qk1RZGPJVlPteQb+Ww/7chf
 YjnSwKHE4BC5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Wed, 12 May 2021 14:01:35 -0400
Message-Id: <20210512180206.664536-5-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512180206.664536-1-sashal@kernel.org>
References: <20210512180206.664536-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Headers-End: 1lgtBb-0003sv-GX
Subject: [f2fs-dev] [PATCH AUTOSEL 5.11 05/35] f2fs: fix to avoid
 out-of-bounds memory access
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
Cc: Sasha Levin <sashal@kernel.org>, butt3rflyh4ck <butterflyhuangxx@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit b862676e371715456c9dade7990c8004996d0d9e ]

butt3rflyh4ck <butterflyhuangxx@gmail.com> reported a bug found by
syzkaller fuzzer with custom modifications in 5.12.0-rc3+ [1]:

 dump_stack+0xfa/0x151 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x82/0x32c mm/kasan/report.c:232
 __kasan_report mm/kasan/report.c:399 [inline]
 kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:416
 f2fs_test_bit fs/f2fs/f2fs.h:2572 [inline]
 current_nat_addr fs/f2fs/node.h:213 [inline]
 get_next_nat_page fs/f2fs/node.c:123 [inline]
 __flush_nat_entry_set fs/f2fs/node.c:2888 [inline]
 f2fs_flush_nat_entries+0x258e/0x2960 fs/f2fs/node.c:2991
 f2fs_write_checkpoint+0x1372/0x6a70 fs/f2fs/checkpoint.c:1640
 f2fs_issue_checkpoint+0x149/0x410 fs/f2fs/checkpoint.c:1807
 f2fs_sync_fs+0x20f/0x420 fs/f2fs/super.c:1454
 __sync_filesystem fs/sync.c:39 [inline]
 sync_filesystem fs/sync.c:67 [inline]
 sync_filesystem+0x1b5/0x260 fs/sync.c:48
 generic_shutdown_super+0x70/0x370 fs/super.c:448
 kill_block_super+0x97/0xf0 fs/super.c:1394

The root cause is, if nat entry in checkpoint journal area is corrupted,
e.g. nid of journalled nat entry exceeds max nid value, during checkpoint,
once it tries to flush nat journal to NAT area, get_next_nat_page() may
access out-of-bounds memory on nat_bitmap due to it uses wrong nid value
as bitmap offset.

[1] https://lore.kernel.org/lkml/CAFcO6XOMWdr8pObek6eN6-fs58KG9doRFadgJj-FnF-1x43s2g@mail.gmail.com/T/#u

Reported-and-tested-by: butt3rflyh4ck <butterflyhuangxx@gmail.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3a24423ac65f..071aa59856aa 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2787,6 +2787,9 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
 		struct f2fs_nat_entry raw_ne;
 		nid_t nid = le32_to_cpu(nid_in_journal(journal, i));
 
+		if (f2fs_check_nid_range(sbi, nid))
+			continue;
+
 		raw_ne = nat_in_journal(journal, i);
 
 		ne = __lookup_nat_cache(nm_i, nid);
-- 
2.30.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
