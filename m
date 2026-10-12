Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AB5CA9ED1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Oct 2026 09:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LffNfMHCh/FmgraSubYsXag7TZe7jnvwo10tk7g/bDg=; b=KdedDv2Dc4CLHeN5AGkAK44DjK
	PNUrd6a73YtVa9rd/rk96Ov7nwnea4bw0tfBQQbWfJZabdGpD3WOzstl9maZ4ef/lnuY2Mzf0qfxi
	rbMm2IBcs4UHh9hnq5+qHb69e5U/Y1zDw5/p3PTDaZFeiNkgLl036YIshlzTFLAdUFKI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGChd-0002Of-4O;
	Mon, 12 Oct 2026 09:52:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jsjlee1020@gmail.com>) id 1xGChb-0002OV-Fm
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 09:52:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LROCyt0+QHWtXH+zBhZ3dcjjP0w1s/UVlhWoFjFikoc=; b=BgalmVZpAmZB8qA0xtUArmrkJf
 2tYOUmgCjfvv9r4qM/mchDUy2o+qnirg+k/vYP+eIowFyMi8IDH/JegT5H9pj95swX1+GxP46TXhn
 FIw2BiNO/vW311nVG5GUeBbaIQ8sufpecrJbzv80V1LMXs+GArwU5dUqkv5g81cVlMTk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LROCyt0+QHWtXH+zBhZ3dcjjP0w1s/UVlhWoFjFikoc=; b=R
 Vl7s9NaGMdxiBpRsjwBf1pkDPIRtjSHHixuGXs/BrovUz2WQLjt1P01g31nTj62aS0ZEAniQYGVZc
 +c1EQ+C9nTBL19DWHHqbeQEHvVVJkgLKiIsS4OrPYrd5xj7sHCGw5tGIgKkmAU/+Vz7g5LnX4NeS4
 AKj8r9DuNUXILtis=;
