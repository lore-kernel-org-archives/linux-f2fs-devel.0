Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6639FCA5FCF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Oct 2026 18:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0FYGuFZe/kEpII8c6gmsPg3Th+2TmpQzkXgo99LBbME=; b=e6dfQ9GyGJgYETxG3aYM7PzWeC
	j5EpBWdAl+L4B20hjTyF5S+0akK0D8Kf4zINwbwXU85rFdlvsXzTPRkDQ0xRrtXcPypNEzlsO4cxe
	cgbxkDdxs9WflQT8USy0ephuAAnmCmPK/g3TgtJ4AOTSRIOf2FUtXpr4OzogNC7dqPNA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCLCZ-0000rU-Np;
	Thu, 01 Oct 2026 18:08:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1xCLCX-0000rC-Ro
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Oct 2026 18:08:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lLND6mqvtrw/hYdQey6ykKNo6QnpNvUQNznvBKs4ZJI=; b=gLgmkAgqBhJ9tyETdGoZZSPka5
 XkQL9vry2+McyuPewoIPljnsOjZbBuQah93cvpo2u0UKyw5QEpRRbK/F+akMX6vIC1uz8KDJHSMQ2
 JmKSpfb4+PEkuNrdX16KZUCv/eL+0jTM/9u3XMA+G1Q/e3FKRcn2OwVXNniMt+LKpiQI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lLND6mqvtrw/hYdQey6ykKNo6QnpNvUQNznvBKs4ZJI=; b=C
 5/6c4a74pguUpNNt6zNEzIA1JNFNjjxtgpm+0W+VXb1aLJ1dky33V9vqzRtOUIi3VKHSEoRhGf9vN
 HVz/AFnxdV4DyTRfbjnDmNKfGSwsigb3l0q2bq+TfEqZadpLikEJJDWlZCZwUgqmGf4JWtpv5kqHg
 3u2UGD0UhFkmVu0A=;
