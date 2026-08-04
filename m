Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228A4C55184
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 01:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XMN+P6rNeIHWcSeKIXVRT1aenUEMfa2DjblSnp7QJoc=; b=Ug+g2ItbvDNgrEgpjS8xJYFxcE
	VB8W4fcT7g1NDKxOeEDWdipbdMVC0IJEIPApf1LpRa0IVx78riJYMuebJXbn/0mWJczdq1ezCbYwV
	1FCoL+BhHN338WOIYDubpfKuPTzS2l/16NFNYkloSrOX5MwZgtWzX2rxyPMC3BY+hhq8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wr4HA-0000QE-QV;
	Tue, 04 Aug 2026 01:49:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wr4H9-0000Q7-Pj
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 01:49:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yp6bt25h0TQgT8QVEdgQXBwLW1G2lzJByYOi8mHDHxA=; b=b8TCSabvwKo1ELeH4qz1bDhDpd
 F+ewLvBJIR1vOfVSuCPRynOojITMc5mtCvVrqe7YJ7tG4y1ZtkdhWFYz8ZvKyHhLbTFOS7nFkvvwb
 522IS4PF81my9NX87FCeHThrh8sMMHIKQTdVwevwA9Q+idUXmv1Y++wpybpRXHTghzL0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yp6bt25h0TQgT8QVEdgQXBwLW1G2lzJByYOi8mHDHxA=; b=Q
 Q4QiaCqJBYG5sbOQ6X06aLIkG4lpBT+JEMu7kHqrdbWgOtOffWR6ar6NaYl2OFI/EaPVlE8aai0nR
 q1WP7Qa0mOLePMWV+0xiQ0xuWq+4S436m9+XV22jGnOsOMIFeZ+oZpJhvyqAZGeQs/T2TlRH0Iyzu
 qYXBwYOhBMpqVJmg=;
Received: from mail-pf1-f170.google.com ([209.85.210.170])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wr4HB-0003o0-U3 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 01:49:03 +0000
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8486672f03cso4536938b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 18:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785808137; x=1786412937; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yp6bt25h0TQgT8QVEdgQXBwLW1G2lzJByYOi8mHDHxA=;
 b=NHNk+svnRix9PDitZWbAlYMHM536Zknq/jLrkU78JIgU2hQyn9HblBzZg9Pwoypc3M
 rnsmi5rz5YaX1K4GiOjhVEu9jw2pjvj1QS9EcBWhgc5qpftigQGNBAw6Zzhiqk+onYZl
 IPGZLo66hXB2C4xMkBJ5es4GuBx2W/M7R13he2byk47Fx0ATttxsktj638ZEg/VmUI+O
 T2mGeJS6mPO0cu8inpNlox4nDR7j+XFTk2VuCxxgsnqoX4HCd3hjmE+UchbUqDL62prm
 C3CBKhu2H6KNGwED5c1crum2aCLzCCyOhMTh/FyYQP20og3Ofn+DvKlYKx0rv+v7HZfl
 el+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785808137; x=1786412937;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yp6bt25h0TQgT8QVEdgQXBwLW1G2lzJByYOi8mHDHxA=;
 b=dz1fmWcHdEv9nSKCcfutpAKRhPUntHr6QuiN2Pd7NLembaxgBxQB/CUwjnVygrfc4N
 2aBET6QaigryurUfMK9he+p1OE0kAR00WQ23DcbrEgNrtsFr30iNDfuJWtfa2Gv7llSf
 gZWY2hH7FBNGB4IKndJ5ow1UKQZcNAKKHve8NWc9jdxrgXVH9aHlSY5PgXyDvPYkUYRQ
 lMLBrmSNUXMp1CnlE/9jgl5EIsB4dvK1rtetfF0Uo4vtKUN+ork2UqCsgm/fLNNCdITu
 bQ+3EcvCvnTVXDVD7eBWJo7QmfkSMFQ+ftBr+yzD99vSZrZLJg+HCK6co4Q0UuunTSOf
 1o0w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrAxVB/Q/SvOJM6/XHoaXa/iLamO6je8brSo3cyt1WDZLhdWYDPYnQg7PqJdomgmD8PbrtWhIHsOOMb5ejjwDwr@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw900/gEnWM/Y8Qf0hVvZ3OABvKASXCUHfmjEulqXbqVcsryGta
 oJkw6R2hqViN5vXV7nS0USaIA+5iQBpxp1FzfMw9AKGTqO31eS+S3Ott
X-Gm-Gg: AR+sD11tp0qtAwBqC0dLdDiEhTY0/ueQsuYlcnUXfbFgSxkNgkwSYmYV++omaTwi4KZ
 h7c/NV/wGG5gtN9EkWyFwsN/3foCVvqRihU9/tYVRvkahmFYalT3RGYi9YzigSQs0GPO0A5kXcu
 ilWxRPqtNm0OFUtI1/3vf7pd9AuLRA+SSzlr0r/wEjnz40pr2zolRQ0UVEFb2iSkh6yAgMxBeDZ
 FvMsdZTftKhketqGRs/60vhVvhg4dLcQ6bihY+bo9BUSdQ2u9KneqJShe2nNtmjMBOGBBO4AGTd
 0bUGFwa+XbLhS605rQV0BDDmBv1xyF60+fUaXCs7J19Ktu20iJgYiwDr1IbISzAVp0P2YdufoeQ
 +dHI+GTu6yK8JAiQWxMx1lJZVLX547B6pMinNxx50C4umGXSmBbQx448r+tsCIagIJ2z6GvcndJ
 N2LyPF2ATZuXNykFCz38HhnOubBYE+O+3YaQY/tKygxq1YPAgC2GCcRo3vb0LuNsLCr+PCWnABO
 n29mIewd5g+4+060x3pachW
X-Received: by 2002:a05:6a00:3909:b0:84a:2fc1:da38 with SMTP id
 d2e1a72fcca58-84ee494eae4mr12034394b3a.58.1785808136670; 
 Mon, 03 Aug 2026 18:48:56 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84edc2d4473sm4315253b3a.40.2026.08.03.18.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 18:48:56 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Tue,  4 Aug 2026 09:48:48 +0800
Message-ID: <20260804014849.1942326-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wr4HB-0003o0-U3
Subject: [f2fs-dev] [PATCH v4 1/2] f2fs: avoid NULL checkpoint thread access
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
Cc: qwjhust@gmail.com, linux-kernel@vger.kernel.org, qiwenjie@xiaomi.com,
 stable@kernel.org, linux-f2fs-devel@lists.sourceforge.net
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