Received: from mail-pj1-f45.google.com ([209.85.216.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGCha-0006Ha-OS for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 09:52:16 +0000
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3a706146559so984979a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Oct 2026 02:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791798729; x=1792403529; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LROCyt0+QHWtXH+zBhZ3dcjjP0w1s/UVlhWoFjFikoc=;
 b=QtVHyi3HSYnK99ZKDiRgZhnja1PfWbtrX8PyPDLBRCCMwjlzaZKuKCylGF7VgQLstX
 mDtdAfYEgyTTx7nRznOiiysKWgFkrYWudxDJSdj8KmE8oBYO/8yxHx7qemJGoyesJ9on
 Qeqfxtdw8Cr+ZvqQS8W4tPtGmE8uO13s/JMbeJzEO77Q6YrxT/SIDmVU+ZflpiQebWjA
 1NgapAQvfDSPwq8shJu3T+yyvkmBF32lquFGxZQK4SlYtOWWyLNy8QLqbhCh4AK7KzpB
 Y+U9H0XEcsL3bUhRt3P1Epx4ZggaduipmgZnDQbYBcuOg1UvsP4CzA+yOiJz8PKKIxXi
 uhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791798729; x=1792403529;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LROCyt0+QHWtXH+zBhZ3dcjjP0w1s/UVlhWoFjFikoc=;
 b=qx4omz5BaY1tjp35JN+K3Hd0uzk+N3SEUxpx57Yy5rJVWXzwF4QlCTpRi+f6dq2D9H
 DhIS8cn7RUv0WEoMSkm9JruB3ZMbYPqt+RpXcCifgdpDTr43zAC1ZQ6ixNNOMD/4gkO/
 zge01Hf43SU8Kt2FdVIM0TwwVVEwxykfnNQ6c+2ODzgwgkgo19ek76K5JiJR9sE85F0o
 tzViaWHdt+MoLTrp0rykXJR6M2f03F9d8vWY9yjTLx/UpNYxYoSuOUTIVM1wIIiBF2+n
 TIV/Xt+B1a10FV0DWCgBQhd2Pgm158ODcae/ty4hb1k28NDgMCTK2CM0N2V7yFbLC7fB
 whXA==
X-Gm-Message-State: AFq9FYKpZWOHAP0oTwZRLoVNPzUSknfRQWCprFRtgHldBaT2j/rZl44Z
 YqG8GT+6af3r5ONGBHLiPz6uJSkhaJ3gJqRjqPxss3u6y+3tEaEk7AHV
X-Gm-Gg: AYBFou2iTTAMwgVhFr96A2EbpdRlLCrAwNIl0aN/Iy7ZNFwqEDUvD7gp1o54CEJ95bD
 n46TTVe0gccnCDWddFCiZYDXOOL8oRILg6O9sQ5M9Ptksbn2hCExwPAHfqWx2RmC1Ea+rYH3mbt
 oq/4dKziIbv/o2EQ+pte3IOkZMM49KU6pU43HaKwKorUoy3cVbQIHFbxNg9NyITQbclD/mYf95O
 lyUZ9mY8yBOC/11UGijL+Fab3rGFmVpQRm1vQK7Ky6LaD9dC4Jo0OwmfDhmX0PNB/JlauHDkYiT
 wbXVycXgax2ddVpgHfilgc1xKeifY9WB6wZtliDQeq5ypT2odORJqt9fcx51UfS1v1zIaPDc7V8
 FCf3e0hfegJAQf5wZ90FQNCUBZe13B1yeke+DBl8A7eIJgkg8rjrYx7KCEAJ1cbM+ksExcim0RL
 kocJAi7jVA9mqM8j1Gze/O4l+VlcsiD5IEICCFxhiJD1pSrlrjd4uKJQsumdFrMh9252b+rDP4f
 GBoIOzva2oWldR4kCvsUoGynOBzUxkfuTfJmSXAB8KQXaIPxBVfkyf+eld9W9uyivBFxhz+yw==
X-Received: by 2002:a17:90b:5830:b0:39e:6c68:c787 with SMTP id
 98e67ed59e1d1-3ab3acea00dmr8175486a91.61.1791798729006; 
 Mon, 12 Oct 2026 02:52:09 -0700 (PDT)
Received: from
 codespaces-2362ac.m2fxbej512jepnsor2itp05j3d.ix.internal.cloudapp.net
 ([23.97.62.130]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab36ca1e04sm16506403a91.1.2026.10.12.02.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 02:52:08 -0700 (PDT)
From: Seongjae Jeong <jsjlee1020@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon, 12 Oct 2026 09:51:30 +0000
Message-ID: <20261012095130.17231-1-jsjlee1020@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Headers-End: 1xGCha-0006Ha-OS
Subject: [f2fs-dev] [PATCH] f2fs: detach remaining IPU bio on error in
 f2fs_inplace_write_data()
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

add_bio_entry() adds an IPU bio to bio_list and takes an additional
reference. However, the drop_bio path in f2fs_inplace_write_data()
only calls bio_endio() and clears *(fio->bio), without removing
the bio_entry from bio_list or releasing the additional reference.

This leaves a completed bio on the bio_list, allowing a later
submission path to submit it again.

Add a helper to detach the bio_entry from bio_list and release the
caller's reference regardless of whether the entry is found.
Call this helper in the drop_bio path and call bio_endio() only if
the helper successfully removes the entry. If another path has already
removed the entry for submission, leave completion to that path.

Fixes: 955772787667 ("f2fs: drop inplace IO if fs status is abnormal")
Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>
---
 fs/f2fs/data.c    | 41 +++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/segment.c |  6 ++++--
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6d4ba5e77906..ca8fce5ad778 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -989,6 +989,47 @@ static int add_ipu_page(struct f2fs_io_info *fio, struct bio **bio,
 	return ret;
 }
 
+bool f2fs_detach_bio_entry(struct f2fs_sb_info *sbi, struct bio *bio)
+{
+	enum temp_type temp;
+	bool found = false;
+
+	for (temp = HOT; temp < NR_TEMP_TYPE && !found; temp++) {
+		struct f2fs_bio_info *io = sbi->write_io[DATA] + temp;
+		struct list_head *head = &io->bio_list;
+		struct bio_entry *be;
+
+		if (list_empty(head))
+			continue;
+
+		f2fs_down_read(&io->bio_list_lock);
+		list_for_each_entry(be, head, list) {
+			found = (bio == be->bio);
+			if (found)
+				break;
+		}
+		f2fs_up_read(&io->bio_list_lock);
+
+		if (!found)
+			continue;
+
+		found = false;
+
+		f2fs_down_write(&io->bio_list_lock);
+		list_for_each_entry(be, head, list) {
+			found = (bio == be->bio);
+			if (found) {
+				del_bio_entry(be);
+				break;
+			}
+		}
+		f2fs_up_write(&io->bio_list_lock);
+	}
+
+	bio_put(bio);
+	return found;
+}
+
 void f2fs_submit_merged_ipu_write(struct f2fs_sb_info *sbi,
 					struct bio **bio, struct folio *folio)
 {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 089a62c054ea..63da4c2a9553 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4357,6 +4357,7 @@ void f2fs_destroy_bioset(void);
 bool f2fs_is_cp_guaranteed(const struct folio *folio);
 int f2fs_init_bio_entry_cache(void);
 void f2fs_destroy_bio_entry_cache(void);
+bool f2fs_detach_bio_entry(struct f2fs_sb_info *sbi, struct bio *bio);
 void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, struct bio *bio,
 			  enum page_type type);
 int f2fs_init_write_merge_io(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 794e0d99fc7c..6bd60746d140 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4300,8 +4300,10 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 	if (fio->bio && *(fio->bio)) {
 		struct bio *bio = *(fio->bio);
 
-		bio->bi_status = BLK_STS_IOERR;
-		bio_endio(bio);
+		if (f2fs_detach_bio_entry(sbi, bio)) {
+			bio->bi_status = BLK_STS_IOERR;
+			bio_endio(bio);
+		}
 		*(fio->bio) = NULL;
 	}
 	return err;
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
