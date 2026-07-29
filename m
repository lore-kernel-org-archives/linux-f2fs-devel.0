Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B994EC53200
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Kg8fPD+8YpKSCwz99JSkQQdRJ/GWDnbOQ/2yOe9zlAw=; b=h6TlfblaPT+Lzzmh4fAMmjHanq
	8oxvwAh8+d6f/jQi0044VDO4DQiJuGCxjHojfKEN6r11YyLl5sz8YWcHd3S0vOl6okXWF/pRK3MKb
	q/QqTgyXPk5KalMCyrN18PvKCOBhIgUxTSol/67t+CR8BXOGU/R1xo+2ke5L3myErWNY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wp2fx-0002Nx-4O;
	Wed, 29 Jul 2026 11:42:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wp2fv-0002Nq-Ty
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 11:42:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yuoz3PtgKXX1k02oR2d/hFIWFEkFXNq3pA596VbQzqo=; b=WNXdwZ66iwn1t5cEsJzeNa7rip
 wXRCcnNEB9V9sB8FB/oOoEmt0efOEuRbwAHD4Ro/bfYnUDUpF5MKc/KkdOCq4HQuaa2PduQEA7+tG
 KMlGGyhacU6ADzWmT2OVYtGnGMApcBIcXdgKVKG48T/P3sXkTJqV1MkERvO4xQHE+EhA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yuoz3PtgKXX1k02oR2d/hFIWFEkFXNq3pA596VbQzqo=; b=J
 fynwp1lkEA218ARo50jTxPnMgInI/xHoQV9dqekvW/MdO58zlE9W4lw4oW2gwNAzrW7l+I3XY9+Jk
 Yk0YtOJO8mJSHstWKGYp14v4PtOIqxuZi8EhdjjX8W6oMaSnx+nm8EsQIye9v0j64LJ8xptpCfbu0
 B4DbqTVGdTjaKcR4=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp2fs-0005Mn-3X for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 11:42:13 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so611740f8f.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 04:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785325325; x=1785930125; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yuoz3PtgKXX1k02oR2d/hFIWFEkFXNq3pA596VbQzqo=;
 b=rUW//T1qxLlzDrYc6LIWn0rKVr44TMxZ/YEqOpFipu34TWzAZGmyDfT/enf66P73ZJ
 durbOU1UUNoWXSrQN+bOBTV7gIZslnvfsisPkPBpj2N5mPi6Xj2bode0spZKbJUEFuv1
 7F5yiA89hcWyhuOkOHqdI7LcCPhF81Gdsdo74hw412B8MrHRA6Xa0FF8Oo4EVPpbCItG
 BILvBll7Ckr1Fv9FWIprJQPU4PHUhq/CDW4/46KZ3+NHDrMnTasQYbXIW+lWE6c41SpL
 H19eXTvOvtJ/qLvUDqyeGJDt/mg0AmR1fakzR9smo8tOCOx4caO2I6bc2MRX1GIz45nI
 iB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785325325; x=1785930125;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yuoz3PtgKXX1k02oR2d/hFIWFEkFXNq3pA596VbQzqo=;
 b=Ben2b9wCbkSRV1q/AI9UIewVcbjfNBiM2QUUECSBzffP3dMiKA+JkFRxs/bwl+pglZ
 NFxmFhmQ1cBKo7SrhdQ5UpGggOWXwp/iBWs8F0r2A7dOR0VPpS2yLdvv2xdJqZh5sDQR
 6g+7F5q2cXOjAGwOh3DP8cic4qcPsJs/XEiel9ZDSxkcwvoF8lQST/laq1SdOifQNJHh
 ZEfuMpwA4lMDuIxoxK1S4wD4A7C9UDrB1RyPVS0Ps4EP6ZYZoAFVBWYj/iTUdXq5fHF8
 f4zTRfI3R4JfGTBkEJp0pV2fvQzf3Qpfcv+KxSravFp1lNdtXV02vNfhxSXmrGOPli+K
 Faew==
