Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5F0606A323
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Nov 2026 01:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=nT57W4S7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BRmiilnc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=a5iFV/Cc;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oBoOw3W/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=T5/Z+gZyeQNsTf5NWmXgccDvjjOvjd9DJdwXsJR0JLw=; b=nT57W4S7QlALAYQErhpSy5Y2/U
	gCUCQ8NhLrin9PkFC0ztSjH9lv9eoCJTyHiTXBmw8ZGx5C1KyCEEDFgc3+D/OLWnGz/o63/z3gi3s
	X6aEgunOcfs9YJ3v7Lp/Elb2waO/j/8m9KWnp8TfAFh0U1JxqsA+wrTivzqNcUh2iH+I=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xWkWD-000000007Lf-0CCC;
	Fri, 27 Nov 2026 01:12:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zhijunli.leo@gmail.com>) id 1xWkWC-000000007LY-2Rys
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 01:12:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rOaXMWz/87oI93lqqKPMBOKv2/6Eat6aF1tKcKKMg6Y=; b=BRmiilncKKS4gk3AHASPfBRfC6
 TFzHGCc25Jzs1lw2yz21xOBoJ9e1hFAPW7CGa1Q4XTYPlt3QJvaII/D3vqoHvtcN3aPJzuDNg0xax
 sHO7ar8yB8DGnusIf6qr2KaaQyD+TZqdJacnM3qPdq1KB9VzGN75+tYM95qOTNNOCr8I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rOaXMWz/87oI93lqqKPMBOKv2/6Eat6aF1tKcKKMg6Y=; b=a5iFV/CcdYAgDAeF8vVPQs5UHQ
 67wsuOutND2603uJfH2njErXpQdrwAZUxfmyvZskoJ9r+F8nyM56t7hK9rXT9Z/wvYeRjggAwhCpT
 qLfFLAR8bfNUec9OBXTMUiUHBBUS0UOujPhSw9HZJTmq6JdP1URz37UnyNhiGfKQdPTQ=;
Received: from mail-pf1-f181.google.com ([209.85.210.181])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWkWB-000000005Et-0dJi
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 01:12:52 +0000
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-8c70c2ab5a2so2969854b3a.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 17:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795741965; x=1796346765; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rOaXMWz/87oI93lqqKPMBOKv2/6Eat6aF1tKcKKMg6Y=;
 b=oBoOw3W/WcLV31JIMXaPxm8Lsqu4YViYiHBS4eEpBEgqzIchpUeC5guZnfl3Ddoo9x
 tGbg3/uFBq3DYVrjjxD8bvA427idcVwUEod94R9F2wfNtrUoGePG/dC7w6YSUAxX2jlA
 ClLafAA+xX3kU9scOUxbtOJ+s2sMprHpiP7lDDm0oDcX+b4279o0i00cvlkv8SUo8yf8
 fB0U+C5bVAfNTNHkB43GnEWrH1MW3xzcb9b2bdty3hEUGcn4xiDORdVza2PcSvoMGOgE
 kG51kiJPMkwSud8U6RxEbu6l4+mBEUmplxgH2evphJgB2zUV/MOjqz6yvaWgXhazPUV+
 6zjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795741965; x=1796346765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rOaXMWz/87oI93lqqKPMBOKv2/6Eat6aF1tKcKKMg6Y=;
 b=n04pOhfqGK3LDntl2Afz8D3y/CGKViLHpu+/Fle4E2x1sPZqVTPkDW8vqNFq9dLKIK
 2gX6Ismq0Ci4/PgfCd31mNGvZOvNGyzONIe8cnDviJr2GMfsAe+UR/oO5si7u91AhUjP
 N0nmUVYeUojNiQuI0dFUB5OU7ED4Q3GO9iG7oN2Aa7VwVRj1B4fcCIkVILIspUSi1gVt
 QGoC0ZUMIP0DprUD733o4VqSPs9mMk6Ie6hPQCXeCtBIBW0fp9nxjesaJZioy004LU+X
 nPAArDK7urn66RFtw955cqz644ID3lJ3QnwgRq249TAEOA0iHJ4a2YLrwcJ8oPycRhXZ
 rrZA==
