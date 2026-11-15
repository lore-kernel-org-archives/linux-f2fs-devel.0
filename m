Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4BF606A31D
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 15 Nov 2026 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CJYgXCui;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DSU6zL8c;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=R0bPeQoD;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lA3135oR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=D88fgSc9NS/AaBVjxKUejjphLNawv8ehCFSKz2tO2Ro=; b=CJYgXCuir4XO7f2kQht+Ufv+vJ
	T8zLZO9TYMw8LoirAmuO3iJQKt7UwZp63QWvGbMO3Ak6MN4326IWY4O3e+gEp9am4hJ102YPBTjg8
	S94RuF/bq9whsiZZgEB79k84EFfrcdYR4OpSh/D5GDQjcl9VUWaQe6PAa76+E4qI57HU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSWdi-000000007hX-3tVQ;
	Sun, 15 Nov 2026 09:35:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <jsjlee1020@gmail.com>) id 1xSWdh-000000007hK-37KK
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 09:35:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8qOsEVx0lNcqncRsI92WD8XITRb8ty6XS3PW5jLkLOA=; b=DSU6zL8csZ2KrVO9mxGybISOGt
 qSZK8YbcRdFRm3sfF8v1ydRSxw1qFvIOShGwOrZRTQCYMZv6jL5jKt9noOhkfCzON3lPrnAVZVRD6
 gZzqW+hHqP8lfBba0BSJcJErxoklFkE7dS6DL8yy+a66YyD5IVcEbqowfjT118AKKPW4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8qOsEVx0lNcqncRsI92WD8XITRb8ty6XS3PW5jLkLOA=; b=R0bPeQoDDJ4Z4GoYZ/GehmPumU
 aczEeX+Jp2GRlAgTq6mTmwRwJmF39b0Tbp6EPsalgg4vnHSrh5dN+wUDf7VHla8YyCaS6hIDbrMHJ
 xJ9z620ib/7D4oTRvBWuXp1Tf4M2i8T+a64/AhsUWK8Z+geknqZc2Im9+1om1STMrQ4o=;
Received: from mail-dy1-f182.google.com ([74.125.82.182])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSWdh-000000005I0-0Ys1
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 09:35:09 +0000
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-36eb1cb7aabso3033833eec.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 01:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794735303; x=1795340103; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8qOsEVx0lNcqncRsI92WD8XITRb8ty6XS3PW5jLkLOA=;
 b=lA3135oRQv+lEUimrqtdvypoRB20rJDOjr3d9TH/Dv3wPymAGah/tatHln4CubTvFm
 DePh+9PUyR41sqCw2zzNdwSkwy7g1UryHLmmulSLxAS/RltIsLujp3/pLV5kdzyKCTTF
 eKuV6PhpC01ZQffmXN/AIITQOYQPVWSOy2xk/QY16uQxc/2ifSJwk8AkuynoYCOx+sTg
 tzcxAx/ukiv/Uk68JrwzaZTufG0SByw2uUt3ISpigc0qIaCbCyUhh183TEbnnAZhKVJy
 s722IIms85K3G1VUdwnsHGTA3K4+JCJVP8FO17ImkVwSqrY22gIeyiBtcyab50uM2OoP
 az6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794735303; x=1795340103;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8qOsEVx0lNcqncRsI92WD8XITRb8ty6XS3PW5jLkLOA=;
 b=iXkNRpc58GLAr3SLqrIHE+p9dnmWj7c7ax4yPkuaiZrOh9qIj8Gau8RfV50rWoHI6J
 6sVF6rYGoafTMKF6yibxq/TAtI3e33ZJU0SZ2i8FSVJ6Gn6ks5102xLjcrqj/AVtq+9T
 phJfbwtCd4G2o6lKhOfxacsPxdrZw58JHMyapyM1tuNp2LF+G+d8Exw9r+hWx/WYlXMJ
 SQEdG57+k1Jd5sOzhBNO0w78untC9j7Nj4tpRqYdaOSOlskaEf7csw+Az51Sycf1gGAz
 XNFs/2EzIZC9OSLe4O1xi3ZaT92dtBdkccvRxjqJNQNEkWZqQc329iwHWhTQTxQoDDAO
 EAhw==
X-Gm-Message-State: APuU4Z+hBOU4gHSYcFf0Z53MPQzFlj2rwwsLIX7p0he/TOxlsI4HWpQ3
 gq3SDMu5JNZuRTQa5dISoR4S1rZgYpMZsscWBZ5OEVE3Fa/SVGdTQHIE
