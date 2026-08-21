Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EF0C5DF87
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Aug 2026 01:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=l7iec+UHLT0LM+OO5gZyslCEhaDCgFZpZruVmwMTkR4=; b=Em33STaKfQJzSsKnnb1gLQ5IcJ
	zc0scRKz3D+OdceXce0XSYw1kj1WSCiu589JtXWLcdeIn2HkfPFgo8kUqv4FMNDHO9ngbCRcaJQGK
	B9ehDJTKYefHzowmjcD3HxXRAGhV3lkum7dolfTSjFuwD8yR2fZBfCQR6mnNuhZNifJ8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wxDtr-00038y-8T;
	Fri, 21 Aug 2026 01:18:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wxDtp-00038r-Jn
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 01:18:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SGrJBR4hZ4Cq2aRtS5KUrRUKYwX+uBipSwTzUU8zxuk=; b=DGL22RyC1Oba4JiFOJBDRrrh+u
 Mt9phli+gyYZMCUXjKiilQIpNnyaKDjI+axKpKurV+c6oWFCNhsIInMdHp6OvRxgYDqbC36EOUUeQ
 xSxiXVSpaFh3cHDrdG1Keu1Kuy040JRT3uxIqT/w2PMXmnSzIt2SvdRZZj4mixFgoeZA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SGrJBR4hZ4Cq2aRtS5KUrRUKYwX+uBipSwTzUU8zxuk=; b=S
 mWBjCJwhmYzM/OuD0frPXIuzhc0kDeTeX3DVO3JPHqV6Yba2rE2wFVM7o7iG/gI6VvkOGvqo+YMPE
 +mKCVc+Z9hnb6SyEjy5Yq7226uxtD1eLC1hhX05lfO8CYNY35+CB9ZpqKTOZTcS2SOVtwFjMb5KCq
 eHCKLZJng1KqgER0=;
Received: from mail-pl1-f181.google.com ([209.85.214.181])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxDtm-0001dL-NQ for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 01:18:23 +0000
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2d0407aedd6so5627845ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 18:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787275097; x=1787879897; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SGrJBR4hZ4Cq2aRtS5KUrRUKYwX+uBipSwTzUU8zxuk=;
 b=XxkHmCtBP+ujt/32Dq63ZZE6NpVBLqYWYYsfLWZds2ZJ5kCU36lZId6zKcEykSs4uF
 F7tdiyfolLJMmIgu046OoepMC9Qb5j86BmB8JpJCzcFfIhpBIJbxVIb6vRFQuKEtUmaY
 7jGUtp7pchY5OyE7zLKrIB+SQoCXcoxqbdFhRRUDx6vgDUjZg1UN1a2Cq/6QhnLLTqJa
 w3Xzasu69BqWo2eaU9+NfTfZPrtgP+aw0ZP5yhkNYGb6Ns9J/eUhEZm9bCgodZGQwM/M
 Pzm8/aOqtA1yXZj1yoiofkKqtoC65mAcARoNh8CWgTtHwuCRs7ZcPCWmGGIxQE9s2J2i
 yV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787275097; x=1787879897;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SGrJBR4hZ4Cq2aRtS5KUrRUKYwX+uBipSwTzUU8zxuk=;
 b=Rvt2/U8G6hOb1QMUaPyCtVwA3hSU71IHvHmT3SYjGrMnOgmPFNDDjXE59BTGM4jHBr
 eGZyk6Dzy6XQd9FX1m5FdzXBn8l1SLRkBnCI1vEud78wqFjIVIgI9Is1DyYkfW+1JaEW
 CtwOhwqKwTQ4Mn2ceCcnKiT9d2u1xd0Ft2IZKH5ZIo+UcYAVeJJwNuOKmPjTqnr8Hsiv
 j/+4SegZ0OzONLQ0sTHuh7V/yCMdsP8QNMeVWp+fTJiy5Ana1g/4V2zsamAPJ1CnY95r
 v2SFilMoXnH/BqV8vjcNUIkRB10fXMHZzzwOit3oP0uzJMZ3ygtz0bldT6UGEQm9Ws8C
 qnHQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RohgEyQUVxmBmYKDDi+elE6XpZ5we7UjaWYaDhg5HJUivwtQw6RTMkanRSzeOzfL3/HX9INPvtIPC19gBT5JHe3@lists.sourceforge.net
