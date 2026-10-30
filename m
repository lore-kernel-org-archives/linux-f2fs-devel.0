Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55403606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bKNEqsfj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=F++pQVV/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=E+UsVd0y;
	dkim=neutral header.d=cyberprotect.ru header.i=@cyberprotect.ru header.a=rsa-sha256 header.s=dkim-r header.b=en/CuDcL;
	dkim=neutral header.d=cyberprotect.ru header.i=@cyberprotect.ru header.a=ed25519-sha256 header.s=dkim header.b=wJ5wFA11;
	dkim=neutral header.d=cyberprotect.ru header.i=@cyberprotect.ru header.a=rsa-sha256 header.s=dkim-r header.b=en/CuDcL;
	dkim=neutral header.d=cyberprotect.ru header.i=@cyberprotect.ru header.a=ed25519-sha256 header.s=dkim header.b=wJ5wFA11
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=UayZFhpZU+XWe6mo9J5rlG5YXPjS6QSeKtsccnNJdmI=; b=bKNEqsfji+Uc0DFqwTImE9faBf
	0jo9KK9kugq43a2pwsM93FSa0PpU6XvZ+onYNrTVY+tz0+hpgKCGuzfx3B2ts+SSFKLLStH/Xf6+Y
	dEdVTQj8b6wb00i4M6mmM71a3pkxh0yVdUFGhamrPDjDIssxytzd9nglH/ogc9pRpxUQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xMkpm-0000000067E-10u9;
	Fri, 30 Oct 2026 11:31:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <Dmitry.Chumachenko@cyberprotect.ru>)
 id 1xMkpk-00000000677-27FF
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 11:31:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y2UG5XiP3g7yITzPkEcF1pPDNm2Tb3z2RMnHFZbQ/4w=; b=F++pQVV/hyBUDLDUNgDfzZRQci
 CXPn2IFJX1y+sJ03dRwaaVtf8nH1b62+BIP7YeL5ap8/TKBGUmwMoPHjotZbogjk3nW54mWza+1SG
 yjA1ojUj7OZOu1W2CZtdXoxva/8qD9kwajI+Cw14YuPYN2mSuHmo+Joc93F4JJrxx2oQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y2UG5XiP3g7yITzPkEcF1pPDNm2Tb3z2RMnHFZbQ/4w=; b=E+UsVd0y7M0Xh86E1dFCW7xxOV
 3wN/ojog9yTI1KW7T5Ybso3BlpVLS9u77/wUBeRIZLCkXqiU4zqcMENG6iDEsI8k5Jg1Slrq9uOQR
 wDScmPg9bciLo3nbvww8TI8dJdClzjApUuFCuHi9nL2ZkOa2c/kDxswrHm8rtYa5NZHE=;
Received: from mx1.cyberprotect.ru ([185.232.107.110])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMkpi-000000007Z3-1G1U
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 11:31:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cyberprotect.ru; s=dkim-r; h=MIME-Version:Date:From:Sender:Reply-To;
 bh=y2UG5XiP3g7yITzPkEcF1pPDNm2Tb3z2RMnHFZbQ/4w=; b=en/CuDcL+5jwmgnpwkKdpI5t8V
 TgTJ8YKS3fwRNGxQ2KGZMr3oATnZrgQcvcqxZ9NpSGFTCOJADSouw7fnWC/z2N4ZFKsw/Ad7lGvTH
 OUHadaiufZXXPC/M2WsdemNmPwmf7aiUKJ244i3e95vrDH793k0lekV0NERqMK7w9Lwua/8QbOr+z
 4sIZ5Mh58WGFGIx5paTq5U9+XFEmptRgr+e7ElAydQv/BGjGfGslqUH3mi1AnNWIc3HrHW+YLhG6V
 C9l85nIY0K3TpEcv63Ru3uZHGIBLyafdtMTbz50KIoTpX4diCF2c3lkLYJS75Y/+fivpICIn2POnR
 WB4ivUyQ==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cyberprotect.ru; s=dkim; h=MIME-Version:Date:From:Sender:Reply-To;
 bh=y2UG5XiP3g7yITzPkEcF1pPDNm2Tb3z2RMnHFZbQ/4w=; b=wJ5wFA11KvVIDlHAYVZ6ptfJWl
 gJNam8mGIePiIzeF2mmJHpkgEr4bdKq5C2duA3rZoxYh1gNXulaV0e7QLTDQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cyberprotect.ru; s=dkim-r; h=MIME-Version:Date:From:Sender:Reply-To;
 bh=y2UG5XiP3g7yITzPkEcF1pPDNm2Tb3z2RMnHFZbQ/4w=; b=en/CuDcL+5jwmgnpwkKdpI5t8V
 TgTJ8YKS3fwRNGxQ2KGZMr3oATnZrgQcvcqxZ9NpSGFTCOJADSouw7fnWC/z2N4ZFKsw/Ad7lGvTH
 OUHadaiufZXXPC/M2WsdemNmPwmf7aiUKJ244i3e95vrDH793k0lekV0NERqMK7w9Lwua/8QbOr+z
 4sIZ5Mh58WGFGIx5paTq5U9+XFEmptRgr+e7ElAydQv/BGjGfGslqUH3mi1AnNWIc3HrHW+YLhG6V
 C9l85nIY0K3TpEcv63Ru3uZHGIBLyafdtMTbz50KIoTpX4diCF2c3lkLYJS75Y/+fivpICIn2POnR
 WB4ivUyQ==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cyberprotect.ru; s=dkim; h=MIME-Version:Date:From:Sender:Reply-To;
 bh=y2UG5XiP3g7yITzPkEcF1pPDNm2Tb3z2RMnHFZbQ/4w=; b=wJ5wFA11KvVIDlHAYVZ6ptfJWl
 gJNam8mGIePiIzeF2mmJHpkgEr4bdKq5C2duA3rZoxYh1gNXulaV0e7QLTDQ==;
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 30 Oct 2026 14:11:12 +0300
Message-ID: <20261030111112.20953-1-Dmitry.Chumachenko@cyberprotect.ru>
X-Mailer: git-send-email 2.49.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: AIP-EXCH-1.aip.ooo (10.77.28.101) To AIP-EXCH-1.aip.ooo
 (10.77.28.101)
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMkpi-000000007Z3-1G1U
Subject: [f2fs-dev] [PATCH] f2fs: reject mount when block_count exceeds
 device capacity
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Dmitriy Chumachenko via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
Cc: lvc-project@linuxtesting.org,
 syzbot+8b85865808c8908a0d8c@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

