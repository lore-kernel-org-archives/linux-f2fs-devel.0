Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50579C55182
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 12:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6R1LIG2X9V86R/Qo4RBXmUfS3e09tNVEz6vsf+eLZBk=; b=MKYHQNTss80HuPJG40Ft9hRvRM
	LcGzpUaJioS4JeRGd7koSH8ZzktmuyU5ViHjKDwC6tcUJV8XZJ9jszhmLw68jLSaVSsj4O62j1PRg
	5LADOOxOVclqshSibn3TsyLJZfE1WDC7AGs4iL/Ykfc15m8iktXAzDfKfYSJk6gWk1CE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqrqw-0007wN-GZ;
	Mon, 03 Aug 2026 12:33:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wqrqv-0007w9-52
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 12:33:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BdKXQ18mmMH9B3N5K7HZFnJeZc+RjIwVz+ZYs3prvZg=; b=HuL9wa8Rmuvt0R1hbuTcbF8Rjk
 U/HwRK73GfoYdhBmHmRA8JBfrMxyXVJpoW1nPp/ruVNLWN7f65LoftBUN/29Sh16NkJdE2jPq2Bgz
 8Fmz/RNGLIraUrSNPbbjqc94L0hkXVJuNFnnRJ+fweJm43mjqwt3/PIxNyJjzeH6T76g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BdKXQ18mmMH9B3N5K7HZFnJeZc+RjIwVz+ZYs3prvZg=; b=b
 xJ1Dq644N9I3f3xE8FD/yAv3oHdPJocq060tiE+OKFlHGVQy1I2pV3sxe2SApw6l/qdP9ACMFskbp
 +N6sIQMl4nkQqIZMO4Raealf/vYJ6XrH7Nf5oGhIQwTKk1Z3HsHF8MmjZl+SnQTcwgKr+m9ayEWRo
 XU8RJbuwypOX26eI=;