X-Gm-Message-State: AFuF++lkBf3Nt4F6CcRFi3RlF7HwuJxzSXsy70zH8FXJMWqH3ZC3902F
 nqMLJVcDW0fhC/DyJvlEsn3MKeWMaTWPfc9uOLXv7g6NtnF0f98ywxyy
X-Gm-Gg: AR+sD12pW5049OjDegn9qjAs5lJJzGTHvTplnYXJo0s6YvjYXg5fXJ03DnSqDh4fOEK
 dv32olX9TtdpVcWJyrG/+FDgY37fjaMUl0TzK3LwYP4g5TYPqQ+QtFSo3h+tG5uJc/aAvaRaBKF
 hkUb+z2oR9rbUPBftHAvqmUWB64axeRCqwHfrIW5RBeBmY8/GuyntdFveG9KPp9bZDcL/8vPV2f
 e8SRGaF5vSHR2N+pqpNkWHK2ycwzwdMM9ZWxiF+Aqcl0eb3fDzXmf7pylZjde1KSR6M9tLH1TZU
 oD5p/0IvgT8gOsS8oL1iUfpG+lOkwc6d7XicpYDkI3jqx16SAbwTR3RpMyq1HeMwhvpT7n5o4N6
 bjZXUpmFOTb6ZcY9UEO1VVUeBmeORlAiCTbPXftxzAiSt+2NSMKuS5Y1TBmEVfo0J9s7UcoZpp6
 YQbBaOLOvnICKR4zlHVlIIocHYccI/uUMmpkR83OD8lq1Uuc3uUzSLYhPN0xi/zEBLdrNRhfnAj
 fFk6nXsM+5Ys8/XJTwR0abEhkagveD3+3CNk9mqzE1N9jot+7QqKe5Qw5dsb8fKC5k5ZSbumgUI
 QakAiKC36wg6
X-Received: by 2002:a17:902:d4cc:b0:2c9:aae1:a61a with SMTP id
 d9443c01a7336-2d64b0c6a16mr42930375ad.14.1787275096885; 
 Thu, 20 Aug 2026 18:18:16 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:f50e:ef36:528f:d8d5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327d6168e5bsm10374357eec.1.2026.08.20.18.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 18:18:16 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Thu, 20 Aug 2026 18:18:12 -0700
Message-ID: <20260821011812.2938998-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
MIME-Version: 1.0
X-Headers-End: 1wxDtm-0001dL-NQ
Subject: [f2fs-dev] [PATCH] f2fs: fix error handling on device alias check
 in rename and unlink
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
Cc: Daeho Jeong <daehojeong@google.com>, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

In f2fs_rename() and f2fs_unlink(), directly returning -EPERM when
encountering a device aliasing file bypasses the cleanup path.

Fix this by setting err to -EPERM and jumping to the proper cleanup
labels (out_dir and out) instead of returning immediately.

Fixes: a737e409a3d6 ("f2fs: support dynamic reserve/release for device aliasing")
Cc: stable@kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/namei.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 784f636244e1..b9b15c5d28de 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -571,8 +571,10 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 
 	trace_f2fs_unlink_enter(dir, dentry);
 
-	if (IS_DEVICE_ALIASING(inode))
-		return -EPERM;
+	if (IS_DEVICE_ALIASING(inode)) {
+		err = -EPERM;
+		goto out;
+	}
 
 	if (unlikely(f2fs_cp_error(sbi))) {
 		err = -EIO;
@@ -1025,8 +1027,10 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	}
 
 	if (new_inode) {
-		if (IS_DEVICE_ALIASING(new_inode))
-			return -EPERM;
+		if (IS_DEVICE_ALIASING(new_inode)) {
+			err = -EPERM;
+			goto out_dir;
+		}
 
 		err = -ENOTEMPTY;
 		if (old_is_dir && !f2fs_empty_dir(new_inode))
-- 
2.55.0.766.g2966f0265a-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