X-Gm-Message-State: APuU4Z9mjvexrXM2pba8ja44gnFX75yHBO2oMydbw2tZG8wBM2mp6tuY
 ahNO8AyrQZdrEWhKZEixdonNmL9mJ5uqHrNKyYTXq3xIEAV2o4VgmCEt
X-Gm-Gg: AZFdTZeh9CydMWhTwSHNhlGCl/qg6qebvphqHjKbEktIaovUpMZjJPC9ulD0+WKw87n
 NOsDWDiBHdHJ+CU7pJhvQOnwkcjAF7gGvzbgoEtrVZCIJ5s7heHuft9a4RmNHT8u0K4BCViQPIn
 dyet023DRTvBkJjtCHF46EenD84yS+HfmToZKCrZUHhjZBzN9gKL0U6r42IYk0EYQmcHEIr00iB
 jneoL/2Y3R3NoPwzVPIjGvt8AGHD0LCl2/pLAJMBmIRr4x2CPz0DOcWWrlV5JMtfoNnGEqFP2E2
 JiwycBKOk0Prluh+QF7dgKuu7OIQendKcVxTgFDcbZ2yAYdi7iPtoYODZWE/ENfpD3n/T53TmD9
 2od3qIGeQCmLITjU2U8ukA5nhp2cF5a+FypVWtIz7/98LHdH9i1TOYNrNc3LQcSH0bZO1tKQtaV
 IjngaybWqxiHSvPtic5QnnbIFQ+eiu7jwknPssR5looKEwTiRIu55+XOrn5w+pdGfmU6CaGzv+R
 u6A0sWeJkbdVVsP+13VquXhpLMLLOeSYGdI3AiTdm8W5RHstfBVLo4fVNpq5oIw9GSNoKn1O3Z9
 yxeLzJxFpsi83AZceqmfSWOYRZlVO7tNRyYQ0kzSlP0AavBwUw==
X-Received: by 2002:a05:6a00:230b:b0:8a7:3c62:30f2 with SMTP id
 d2e1a72fcca58-8c87cc42cfcmr18473116b3a.36.1795741965249; 
 Thu, 26 Nov 2026 17:12:45 -0800 (PST)
