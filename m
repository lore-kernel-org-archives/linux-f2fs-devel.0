Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FD9C624D4
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Sep 2026 09:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=edGgFro7jIhPem9dlBvaT2bcqMWsOxuffU4cyy8gdcg=; b=cTZZ2GVZoxuNa3/ynLLzz9nRZc
	favKal77+6N1842c+Is3t5BzihmUQ5jQCHiw9ut3BvKDQ/6wHFEax0P79vhedo1PHS5XsAJyIstPK
	GSZ13ssjsXkzQT0H87cWbJfdEAH9Qe2e2aBr95jzP2V8r9CKgiorUfhB5N5a4Zmw5CG4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1gvJ-00064K-DA;
	Wed, 02 Sep 2026 09:06:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x1gvH-00063h-Vg
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 09:06:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=taNa6B3EmauuyVm4ZB81pFrGCPMICbTOjcQ4EwXiQVE=; b=TRvxHUAKDI127x3ZC5QbthwHsm
 Y5qtnY5Bu7RzHhbP1Bh8hhcCm/63Xo4hLtB0/GwSsSShatzvNu0ubKcnpX/Z1jKUywy1bwN2ulInY
 2B/HJ5X8UOrFUIO7i8HUp2f4vCy3UNPVSsuXyEYiaPX+spmD4KIZZfb0AzgbMrJ6TNPo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=taNa6B3EmauuyVm4ZB81pFrGCPMICbTOjcQ4EwXiQVE=; b=D
 Jhrm1AViIHHFL555h+CFUVuGXkEGx/7tlHtU73RTpfOu3LhezOVGvxFHjdSeyq2rLpq+qDl+kE2h/
 2n4/CBLtGHiqh8Xzf2800Qtd15AsycMApWitSd+f6tixpC/jQLTR5csgaUFlk00jsrgOWEsOrqtM3
 q6Ch9urZkpPVMHco=;
Received: from mail-pg1-f173.google.com ([209.85.215.173])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1gvI-0006ok-AU for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 09:06:24 +0000
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c9e607d81fcso550911a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 02:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788339978; x=1788944778; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=taNa6B3EmauuyVm4ZB81pFrGCPMICbTOjcQ4EwXiQVE=;
 b=MGZwgLmfjBVDYt02ZaOuARM3u1SZDuT5GlEFVfH/5JxfCc8WJ8hQxbwZj8QD0IDSgw
 h07Y17+CzHw0X68uGsM1TbUePfRumKpexJ1FSBRDZdpjMbzJuyIJ3XjgY/0KOhXzKI8p
 4j8uaSzKY9VlNNBtsf71JUGxenpXuQ3G+lDl5+XFyI2MjA2JDWwN62dIP9JdfiTsT3D/
 fmBlcXHp7yWAvJuPrY5flmvoaMHKw/iD+yORa+t3Xwt9Xcm/vx4AAT/Ifi/4zin9BOKe
 QEcfB2s/Cn6ljCdr1gafnbXBedbqGTeawEPRXrpWioaVvnasxs/Ttq+knqNno+ELdh7/
 EjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788339978; x=1788944778;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=taNa6B3EmauuyVm4ZB81pFrGCPMICbTOjcQ4EwXiQVE=;
 b=hFIorghvDw+ti9PBxnBlzvS/6yABWosvr/7/ccryHp4ZhrGp2FjI+osVmpF/WB2LTW
 bmRNpEJnKbPgest601GUIdLlcF1faCyEbybGkQCGTKtxM+CDj5XiWWs1kInoud+/1mI8
 ruD3WCqHSmoE9pRUcx1VyEZQ/nN338jnaCfJwA8gCRD+PBrRyD3SnHfesJzIqbf3xO8a
 EhqsD4cV+FRG67KVB6PeYi7sKoC7Ht9bbF/SfbMIaKPwj4MpeUOLkqnOEgoeVeWMn4+e
 KzLk1Q3Attm6YVtSok9jHv4VqoOcBp4Mk5peIno3sZE/kz0PHZflr0DMWMXkUEhWv1+W
 xr6A==
X-Gm-Message-State: AFuF++l83gsCzZ++NPdB2SqFQmOVa5wOTU7Ng17wqni8aEn6qoZ/B4UE
 +sqODc/taDLLQom4NEl7E0zSGaXui8nXMB0b+ZRjfETCZ9TeSH9mp4a8