X-Gm-Gg: AYBFou2YX/9PnjkzletxexuDmyJi2AgryQstY7APd+BALSiNzNnaHnbIq4/i/JNXE0b
 lOOf4qE3sh8k7U+KaZ6BSaRZ4wQUKqE2TB1yJ4kcjldAHUpoGSHAjwl/ATRPg0IVSE/pm+x3hpU
 dyCxHW8QXJzg3xuFd79pIeroe5qhey77hpZ1f6q2shNxMJczY6NDc2z31q2tQqeZvXbukgzVJvs
 a1LA4rcbBS1125zbd3c3gNvhynOmAnQcwCSo5Snkl5KXXwCNKJ94BkPUkDrUc9FpvkCwuxnU8GW
 CVHzIPuZFCFI6jUl6oK787683kHu7Q9mpHJJVG4HHhzlpwFBYUrsuDAlSABfpSFcFLkCFffBjSB
 5+bzUaEkIsJ3nh2wrf2CWedjkj8+KFA81NJcaqzV+pPTYXv7V+0VGoUkbYeXg7L9UzD2feoF8z2
 FtbQeylM5f707S5N1zHK/qlc+3wizDbHO6RfTt7j4jWcVE4h9GJd8VAcIoHQBheTXb0GaTTqn1Y
 Ze6I7lJtpyAKrk7ZN1p7MLs5XGox568BcINw5uyKBaDehwotheArHqWgOpIvYtUrhUXPvx2qzmL
 Rw9vObL/hX2fF3oozL3W3QGOahi9b+1CXpbHlK/rOl6ibgnLpB8W8J4DBRAVOvlaT/2zp8Y1+YI
 mQD0Nvl2lBr2Kd+56a6q+GyTP9Pi+
X-Received: by 2002:a05:7300:c01c:20b0:36e:b05e:9a74 with SMTP id
 5a478bee46e88-37967dd6078mr7137823eec.30.1794735302432; 
 Sun, 15 Nov 2026 01:35:02 -0800 (PST)
Received: from
 codespaces-2362ac.m2fxbej512jepnsor2itp05j3d.ix.internal.cloudapp.net
 ([207.46.224.87]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379565d3e37sm26298603eec.24.2026.11.15.01.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 01:35:01 -0800 (PST)
From: Seongjae Jeong <jsjlee1020@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sun, 15 Nov 2026 09:34:13 +0000
Message-ID: <20261115093413.118399-1-jsjlee1020@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xSWdh-000000005I0-0Ys1
Subject: [f2fs-dev] [PATCH] f2fs: fix to use atomic write for strict fsync
 on the inode update path
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
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

In strict fsync mode, f2fs_do_sync_file() uses atomic node writes
for OPU to preserve ordering between data and node writes and
prevent data corruption after a sudden power loss.

When an inode update is needed, f2fs_do_sync_file() calls
f2fs_write_inode() and jumps to go_write, bypassing the check that
sets atomic. This can lead to non-atomic node writes even after an OPU
in strict fsync mode.

Move the OPU and strict fsync checks before the inode update branch
so that atomic mode is enabled before the jump to go_write.

Cc: stable@kernel.org
Fixes: 278799151646 ("f2fs: fix to force keeping write barrier for strict fsync mode")
Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>
---
 fs/f2fs/file.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 05061254c3b2..3b51d84177e0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -372,6 +372,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	int ret = 0;
 	enum cp_reason_type cp_reason = 0;
 	unsigned int seq_id = 0;
+	bool has_append;
 
 	if (unlikely(f2fs_readonly(inode->i_sb)))
 		return 0;
@@ -392,6 +393,21 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 		return ret;
 	}
 
+	has_append = is_inode_flag_set(inode, FI_APPEND_WRITE) ||
+		     f2fs_exist_written_data(sbi, ino, APPEND_INO);
+
+	/*
+	 * for OPU case, during fsync(), node can be persisted before
+	 * data when lower device doesn't support write barrier, result
+	 * in data corruption after SPO.
+	 * So for strict fsync mode, force to use atomic write semantics
+	 * to keep write order in between data/node and last node to
+	 * avoid potential data corruption.
+	 */
+	if (!atomic && has_append &&
+	    F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
+		atomic = true;
+
 	/* if the inode is dirty, let's recover all the time */
 	if (!f2fs_skip_inode_update(inode, datasync)) {
 		f2fs_write_inode(inode, NULL);
@@ -401,8 +417,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	/*
 	 * if there is no written data, don't waste time to write recovery info.
 	 */
-	if (!is_inode_flag_set(inode, FI_APPEND_WRITE) &&
-			!f2fs_exist_written_data(sbi, ino, APPEND_INO)) {
+	if (!has_append) {
 
 		/* it may call write_inode just prior to fsync */
 		if (need_inode_page_update(sbi, ino))
@@ -412,18 +427,6 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 				f2fs_exist_written_data(sbi, ino, UPDATE_INO))
 			goto flush_out;
 		goto out;
-	} else {
-		/*
-		 * for OPU case, during fsync(), node can be persisted before
-		 * data when lower device doesn't support write barrier, result
-		 * in data corruption after SPO.
-		 * So for strict fsync mode, force to use atomic write semantics
-		 * to keep write order in between data/node and last node to
-		 * avoid potential data corruption.
-		 */
-		if (F2FS_OPTION(sbi).fsync_mode ==
-				FSYNC_MODE_STRICT && !atomic)
-			atomic = true;
 	}
 go_write:
 	/*
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
