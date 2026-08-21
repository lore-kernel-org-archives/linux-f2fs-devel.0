Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD61FC5DF93
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ixzgHJU7G6tQBLC0WQH7+uj6Ch6d0OIngRAYCTu/Z/M=; b=UEyZh5tP3V7YmDd94FTzRO2OjD
	UaGyCxSJdptSS4ubA6DelJ6ApsDVVnQ65fFnU1ebR+aDcxqw6sFN+TLNDtgLQoOJU+gieoTLf/QeV
	KCqtwtZ0Mkz0y60SCi4lMTshSqLUHwl3RPiwUHgACTh0b7pfilFi3vmtaxIcYvUTZHuA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wxQ4A-0000aE-F3;
	Fri, 21 Aug 2026 14:17:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wxQ49-0000a8-Rs
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 14:17:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XGD/qJJ3KEj6zHY2VvUqP6PvO8ZM+d/JB8kcTXQ76+M=; b=fucVBFFOvtP9Bc1DzJJB9Tmdry
 SwvwyWd/mjaYgykuU0jAgwO4qhfu6bFTRhUWTiEot7sFmYxzFHr0TNqTxb4rDo5qloyJH0q655U3z
 DwN7NGd40GDB0kDOCtENR1Zy4wHgOU1b1iL0Fq15Z11iWturCq61pJk+0stXGtSx9Svo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XGD/qJJ3KEj6zHY2VvUqP6PvO8ZM+d/JB8kcTXQ76+M=; b=e
 81fAp3yRrXK/LNb/uSD2MCvxVpSF49fejWE79HucpKrDURh5iAlB2EF3C8YPKO5lkshbtOxlxLErO
 XBoum3oGmz7wF8jptNMop9gD5LIKp0b4UNVhKdLRsO4rhzJ7a3ZosR4cKsfP8D7RTZ4GFyh4V4qzH
 HBKogMlhmOtyPt9I=;
Received: from mail-pj1-f41.google.com ([209.85.216.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxQ48-0000a6-GI for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 14:17:53 +0000
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3900e39d935so947375a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 07:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787321867; x=1787926667; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XGD/qJJ3KEj6zHY2VvUqP6PvO8ZM+d/JB8kcTXQ76+M=;
 b=WL4Z2DlwTXeOcSbucQ7xJUwF4Oz7c3Bnkv+lvThDexCPXM+jWt7pWhATMWF0udF2m0
 fniOcf6lwkdjd8jI7onbW1W3vsyzpp/tNhM/4Dp7BiFWRC0YA1dhcc7omNrw71VyYsyG
 ZUtcunbnles6is8vPKZmXd+BOvRAtxsNmIJL6qqidp8asW+2d5hicOqN5/yVR8FLF7CZ
 pZEN21K+BQ5SY38HsfFR57YPyXSQyVvMVQIr1r1oQAtrSZOPWdg3n2aBuyEaUvgwGSAr
 Xg4PP66Z9ZGblpAlzbOL1LrA8uoVrFmZzEeBQzTxD4+Uo5btwFLe1nSwE09YD00vGVDV
 1pRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787321867; x=1787926667;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XGD/qJJ3KEj6zHY2VvUqP6PvO8ZM+d/JB8kcTXQ76+M=;
 b=gfgEAMi1mwxYWyMop3JwtOyyOzoUWlBEj+M6Z3NkdTonw1F2Magr3cSrFfEemabnUu
 TX8yHI7o0CbezUUINylE4iouaemsbgcTOwWOKVuC1J0DSeccOAD047eq1XbI/W42Z2nx
 6+8T1uJ7xop+9IZxqlb2AFJBbNAY1XAyeI0uEaRrZWhPYWkt/iUoJUbN4y6Q653wK6H6
 j3r8GOcH7Y9AhVgPH7+ocjwBqWjkaprNCDLeRUUnCgCgukE0feE0FXgfZa6nxK/uC1Lq
 S6ITRGf6uDQzh4mJIfAHPuWsrZdOcyH+M+O0U/V1o2h1cqG+q/REDm5UJlJe6Q+LMKqa
 Q4+g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrAdBh+17wwuF8g0t1OaNKwtF8Bv8aOiYOEYa57bdTWdXlsQlaxNhqPwXpcfOq1fs6/d1SHp15GgRmBk6q/BRDm@lists.sourceforge.net
X-Gm-Message-State: AFuF++lmuQzSyvyF/xHcYkh96UzfUuOPUy2uZVqQy3jZA+w/GmDHsu5F
 kWzqMrjr4Xh6YBMBC0owbD2HZA7Mgwvem+/xxHE3Hcg0x40gdbhcIaDN
X-Gm-Gg: AR+sD13xvXicpccJ4Cmi2Dmu0bE2XVVVBqWxhOyp6+WTVnvoN639Cw8gY6Lx91Leqks
 rSXQmr/uhq1KOv2DsooTQEH8WvmynMH1yVCmupwjE+DiMvVLNTfvfqgzNnt+qIEwMLK1TefRMCf
 73QmUNVpQK4kgJLDetr5EAfxpNWISi+IBP0epBcNNx7wPeukeIn6MrPs8+NBtGw+9DcbQxQo7mt
 U0k57WsPST1qNDa8wggrlBUN6DINEBuDJoo9Dtz7U6B1WjGLAPz28yf0NgSMoKtvYrIMiQZYNms
 gyBoxQxOVSkjJ+e6rPljCHICbIK+Doj8aOZiBJjh48YelqB4j91cJdDIRDZcGlAvMtUfG0zXLz7
 uyN1/ABGgk5PdZLMUamBheYy1PwoGbFYCAzpWIhxGtfxxbpyFmhnu2LbhRRCfwi6/tJeuKxfAov
 cOwPUEqmVampJpM/mCA9ZI5HpKuFvmTtNFEdhw3tkpGPTCHB+ElLblzRWa3dbdSXagNA0hCReWz
 Gv7LKU4Jtpu6nfmozQXXJATE6s2EFQh1DeNighzch1AIsxW0zSJ9AEYkg+Eo+Q4Zb6xPCtSLYIy
 AVx1yAXKtsj3
X-Received: by 2002:a17:90b:5907:b0:36a:5d1f:7b6 with SMTP id
 98e67ed59e1d1-395c33ed38amr13024301a91.2.1787321866681; 
 Fri, 21 Aug 2026 07:17:46 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:f50e:ef36:528f:d8d5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ae5f1ffsm42250523c88.13.2026.08.21.07.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 07:17:45 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Fri, 21 Aug 2026 07:17:42 -0700
Message-ID: <20260821141742.2678300-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
MIME-Version: 1.0
X-Headers-End: 1wxQ48-0000a6-GI
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
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Daeho Jeong <daehojeong@google.com>, stable@kernel.org
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
Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
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