X-Gm-Message-State: AOJu0YyTaJb5BW3GmhEuA5JAGdNhQIu9OV3m2i/bql6+9vFhjmme00gX
 UEjLOwjyLK8oaywmDRmIASzzmDExBbQajhbcxExagHHXLpXHnDDMmFhl
X-Gm-Gg: AR+sD134/HI2nTEX6MUPs4uGVh/TU3pVXLcqY479FD0cXZYc4L830Y3rsv4MCMyfaG+
 NUl3N2yx+BgFtdYqrbovgV5DGmUzpI287231GbVehG2e72ra5Ffcm9m3JrdTElfMebTVaSyqepn
 QQ0IKCa8kRoLnOnDe1sY8X12PFEuCQVK+lsiNAy4uB3vvAPQaej81xm+joZ9fn0G4P7fME0+gTI
 R8KQmYacBLuS5WEpkrNKdiYdk79hU1z0lei+GTQISoxBmemHoyDtMzd/Kca9hteRkDRht6XMJzt
 r+QBW4RXL0Yj4T5g5VE1WQPvfxnXEYnLuZQwUEyDuvkzVw2aC1p3wqN+JS8gau7OALzFNW9C5m0
 J20diovupvmc7aKFYZl1XGkl1eM19NUQtDFPUVUpY2dzqhStaSsQCNKX2H3WZ5U0k8/EF7ZHdWj
 6aVGxDH80MzcS1hlXLmDPUpUbaP1OATNGlhVBpqigLyGxZxUWFCgbFkBDlkM1TqQOCJwKXVax7P
 OttMHY6DH8e7vWP6ckhNent
X-Received: by 2002:a05:6000:1883:b0:47f:96e3:5309 with SMTP id
 ffacd0b85a97d-47fb1ec8813mr7822622f8f.9.1785325325285; 
 Wed, 29 Jul 2026 04:42:05 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b0f2ddsm7333367f8f.20.2026.07.29.04.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 04:42:04 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Wed, 29 Jul 2026 19:41:56 +0800
Message-ID: <20260729114156.3348582-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wp2fs-0005Mn-3X
Subject: [f2fs-dev] [PATCH] f2fs: reject invalid recovered filename lengths
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

Recovery uses raw_inode->i_namelen directly when rebuilding fsynced
dentries. A zero-length name uses no dentry slots, so recovery can
report success without recreating the dentry.

Treat zero-length and oversized recovered names as corruption, mark
NEED_FSCK, and stop recovery with -EFSCORRUPTED.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/recovery.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 89af8407b667..70cf99efcb3c 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -126,8 +126,8 @@ static int init_recovered_filename(const struct inode *dir,
 	fname->disk_name.len = le32_to_cpu(raw_inode->i_namelen);
 	fname->disk_name.name = raw_inode->i_name;
 
-	if (WARN_ON(fname->disk_name.len > F2FS_NAME_LEN))
-		return -ENAMETOOLONG;
+	if (!fname->disk_name.len || fname->disk_name.len > F2FS_NAME_LEN)
+		return -EFSCORRUPTED;
 
 	if (!IS_ENCRYPTED(dir)) {
 		usr_fname->name = fname->disk_name.name;
@@ -185,8 +185,16 @@ static int recover_dentry(struct inode *inode, struct folio *ifolio,
 
 	dir = entry->inode;
 	err = init_recovered_filename(dir, raw_inode, &fname, &usr_fname);
-	if (err)
+	if (err) {
+		if (err == -EFSCORRUPTED) {
+			f2fs_err(F2FS_I_SB(inode),
+				 "invalid recovered filename length %u for ino %llu",
+				 le32_to_cpu(raw_inode->i_namelen), inode->i_ino);
+			set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
+			f2fs_handle_error(F2FS_I_SB(inode), ERROR_CORRUPTED_INODE);
+		}
 		goto out;
+	}
 retry:
 	de = __f2fs_find_entry(dir, &fname, &folio);
 	if (de && inode->i_ino == le32_to_cpu(de->ino))


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
