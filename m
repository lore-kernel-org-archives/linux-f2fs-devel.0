Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6B2C36014
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Apr 2025 08:05:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzt6F-0000Hd-L8;
	Wed, 02 Apr 2025 08:05:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yohan.joung@sk.com>) id 1tzt6E-0000HV-Pv
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Apr 2025 08:05:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GSKkRupSlXl61Hp8fOhX2ezigD5ghY5TUcW/55pRDVw=; b=Xn0C/hVBVyLNASWIGxc6FTO3LF
 3QETpr6nxLGyF95nJwtFN53GO9NQaDpK5wiuXAa0N70PSTokNW4M5S/uxBpdo7PDE4uQYmksMrldz
 M8B4VXx8r3PU23KBTW6kAwwjxz191mqlXg3wsjxSinnWdw2nh67I1wcy65ZTtgc8dsio=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GSKkRupSlXl61Hp8fOhX2ezigD5ghY5TUcW/55pRDVw=; b=A
 M2Rud0R6zgxbADBiX/kpREY06rN4hwJSjir6FRnNzyLJX1S+A+0zjLKVoVr8y3xLv7eFTMH8nZRZj
 9JGfE7SHjfzh4XUeREUk9oNzrVgUlN5rjZmzlnNjpZRs19A7OWDlRdtmdZXbwfq3TuHJ+D48Nf6BU
 vOC6avSDbAhOrMJ8=;
Received: from exvmail3.hynix.com ([166.125.252.90] helo=invmail3.skhynix.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtp (Exim 4.95)
 id 1tzt5y-0005ma-B6 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Apr 2025 08:05:26 +0000
X-AuditID: a67dfc59-03fff7000000aab6-0c-67ecefaf0c8d
From: "yohan.joung" <yohan.joung@sk.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Wed,  2 Apr 2025 17:04:27 +0900
Message-ID: <20250402080428.2811-1-yohan.joung@sk.com>
X-Mailer: git-send-email 2.49.0.windows.1
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjluLIzCtJLcpLzFFi42LhesuzUHf9+zfpBpu3K1mcnnqWyeLJ+lnM
 FpcWuVtc3jWHzYHFY9OqTjaP3Qs+M3l83iQXwBzFZZOSmpNZllqkb5fAlfF+3wO2gp28FWvP
 1zcwLuHuYuTgkBAwkbjzTLeLkRPM/HP2JiuIzSagIfGnt5cZxBYR0JQ40jmTHcRmFiiT2PPn
 CAuILSwQL/GxeyFYDYuAqsSH2c/B4rwCZhKf+nexQMzUlNjx5TwTRFxQ4uTMJywQc+QlmrfO
 BurlAqq5yioxd95iNogGSYmDK26wTGDknYWkZxaSngWMTKsYRTLzynITM3OM9YqzMyrzMiv0
 kvNzNzECQ2lZ7Z/IHYzfLgQfYhTgYFTi4W3gfZMuxJpYVlyZe4hRgoNZSYS36CxQiDclsbIq
 tSg/vqg0J7X4EKM0B4uSOK/Rt/IUIYH0xJLU7NTUgtQimCwTB6dUA+PMfccDBD+7hz4tFru9
 5EyTiiNHwE/F4Hl7jAQeNGyPSXXaXP9w3VqnQM5N5RoX9sScM9YqlUv8U3h9l4IE82YJ46PN
 jKduSYUFvmP//Xfr5tcq26f1K/zWkF+S0VhSND/+Kq9hblLA5wmPf+zX2+I8J0lPt/7VtcfS
 ZVGCfkYVvcdjXKrzNymxFGckGmoxFxUnAgCDhX/zIQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBJMWRmVeSWpSXmKPExsXCNUNlju7692/SDdZdl7I4PfUsk8WT9bOY
 LS4tcre4vGsOm8WEuVeZLN5vvcfowOaxaVUnm8fuBZ+ZPL7d9vD4vEkugCWKyyYlNSezLLVI
 3y6BK+P9vgdsBTt5K9aer29gXMLdxcjJISFgIvHn7E1WEJtNQEPiT28vM4gtIqApcaRzJjuI
 zSxQJrHnzxEWEFtYIF7iY/dCsBoWAVWJD7Ofg8V5BcwkPvXvYoGYqSmx48t5Joi4oMTJmU9Y
 IObISzRvnc08gZFrFpLULCSpBYxMqxhFMvPKchMzc8z0irMzKvMyK/SS83M3MQLDY1ntn0k7
 GL9ddj/EKMDBqMTD28D7Jl2INbGsuDL3EKMEB7OSCG/RWaAQb0piZVVqUX58UWlOavEhRmkO
 FiVxXq/w1AQhgfTEktTs1NSC1CKYLBMHp1QDo4R4cebx3TMz7q4zV0m7lPz+wNOzO6z4fuad
 8xfevlZj+dxNnnOdJR7/0GaZ8Pa/cPC/fFWL0n9eamet99g73/Ng39jEpOTA6yBZ35Ojyem9
 1tLZaeJB8YlTdp7sc3sn+Oxgwpqa+0vXPW02E9uSkXxCXMu8jvNazAHReqtA2yTLnWITny/K
 VGIpzkg01GIuKk4EAE0++7wLAgAA
X-CFilter-Loop: Reflected
X-Headers-End: 1tzt5y-0005ma-B6
Subject: [f2fs-dev] [PATCH v3] f2fs: prevent the current section from being
 selected as a victim during GC
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
Cc: pilhyun.kim@sk.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When selecting a victim using next_victim_seg in a large section, the
selected section might already have been cleared and designated as the
new current section, making it actively in use.
This behavior causes inconsistency between the SIT and SSA.

F2FS-fs (dm-54): Inconsistent segment (70961) type [0, 1] in SSA and SIT
Call trace:
dump_backtrace+0xe8/0x10c
show_stack+0x18/0x28
dump_stack_lvl+0x50/0x6c
dump_stack+0x18/0x28
f2fs_stop_checkpoint+0x1c/0x3c
do_garbage_collect+0x41c/0x271c
f2fs_gc+0x27c/0x828
gc_thread_func+0x290/0x88c
kthread+0x11c/0x164
ret_from_fork+0x10/0x20

issue scenario
segs_per_sec=2
- seg#0 and seg#1 are all dirty
- all valid blocks are removed in seg#1
- gc select this sec and next_victim_seg=seg#0
- migrate seg#0, next_victim_seg=seg#1
- checkpoint -> sec(seg#0, seg#1)  becomes free
- allocator assigns sec(seg#0, seg#1) to curseg
- gc tries to migrate seg#1

Signed-off-by: yohan.joung <yohan.joung@sk.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 0465dc00b349..129df633d656 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -476,6 +476,12 @@ static inline void __set_test_and_free(struct f2fs_sb_info *sbi,
 		if (next >= start_segno + usable_segs) {
 			if (test_and_clear_bit(secno, free_i->free_secmap))
 				free_i->free_sections++;
+
+			if (GET_SEC_FROM_SEG(sbi->next_victim_seg[BG_GC]) == secno)
+				sbi->next_victim_seg[BG_GC] = NULL_SEGNO;
+
+			if (GET_SEC_FROM_SEG(sbi->next_victim_seg[FG_GC]) == secno)
+				sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
 		}
 	}
 skip_free:
-- 
2.33.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
