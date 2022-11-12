Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89183C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 12 Nov 2022 08:33:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1otlxI-0004vM-Vx;
	Sat, 12 Nov 2022 08:33:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ssawgyw@gmail.com>) id 1otlxI-0004vG-8S
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 12 Nov 2022 08:33:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HpSAL+Frp6pI5uZevffauYMAMF7An7PWhGzNk6t7irc=; b=ZKCRCEQVI7bNFHaRHUM+p0e501
 PLznyYz0e6yHcreOnkr0bPH8ZMtjPKDqaQdmbSWxn2Cq1EwysAzyHk+WAX8BuXe5L8XAfj4TZOKmK
 7uEE1VndXy8vMKPfx+qTePpe7dqaiCApSlVokLJSfWAREdJ5RtgDf6mjUvK1RU1gteOs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HpSAL+Frp6pI5uZevffauYMAMF7An7PWhGzNk6t7irc=; b=SyVYsi8qlDMPIyzR59iMbRknmO
 K/8Zq9Yfxf1i25DZITiY9FEtppSLfX0MYbv6AJcbbdL6YAw8mKWnwkOco/cISaUxGZJzQQ15pDnO6
 ZwjBKtjvenGgTGNhU7UiZ2aHvQ+Onx8VmRMb7Gbj6KHKJi1eLR0ZhV4/bhkOLHE+nYes=;
Received: from mail-pj1-f47.google.com ([209.85.216.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1otlxH-005EBJ-MB for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 12 Nov 2022 08:33:36 +0000
Received: by mail-pj1-f47.google.com with SMTP id
 q1-20020a17090a750100b002139ec1e999so6548021pjk.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 12 Nov 2022 00:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HpSAL+Frp6pI5uZevffauYMAMF7An7PWhGzNk6t7irc=;
 b=BjdmEmrRmKb1KewQe1wjYXRVdQ/+pvyafqjJ9iLoUU5lLUjrFYCLilfD2swqM8EmvL
 Mqws98NeNcg21hJWtyVmN7Mfn4wEv911g1lJbhC9FHAyiKlzIN8W8xcG33G0FOdXn44/
 eXS024oauWVrIh64Eg7CBLazucVLvHLol7/DzM5W1Sgk9W164p3AeqeHVonaPxZyarIJ
 ItnN8XGiFU/3cnzMlrcYfLBv0/QzJ03AlGUKU2N7C5KuFG3zcceH64pZxHqsrCCWV3GL
 Xrm7AlApa4KRWs0lyP0jElIJCjC8StEW4ELpufPTfBGf88QwUYsWrmOU/nogrchzfSqE
 7DDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HpSAL+Frp6pI5uZevffauYMAMF7An7PWhGzNk6t7irc=;
 b=nZgakBiME2TewHbYIXfWtTDha6Oug10w132V+DolXemd8IjXY5YuxTbVxHx2K8AxvA
 CMDIRdWeysoBCkjMczJRo+mrHMuijjgRx/i4xGzy2NnxWA7LazQjSEGNIqVzxUlUWy1Y
 HKGGpG9Iu4ZABkNFZEIL1OJaZhWiz+x27aaXdIdLgzSbGRj4W0qU9+NM4wQSebX+mN//
 xtPuOhNQmgtwfRe3ala4Z77JgMl0vNRU+QzQfT2Q2tbxAtlUiPR9kEcZVEKe9caaZ8H5
 WPzgAXBQ/CcRrXUFYHwEieanYl1E9miHnh12ON9uROnKcGOzyXFrFep78FVauSgRzvMS
 BkYQ==
X-Gm-Message-State: ANoB5plPoejBUzq583Wqj1jWykt5xDOz4EJBuPl71OC36ZmsehrZ28RV
 muoSv9Id1NS+LyugLqULIESguDGo+oY=
X-Google-Smtp-Source: AA0mqf7tE2XuEywH3c3EIQLoY6KbWyTmYUek3jOnXZumk72NZnsdIP8ou5suR+4dwNG8D8yl5ormYw==
X-Received: by 2002:a17:90b:48cd:b0:213:47:57cc with SMTP id
 li13-20020a17090b48cd00b00213004757ccmr5459327pjb.174.1668242009382; 
 Sat, 12 Nov 2022 00:33:29 -0800 (PST)
Received: from VirtualBox.. ([129.227.152.6]) by smtp.gmail.com with ESMTPSA id
 i11-20020a1709026acb00b001870533c443sm3066927plt.236.2022.11.12.00.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Nov 2022 00:33:28 -0800 (PST)
From: Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sat, 12 Nov 2022 16:32:50 +0800
Message-Id: <20221112083250.295700-4-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221112083250.295700-1-Yuwei.Guan@zeekrlife.com>
References: <20221112083250.295700-1-Yuwei.Guan@zeekrlife.com>
MIME-Version: 1.0
X-Headers-End: 1otlxH-005EBJ-MB
Subject: [f2fs-dev] [PATCH 3/3] f2fs: change type for 'sbi->readdir_ra'
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

Before this patch, the varibale 'readdir_ra' takes effect if it's equal
to '1' or not, so we can change type for it from 'int' to 'bool'.

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 fs/f2fs/dir.c   | 7 +++----
 fs/f2fs/f2fs.h  | 2 +-
 fs/f2fs/super.c | 2 +-
 fs/f2fs/sysfs.c | 5 +++++
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 21960a899b6a..06d9bf98f5ae 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -1000,13 +1000,12 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 	struct fscrypt_str de_name = FSTR_INIT(NULL, 0);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(d->inode);
 	struct blk_plug plug;
-	bool readdir_ra = sbi->readdir_ra == 1;
 	bool found_valid_dirent = false;
 	int err = 0;
 
 	bit_pos = ((unsigned long)ctx->pos % d->max);
 
-	if (readdir_ra)
+	if (sbi->readdir_ra)
 		blk_start_plug(&plug);
 
 	while (bit_pos < d->max) {
@@ -1064,14 +1063,14 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			goto out;
 		}
 
-		if (readdir_ra)
+		if (sbi->readdir_ra)
 			f2fs_ra_node_page(sbi, le32_to_cpu(de->ino));
 
 		ctx->pos = start_pos + bit_pos;
 		found_valid_dirent = true;
 	}
 out:
-	if (readdir_ra)
+	if (sbi->readdir_ra)
 		blk_finish_plug(&plug);
 	return err;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e6355a5683b7..384840216e7f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1693,7 +1693,7 @@ struct f2fs_sb_info {
 	unsigned int total_node_count;		/* total node block count */
 	unsigned int total_valid_node_count;	/* valid node block count */
 	int dir_level;				/* directory level */
-	int readdir_ra;				/* readahead inode in readdir */
+	bool readdir_ra;			/* readahead inode in readdir */
 	u64 max_io_bytes;			/* max io bytes to merge IOs */
 
 	block_t user_block_count;		/* # of user blocks */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f18ae5410b2c..da304861890f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2202,7 +2202,7 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi, bool is_remount)
 	}
 
 	if (!is_remount)
-		sbi->readdir_ra = 1;
+		sbi->readdir_ra = true;
 }
 
 static int f2fs_remount(struct super_block *sb, int *flags, char *data)
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index df27afd71ef4..53fbbb87dd0f 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -649,6 +649,11 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "readdir_ra")) {
+		sbi->readdir_ra = !!t;
+		return count;
+	}
+
 	*ui = (unsigned int)t;
 
 	return count;
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