During fuzz testing, the following issue was discovered.

INFO: task kworker/u9:2:981 blocked for more than 122 seconds.
      Not tainted 7.1.0-rc4-00103-ge94869f14310 #59
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u9:2    state:D stack:25800 pid:981   tgid:981   ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
 <TASK>
 __schedule+0x122f/0x6530
 rt_mutex_schedule+0x96/0xe0
 __rt_mutex_slowlock_locked.constprop.0+0x13bd/0x3280
 rwbase_write_lock+0x5df/0x720
 f2fs_down_write_trace+0xc8/0x320
 f2fs_balance_fs+0x6ee/0xa50
 f2fs_write_inode+0x5e4/0x15a0
 __writeback_single_inode+0xcda/0x1360
 writeback_sb_inodes+0x767/0x1d90
 __writeback_inodes_wb+0xf8/0x2d0
 wb_writeback+0x723/0xb90
 wb_workfn+0x8e6/0xc10
 process_one_work+0xa0e/0x1980
 worker_thread+0x5ef/0xe50
 kthread+0x370/0x450
 ret_from_fork+0x72b/0xd50
 ret_from_fork_asm+0x1a/0x30
 </TASK>

The superblock declares a block_count larger than the backing device, but
sanity_check_raw_super() validates block_count only against segment_count
and never against the device size, so the oversized filesystem mounts and
its main area extends past the end of the device.

On the first fallocate(), f2fs_balance_fs() runs foreground GC, which
selects a victim segment located beyond the device. The blocks are valid
per on-disk metadata, so is_alive() accepts them and do_garbage_collect()
keeps issuing reads past the end of the device without making progress,
while holding sbi->gc_lock. Writeback and sync then block on gc_lock
indefinitely, producing the hung task above.

This only affects single-device setups: on a multi-device volume
block_count is the whole-filesystem total and legitimately exceeds the
primary device, so the check is restricted to single-device images and
compares block_count against the backing device capacity.

Fixes: aff063e266cb ("f2fs: add super block operations")
Reported-by: syzbot+8b85865808c8908a0d8c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
Signed-off-by: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
---
 fs/f2fs/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fabcafafabf1..ba484a32f292 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3445,6 +3445,13 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 			  segment_count, le64_to_cpu(raw_super->block_count));
 		return -EFSCORRUPTED;
 	}
+	if (!RDEV(0).path[0] &&
+	    le64_to_cpu(raw_super->block_count) > sb_bdev_nr_blocks(sbi->sb)) {
+		f2fs_info(sbi, "block_count(%llu) exceeds device capacity(%llu blocks)",
+			  le64_to_cpu(raw_super->block_count),
+			  (unsigned long long)sb_bdev_nr_blocks(sbi->sb));
+		return -EFSCORRUPTED;
+	}
 
 	if (RDEV(0).path[0]) {
 		block_t dev_seg_count = le32_to_cpu(RDEV(0).total_segments);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
