Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20001CC6B12
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fUohVLW7kn3V1jszPbuowDjRx8EC8O+y5yoa3IcuXuU=; b=kKPUvgSELZmGrFinVz2TQ/eLau
	BjAJjWm9fVGsq9UJYmKGqWoAL3FuyT84RNGk9n2rIVYRpprAJY7CvhEGbP4bXzLTlEdKc3a43bqeA
	mXEuBUHXf3hJgYDtqT/V9zcy/ubyfgfMJIbjn7Pdvqyp1gGGeTFzQ6kH4MnU3sBD42p0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGeSP-0007Po-Um;
	Tue, 13 Oct 2026 15:30:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1xGeSN-0007Pg-K2
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 15:30:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JkzKGFG3myHoVz2H3BeUHaZ9CQAbPKe7kFhV45l+XFM=; b=PUR9Pz3IPHwozlR/IBWjP12kj6
 3ZJYJbGTvd1FS3ucD1XpUjwYyZRFy0AWJ2VemkFXHckd10wYc3eC8Wbs4ccZBXETcDjjs60HiLtxU
 6hy7y4mOW05csTjVitioZZgu3VKsj/yU6mFiFmJWVccGT8ZE3yR91zzT8dBDeMcU03RY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JkzKGFG3myHoVz2H3BeUHaZ9CQAbPKe7kFhV45l+XFM=; b=b
 M8MfVukguTjzNJy7bnAbUZX4Z2tGKkXfbmkt/fCAUT5CrH/4ol6HWVVHrVBy2r19TNZmBUY89AWQD
 uM76V2RH7PU8+0pGtvZ2tJs/Mn0w719x9WhaF4TlZA5XdHQawgyTPcgV9gdYRyHffSBpM5oApotBm
 2I79bQbzWR7ygDCI=;
Received: from mail-pg1-f177.google.com ([209.85.215.177])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGeSJ-0007gQ-Ta for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 15:30:23 +0000
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-cc4e9e56e9aso1062733a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791905414; x=1792510214; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JkzKGFG3myHoVz2H3BeUHaZ9CQAbPKe7kFhV45l+XFM=;
 b=cBbBe60beF4kHKVjMqCZ4ugNnQMJwiqG3AkuppGtiErYmw6GC3ErjYeRu+vrhKL+cD
 2xl9Ov///VqHSrZAO+U9/hPXRDFEzVqmQ283pBT0HbbsxkdLyDd1y/kc7enbX0GV4jn7
 ld4lscmmNA4m2lwSJ/jUZi2lRNmS/lO/gwHuC2gZFBC9B6h6+Nuql4hq/YC4DXTsyg8n
 3BsPs5jhOQtasx4YpSUqUfXWA0fJjXOJuSsZ+Dw4Qboi8KF1YNNDxbODnAXDlT3PBkQ0
 DwpxQHBj6EJuveI3OadVo54oT6z9c+CM6JSDJpu3elgzwJaBHaAvHNKNrd10EzVSzYIK
 GOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791905414; x=1792510214;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JkzKGFG3myHoVz2H3BeUHaZ9CQAbPKe7kFhV45l+XFM=;
 b=TePSzzIrxoTiuc/zUzgrJQg4WFJohh3mEU2WNATlIl9O23vuoTtU+GV4ICJk2HyQGN
 ciR4tz3WL2gFRTc+VHl8LbzDqbwaUVOr1NA4GjDYLG++KjnhvB6xMPibRBUJNqWP5d4D
 BqxiFnCCpzLOnbmro8TQJwtlyOQ5X6N5xv0yEDxGT/Lda4PBEjy+KzBc/geO6NgvCo+9
 V6N5dYIac2M1r0lTtQHpgk6Horx96juoaHEoXzG/vfRTieVDDTAr08TulLfL9dXnTQxK
 Hqy+PWaeSofj/A8J+CX2Kv7FpfvJPl98wuiHITDUq3LRmBYVuQNx7gvMtlVagciwG80B
 CR5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBylJtxrZLeeFRNhuGJFy5CH0+jBWPRUBmUltVMIA4/IcX0/m8GQY1gQpRfJQQUzY6s2xxAVKYdj2avH0w+g6+ST@lists.sourceforge.net