Received: from mail-pz2-f42.google.com ([74.125.228.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xCLCY-00029p-85 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Oct 2026 18:08:14 +0000
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc797656e36so2455574a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 01 Oct 2026 11:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790878088; x=1791482888; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lLND6mqvtrw/hYdQey6ykKNo6QnpNvUQNznvBKs4ZJI=;
 b=Dnvbz0xSsL07ROjLk8DbCsJ3L3MrHqU+1cU5fCgZgtz2akOqEZkNEurK0Dw8UFN4l6
 DbzLtypHgZ2irMzbc9LVcuTNuKLoQO2nfmLrN4OfKWoA2l4i/RV1fXr4MVDdBiep+aRZ
 3jdUCYy9nJyTj9acvovB1CyqfITIF5qWVhlEpZT9CnoFob0qBMfHjEJ43wbErPUpHdBB
 /+FqPhLX9K4j8sb59nbuVgR3A8cze/ulIWihBv4kCD6KQxmC9jWTGs3fFgCfly4eB6p5
 zqN/RIn7fLhcPSYY8oxwVvuJFNq3twbW5HGBQpAPgzMSjSg3ebaTRL9NIyRrLDuMJ/VS
 WOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790878088; x=1791482888;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lLND6mqvtrw/hYdQey6ykKNo6QnpNvUQNznvBKs4ZJI=;
 b=Lu9HPXOmoUaorpt6ZO5maXzH0oL/mObrq5FSFDj3Bn7l7sYIa5VmerOYfaYqQiIOAn
 2CaL2bwPrX213KwuRJVK3y7hbcNhd8YKuxWNi7L4BzdPy5X64qlCahaT4F3u7rkcg6I4
 2wwitweogXg+cbFOH4C/ET5ypsfp6ToZ0XUHFPXtP4he05ojkiy1/BXdlH1fuElV5gag
 jOupMdvmt3eKq7qz9L4tYkznr89qGo0jw6kO+BtRfggaZMsRhx79sae9+QNCeTH0kvCn
 P03QmC/rV9xOVGJMDA1XaqUPCq+oGtV1pZ7yNhRjlrQ8kwGmei7t1EY9190M2hoTwaIW
 qczg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxVmastoPtwYs6vsIJaj4JAY/Uf7Zasy4G7H22cUczRMFgAm0Bj1pk31MOB507xUlV+E5so42KN79IRQq521lR@lists.sourceforge.net
X-Gm-Message-State: AFuF++mID9JuQMsgEOIq1bf+6zswTD0LgRF+a6oXNN2XgFtYgndaxPRm
 5w6Ps67Xb7Zg6nmgdGw+BcA97ptZz8QjJiMJEHfSGwfSeq53kC5ILWx0
X-Gm-Gg: AYBFou2j7MXQfYBnUEbdWvzXuwWEBRMS8FvC5Q8AIjNFVRLn8S5fRWhqu+VSRvGpZGc
 VXxMCtNlp0X8L0Fml7ddgFkfiL7xqEvp3/pglOnuxdvZJa3MmPdTt57AER10hgqDcqbKnvf7dK5
 /6jLYdhxx5/YDmZLggT+OSHHKh9p40elK8MPQrHxl2eHeKvSiO2gTHP6tFr+4qUs/mt0wb8keJh
 1psitA0jQSWzuZSCSNoDTraDQQYFAoGLqyUUJfYCvR3egZV7B2tcUgQHPtW/z6ViSBvQD0PYPRO
 2psYG1W0wpINKpdtWNsxQ4bRkWxOV/PmUS16Jwk+fLerE60RhH83iLHcaPDvo+AQ3J2PuS7BhoP
 B/Xcu58CrOD8imxS+4ptrj0H9ejmtOFm02d+XqXdRJ7YL55aO+0+cx7JlqZiEQ0JklZ2utmadRM
 RKyCqTopuE6i9m+hi5iyFDFZw/unTYTrkqpCrT2f6NNVoFKsSt5ObpEsmtgcSYosfE4Nj534utw
 rSiV39gGwpNI/tlZS/Nb7ugEUlZr8rg/mKWzIjy6wGhK39YuqhASmqh89oS7zry7BuODc61gi6v
 E/cYbCYQPUUf5ro=
X-Received: by 2002:a05:6a20:918c:b0:3dd:fdc6:ee7b with SMTP id
 adf61e73a8af0-3e0bd44aa4cmr130932637.66.1790878088371; 
 Thu, 01 Oct 2026 11:08:08 -0700 (PDT)
Received: from f2fs-test.c.googlers.com.com
 (225.134.16.34.bc.googleusercontent.com. [34.16.134.225])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc9f737a231sm949a12.18.2026.10.01.11.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 11:08:07 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Thu,  1 Oct 2026 18:07:58 +0000
Message-ID: <20261001180758.2099491-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
MIME-Version: 1.0
X-Headers-End: 1xCLCY-00029p-85
Subject: [f2fs-dev] [PATCH] fsck.f2fs: enable fix_on when CP_RESIZEFS_FLAG
 is set in auto-fix mode
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

Commit 9a31cefa2966 ("fsck.f2fs: allow fsck to fix issues with online
resize due to SPO") added logic in sanity_check_ckpt() to recalculate
and fix user_block_count when CP_RESIZEFS_FLAG is set after a sudden
power-off during online resize.

However, sanity_check_ckpt() calls f2fs_should_proceed() and checks
c.fix_on before repairing user_block_count, while f2fs_should_proceed()
did not check CP_RESIZEFS_FLAG when setting c.fix_on in auto_fix (-a) or
preen (-p) mode. As a result, running 'fsck.f2fs -a' after an SPO during
online shrink leaves c.fix_on unset and fails to repair the checkpoint.

Check CP_RESIZEFS_FLAG in f2fs_should_proceed() so that auto-fix and
preen modes properly enable c.fix_on and recover the filesystem.

Fixes: 9a31cefa2966 ("fsck.f2fs: allow fsck to fix issues with online resize due to SPO")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/mount.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index 2fd8e1c..8479ed1 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1515,6 +1515,7 @@ static int f2fs_should_proceed(struct f2fs_super_block *sb, u32 flag)
 	if (!c.fix_on && (c.auto_fix || c.preen_mode)) {
 		if (flag & CP_FSCK_FLAG ||
 			flag & CP_DISABLED_FLAG ||
+			flag & CP_RESIZEFS_FLAG ||
 			flag & CP_QUOTA_NEED_FSCK_FLAG ||
 			c.invalid_sb & SB_NEED_FIX ||
 			(exist_qf_ino(sb) && (flag & CP_ERROR_FLAG))) {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