X-Gm-Gg: AYBFou06YIQDK1ql8j0VccGK+i1Rkvm2SG0Hij2R0vjgtrVNJt6I0uLbB7d+UsehZHg
 ycxZ2KbIudIruIqpuyursHWhAP3VuaygjiAk7+aO9Ju7nKzeHLLT9PyNI4vdgJSfc0uHJNJQWmz
 W4mwjOpg1DKrMtDqHnewItpud3Id3rm3sRuxNKi65ffbzUzTgVAEPGuXj8swWdRGlW+Ey41UjPY
 ZEOiDNujqiOE7y1WByYsIpucVc9tfj3ZPIQbA4LFl6BPbeK5uRa3v+sZn4RlwSvrp+ETUDp3Flg
 rLS1/WfcrGe79NpvaJffoVfh/+mDXFkV8JDFusrMEotOjevoNwc66QHQ67881JAalwVIg9XW8sz
 hg2LnBIBybpu0LLD2mKVEKYhbJBiM79v8bbXDG12zheXLnrRL1uyamgqkanIetkXo8DNSfNUA8c
 vBZNyk/I6KxPMfSJfPvg3a2lwA/hLm6JRSNf90eq2afHrn6uLuXxf38G0q52Adv8ZXhT5NUp88u
 dU/ToUA+don/fBLDDPZctvekaoDCLOo78Y=
X-Received: by 2002:a17:90b:5828:b0:38e:2e86:ed02 with SMTP id
 98e67ed59e1d1-39aee0850bcmr5257955a91.14.1788339978481; 
 Wed, 02 Sep 2026 02:06:18 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39ae380d0bdsm4373589a91.11.2026.09.02.02.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 02:06:17 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Wed,  2 Sep 2026 17:06:11 +0800
Message-ID: <20260902090611.564876-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1x1gvI-0006ok-AU
Subject: [f2fs-dev] [PATCH v3] f2fs: wait for inode record work before
 clearing ino bitmaps
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
Cc: qwjhust@gmail.com, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

APPEND/UPDATE inode state recording was moved to the inode eviction
workqueue. These entries were later converted to bitmap values stored in
XArrays, but the workqueue drain was left behind in the list cleanup loop
where it is now a no-op.

During unmount, inode eviction work can therefore remain queued when
f2fs_release_ino_entry() destroys the bitmap XArrays. A delayed worker can
repopulate them before the workqueue is finally destroyed, leaking newly
allocated XArray nodes when the F2FS superblock is freed.

Wait for APPEND/UPDATE inode record work before destroying each bitmap
XArray, restoring the required ordering.

Fixes: 9a9ee7408a1f ("f2fs: reduce memory footprint of ino management")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
v3:
- Call flush_workqueue() directly, remove the obsolete helper, and retain
  a comment explaining the APPEND/UPDATE state-record wait.

 fs/f2fs/checkpoint.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 4b59f30ef45d5..cf88b463fde51 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -825,15 +825,6 @@ static void __clear_ino_bitmap(struct f2fs_sb_info *sbi, nid_t ino, int type)
 	spin_unlock(&im->ino_lock);
 }
 
-static void f2fs_wait_for_inode_record(struct f2fs_sb_info *sbi, int mode)
-{
-	if (mode != APPEND_INO && mode != UPDATE_INO)
-		return;
-
-	/* Let's wait for some pending updates for APPEND_INO and UPDATE_INO. */
-	flush_workqueue(sbi->evict_wq);
-}
-
 static void __f2fs_add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
 					unsigned int devidx, int type)
 {
@@ -887,8 +878,6 @@ void f2fs_release_ino_entry(struct f2fs_sb_info *sbi, bool all)
 	for (i = all ? ORPHAN_INO : FLUSH_INO; i <= FLUSH_INO; i++) {
 		struct inode_management *im = &sbi->im[i];
 
-		f2fs_wait_for_inode_record(sbi, i);
-
 		spin_lock(&im->ino_lock);
 		list_for_each_entry_safe(e, tmp, &im->ino_list, list) {
 			list_del(&e->list);
@@ -899,6 +888,9 @@ void f2fs_release_ino_entry(struct f2fs_sb_info *sbi, bool all)
 		spin_unlock(&im->ino_lock);
 	}
 
+	/* Wait for pending APPEND/UPDATE inode state updates. */
+	flush_workqueue(sbi->evict_wq);
+
 	for (i = APPEND_INO; i < MAX_INO_ENTRY; i++) {
 		struct inode_management *im = &sbi->im[i];
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