Received: from HP-Pro-Tower.mioffice.cn ([43.224.245.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c872e456a7sm11593461b3a.29.2026.11.26.17.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 17:12:44 -0800 (PST)
From: Zhijun Li <zhijunli.leo@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Fri, 27 Nov 2026 09:12:31 +0800
Message-ID: <20261127011231.1564680-1-zhijunli.leo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022120833.1698722-1-lizhijun3@xiaomi.com>
References: <20261022120833.1698722-1-lizhijun3@xiaomi.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWkWB-000000005Et-0dJi
Subject: [f2fs-dev] [PATCH v2] f2fs: stop checkpoint on pinned segment
 allocation failure
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Zhijun Li <lizhijun3@xiaomi.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zhijun Li <lizhijun3@xiaomi.com>

f2fs_allocate_data_block() updates SIT before rotating the current
segment, since SSR needs the latest valid block information:

	update_sit_entry(sbi, *new_blkaddr, 1);
	update_sit_entry(sbi, old_blkaddr, -1);

If the rotation fails, it jumps to out_err without reverting the SIT
update. This is fine as long as checkpoint has been stopped by then,
because the stale SIT will never be persisted. do_write_page() asserts
this with f2fs_bug_on(!CP_ERROR_FLAG), and every failure in the
rotation path satisfies it: get_new_segment() stops checkpoint on
-ENOSPC and -EFSCORRUPTED, and change_curseg() only fails after
f2fs_get_meta_cache_retry() has stopped checkpoint.

Pinned allocation is the exception. Since
commit 48ea8b200414 ("f2fs: fix to avoid panic once fallocation fails for pinfile"),
get_new_segment() does not stop checkpoint for pinned allocation, and
since commit c966d29e01bb ("f2fs: support resizable tail section and unify pinned allocation"),
it may also return -EAGAIN for it.

That is intended for f2fs_allocate_pinning_section(), which fails
before any SIT update. But when a CURSEG_COLD_DATA_PINNED segment
becomes full in the middle of a section, f2fs_allocate_data_block()
calls new_curseg() after SIT is updated. If it fails, fallocate()
returns an error and the filesystem keeps running, with a block marked
valid in SIT that no node refers to, while __allocate_data_block() has
already reverted valid_block_count. The next checkpoint persists the
SIT, and the next mount fails in build_sit_entries():

  F2FS-fs (vda): SIT is corrupted data# 513 3 vs 515
  F2FS-fs (vda): Failed to initialize F2FS segment manager (-117)

fsck.f2fs also reports "SIT valid block bitmap checking [Fail]".

It can be reproduced with CONFIG_F2FS_FAULT_INJECTION:

  mkfs.f2fs -f -s 4 /dev/vda
  mount -t f2fs /dev/vda /mnt
  touch /mnt/pin; f2fs_io pinfile set /mnt/pin
  echo 0x100000 > /sys/fs/f2fs/vda/inject_type   # FAULT_NO_SEGMENT
  echo 2 > /sys/fs/f2fs/vda/inject_rate          # fail the 2nd segment
  fallocate -l 64M /mnt/pin                       # fails with ENOSPC
  echo 0 > /sys/fs/f2fs/vda/inject_rate
  umount /mnt
  mount -t f2fs /dev/vda /mnt                     # fails with EUCLEAN

Fix it by stopping checkpoint when the rotation fails after SIT has
been updated. The early -ENOSPC return for curseg->segno == NULL_SEGNO
is not affected: it happens before any SIT update and is the expected
path once a pinned section is used up. Pinned allocation failures in
f2fs_allocate_pinning_section() still don't stop checkpoint.

Fixes: 48ea8b200414 ("f2fs: fix to avoid panic once fallocation fails for pinfile")
Co-developed-by: Chen Zhangqi <chenzhangqi@xiaomi.com>
Signed-off-by: Chen Zhangqi <chenzhangqi@xiaomi.com>
Signed-off-by: Zhijun Li <lizhijun3@xiaomi.com>
---
v2:
- Drop the SIT rollback. v1 claimed that change_curseg() may fail with
  -ENOMEM without stopping checkpoint, which is wrong: the summary read
  retries on allocation failure, and f2fs_get_meta_cache_retry() stops
  checkpoint on any error. The only gap is pinned allocation.
- Stop checkpoint instead of partially reverting SIT, which also left
  ckpt_valid_map, discard_map, mtime and curseg state behind. This
  matches the existing assumption in do_write_page().
- Fix the Fixes tag, drop Cc: stable.
- Add a reproducer. Tested in QEMU on top of f2fs/dev b61a029304bb with
  and without this patch: 200 rounds of pinned fallocate with
  FAULT_NO_SEGMENT at random rates (1..12) and sizes. Without the patch,
  138 rounds left an image that failed to mount; with it, the same 138
  rounds stopped checkpoint and the images passed fsck and mounted.
  Rounds that failed in f2fs_allocate_pinning_section() did not stop
  checkpoint either way. No lockdep/KASAN report with the patch.

Alternatively, we could check that the next segment can be allocated
before updating SIT for the pinned curseg, so that fallocate() fails
without shutting down the filesystem. I'm fine with either way.

v1: https://lore.kernel.org/linux-f2fs-devel/20261022120833.1698722-1-lizhijun3@xiaomi.com/

 fs/f2fs/segment.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 066b7cf813d7..5499f20d6428 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4051,8 +4051,18 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi,
 			stat_inc_seg_type(sbi, curseg);
 		}
 
-		if (ret)
+		if (ret) {
+			/*
+			 * SIT has already been updated above, stop checkpoint
+			 * so that the inconsistent SIT won't be persisted.
+			 * Most failures have stopped checkpoint already,
+			 * except pinned allocation failure.
+			 */
+			if (!f2fs_cp_error(sbi))
+				f2fs_stop_checkpoint(sbi, false,
+						     STOP_CP_REASON_NO_SEGMENT);
 			goto out_err;
+		}
 	}
 
 skip_new_segment:
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