Received: from mail-pl1-f172.google.com ([209.85.214.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqrqy-0001kV-Uj for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 12:33:09 +0000
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2cab973140bso40252525ad.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 05:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785760384; x=1786365184; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BdKXQ18mmMH9B3N5K7HZFnJeZc+RjIwVz+ZYs3prvZg=;
 b=XLZT3Fts9zG7vmXuY2giWvI6atL8tvR4fIR7S6urexp/mISSJrKudeurkq6QyBm9jk
 Alxqfmrp9oVBNAmMTqEP3LGtDDobqVgOtfyplb6mipFGr5Gaop1cfLjG6Z7ikKv76NYb
 sQp4reX5s1/BvbKJrPExX1LyZ1qbxgKY246O0Wn02mlAMt/BKqYQYrNGDID5DAVsegkA
 KrrRxjefZu14kVttJwoPuv7PVuMoEQPqVXKg8IUzjmtIwM85M+YCZ8CFu8y7eP/8j7xh
 f4AxUnWM+1lQNAUkgAuOb1pDh/cBrT7/UJecQNd2rlGnXUM3pfb8HxWndBHbaDnuXnFT
 5Zyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785760384; x=1786365184;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BdKXQ18mmMH9B3N5K7HZFnJeZc+RjIwVz+ZYs3prvZg=;
 b=fxUqQRybdkgzRxWhpjksaOXZFsnkgeZuxhFNQmCk21fV9FbWWz+Ss1ktAKdXQZlmZ1
 PhXE7wuM1PJlgpwjiDHakxTkvX0ssPiam/OnYvg1KVvoXQ5SCIDCxZDRHinHWNf1JwlD
 F8SJjQarHpFqvxK16N++vVcV8SQvXI8juvoR+rw8Eu7kwx3Eh2ps+MwPTYLp4Gf1NM1H
 wC2E9V+ZjcJBjIWBOAOgsdAISRq9DVET+iR8ksu7mbQqnpqT5cQptrAYQ70JGmDAMKad
 rIJMihTyfneck30TfH8D1FeZQfyrwxd3qGLs+3B+ReY7DdmaBG1A43oH4BHBmYSegRKf
 uQNQ==
X-Gm-Message-State: AOJu0YxMk9OucWSiuwax/rHHclvR35YcoF+wRfUNcaL0ZbzAQ9UUHiew
 XoL0itVd2oJQEUrwIFeBvu1BzbBFLWdT3oBrgt62k/pNmBpJM2iS4FWI
X-Gm-Gg: AR+sD10BJDPnPR9biyvx90SZ8JvXke7oMDqnfz3GOB6m9EaQM1Uu2o0Dhne7Pb+5+LF
 EsBmD2XoBwGNhWIyPCEUq8djwj7AB655VzrZRcDmti4vRLmSwb0V7x5HVD+b4WdUQ+Mb7BK6vDf
 Q2WIDMwzDX+OE4jPKFJxePhdcNOmmB6JtCN7juk9h0pmHJa2v6dSfOv1/KNB+p+hJ3LD6l0jXQi
 r+G2/ZGKJN+vdnS14wT4xPqBcUWdccXTinij7DCTomrQgpZafdbbZKz6wjGj4rzSc9Cy9KvT7WQ
 DhMzcMlVXU09Yjy41AtqFEtBTZ9/V42KwzvzidqA1NEbi0sCeZzSCmP/8rlW1yY5SwlX2etbO/g
 8oTUo66sbjxwddb11k60OgsreEyxWTO0fdQdh2Ij6VwTOcUGMVCy9wOIR8aVkQbvjK7pP6p4KwU
 01195zxqlu68dvpEAZjdrVz/iEFhgzfJIca5TbQNbsBLFf3eiIy6HZbs0TklPedFaNoUHnUqGXz
 vvvwhP6TZT/YyyuH/qyO1k/bgrOD0HC11E=
X-Received: by 2002:a05:6a21:7109:b0:3c3:856e:dccd with SMTP id
 adf61e73a8af0-3c92a628e22mr9402275637.23.1785760383566; 
 Mon, 03 Aug 2026 05:33:03 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe39ea0a73sm3598024a12.23.2026.08.03.05.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 05:32:58 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon,  3 Aug 2026 20:32:50 +0800
Message-ID: <20260803123251.1522864-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wqrqy-0001kV-Uj
Subject: [f2fs-dev] [PATCH v3 1/2] f2fs: avoid NULL checkpoint thread access
 in sysfs
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
Cc: qwjhust@gmail.com, stable@kernel.org, qiwenjie@xiaomi.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

checkpoint_merge can be enabled even when no checkpoint merge thread is
running. A read-only mount is one case: f2fs does not start
f2fs_issue_ckpt there, but ckpt_thread_ioprio is still writable through
sysfs.

The ckpt_thread_ioprio store path updates the saved ioprio value and,
when checkpoint_merge is enabled, calls set_task_ioprio() for the
checkpoint thread. If cprc->f2fs_issue_ckpt is NULL, that dereferences a
NULL task pointer.

Protect ckpt_thread_ioprio sysfs writes with s_umount as well, so the
checkpoint thread cannot disappear under the store path while updating
its ioprio.

Fixes: e65920661708 ("f2fs: add ckpt_thread_ioprio sysfs node")
Cc: stable@kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
v3:
- make patch 1 self-contained by protecting ckpt_thread_ioprio sysfs writes
  with s_umount as well
- split critical_task_priority handling out into patch 2

 fs/f2fs/sysfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index be92c05a5420..0729b3670415 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -557,7 +557,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 			return -EINVAL;
 
 		cprc->ckpt_thread_ioprio = IOPRIO_PRIO_VALUE(class, level);
-		if (test_opt(sbi, MERGE_CHECKPOINT)) {
+		if (cprc->f2fs_issue_ckpt) {
 			ret = set_task_ioprio(cprc->f2fs_issue_ckpt,
 					cprc->ckpt_thread_ioprio);
 			if (ret)
@@ -1007,13 +1007,14 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 	ssize_t ret;
 	bool gc_entry = (!strcmp(a->attr.name, "gc_urgent") ||
 					a->struct_type == GC_THREAD);
+	bool thread_entry = !strcmp(a->attr.name, "ckpt_thread_ioprio");
 
-	if (gc_entry) {
+	if (gc_entry || thread_entry) {
 		if (!down_read_trylock(&sbi->sb->s_umount))
 			return -EAGAIN;
 	}
 	ret = __sbi_store(a, sbi, buf, count);
-	if (gc_entry)
+	if (gc_entry || thread_entry)
 		up_read(&sbi->sb->s_umount);
 
 	return ret;
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