X-Gm-Message-State: AFq9FYL+X+vtkaO0eLFgHY2hC9j7h0cYbHXtTqNn+z6hn5qNO19J8tGw
 M87X2NIKa6ZjbCiTyBan5NCaY+yLSCXxjNCg1lGrlmjZr4Li1axG2Fip
X-Gm-Gg: AYBFou0leEg07zXu/Mv1ATk4ukLmFkXHsJljBaGHu9AwdVWb1q9FlDWSt6apFW6SHGi
 0uRTjMbIYsaLNdhsNd+qmUTeRXbMcNGGUtWtKczCJ0ehNzbdIsh/t55xgi+2D6EAGT1LP1BGdb0
 qKKE2dn2SBByGDEIM/ChKezowx0FYxtf+KIVlLoFdH4GMF3XFTWNtm44a10jry0cdb6b0gdwgff
 lwtE0DLggGEgttlaA1OC7OIBPq7PJnu3X5M4Aqq8NRykLQySg+CbG7cJLsJ+dmXP7NpMF/cx5Vr
 khUUdw/iwFupN6PgJGxFmfsUM8V1/Ve4jIWOaZfkYRN3twvbh2jPF4tjIicCxNrgok72T/xOpKx
 lzjO++REltDP6ZCTBPL6mZs4llM/6Qp5Y5SvsIS8XSQo/fIRHwXvQ2HIfTcYXVUjLriXyBIAX4p
 z5StdFOj5EUqbe/jwvu7s3nxQH3ZoU7usHPSZFlYBZY7j+B4E81s8aPM5OLxUbhG2hXwcRDXEIz
 2ZWjOFLEjssSRRVW5I9o5KSAznhC0sJlusjTou/8BRVa76fyPoSLKAKaEH5BSyozYW01X78Bbpg
 0ZsM8HDSTDOhRBxa
X-Received: by 2002:a05:6a21:1bc2:b0:3e0:afe9:ba4e with SMTP id
 adf61e73a8af0-3e16bf4c1bemr10960689637.67.1791905413906; 
 Tue, 13 Oct 2026 08:30:13 -0700 (PDT)
Received: from f2fs-test.c.googlers.com.com
 (225.134.16.34.bc.googleusercontent.com. [34.16.134.225])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89d804e8586sm16590b3a.42.2026.10.13.08.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 08:30:12 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Tue, 13 Oct 2026 15:30:06 +0000
Message-ID: <20261013153006.1200086-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
MIME-Version: 1.0
X-Headers-End: 1xGeSJ-0007gQ-Ta
Subject: [f2fs-dev] [PATCH] fsck.f2fs: do not roll forward a
 checkpoint-disabled image
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

With checkpoint=disable, the kernel does not write a checkpoint at
umount. The last checkpoint is the one written when checkpoint was
disabled, with CP_DISABLED_FLAG set and without CP_UMOUNT_FLAG. The
kernel never rolls forward such an image: f2fs_fill_super() skips the
recovery when CP_DISABLED_FLAG is set, and drops all writes after the
checkpoint.

fsck decides to record fsync data only by CP_UMOUNT_FLAG, so it walks
the warm node chain of an image that the kernel will not recover. While
checkpoint is disabled, SSR reuses blocks written and invalidated after
the checkpoint, so the chain can point back to a block written earlier
in the same session with the same cp_ver. fsck then reports "detect
looped node chain" and fails. xfstests generic/320 and generic/642 hit
this almost every time with checkpoint=disable.

Skip recording fsync data when CP_DISABLED_FLAG is set, as the kernel
does.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/mount.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index 8479ed1..98d797e 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -4096,6 +4096,10 @@ static int record_fsync_data(struct f2fs_sb_info *sbi)
 	if (!need_fsync_data_record(sbi))
 		return 0;
 
+	/* the kernel does not roll forward a checkpoint-disabled image */
+	if (is_set_ckpt_flags(F2FS_CKPT(sbi), CP_DISABLED_FLAG))
+		return 0;
+
 	ret = f2fs_find_fsync_inode(sbi, &inode_list);
 	if (ret)
 		goto out;
-- 
2.56.0.385.gd3acb90ef8-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
