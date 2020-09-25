Return-Path: <SRS0=8g9c=DC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30C7C4363D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:20:35 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B05C20738;
	Fri, 25 Sep 2020 15:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ce4ujMLm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="F0PyHoul";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOqrxJj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B05C20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kLpWU-0006BA-1h; Fri, 25 Sep 2020 15:20:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1kLpWT-0006Ay-CE
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Sep 2020 15:20:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KQvEPrAXoM1hIwNpgq6by6jtuWiXnQJZc0jNpQgf6KE=; b=ce4ujMLm821QelGcrXwXMgGmCt
 aTHYP+W6qTdYD0noVCOoabHvOC/f48CAKW05K3WpfXKGv3PhSiyJ6AIclK16IRvBnUNLgrbNMDFsU
 sjAeyJDE8GWoLj46aPnmqTmIEnO16T2HSwwR/WaOAlR5YGsVgTuWyLoTRtuMQnFSLFHo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KQvEPrAXoM1hIwNpgq6by6jtuWiXnQJZc0jNpQgf6KE=; b=F
 0PyHouliKZ9w2kt4y3vpEBks8SYZ1xecUBXSwcdNUb8ddsYhrlRw4A8V5d9cyYYkf6WwDmio+NnxA
 xQ71n9RubCRiIQ/Ult393HreVKVFLP3j8ffoPVFEq2pv9zNXd8C8p7SWS/HdtzCrE6mF9+aNEUkRz
 p/kUu/DbiFEE3/Mg=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kLpWO-005ddM-O6
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Sep 2020 15:20:33 +0000
Received: from localhost.localdomain (unknown [49.65.245.23])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A2E6920878;
 Fri, 25 Sep 2020 15:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601047223;
 bh=Rgt+BCsL/KkkjWh67h04RmRvHL8oKTtmyN9/5r6atMk=;
 h=From:To:Cc:Subject:Date:From;
 b=hOqrxJj5Obzg0ZU5+txEcT2yZGWeyxDoFafMpLkO/+iVH/m/IbE/2M3lZILid/53J
 BWbwFDldm3t5e/aaZSbZIeu2I7P8GOLbAV0aWhNPmSvWMKgU805cQVWRsxGVnfyWtZ
 3BhyuV0yDCkdig6njBZJlWvFQAuZ2nkGgB4yMsWo=
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Fri, 25 Sep 2020 23:19:26 +0800
Message-Id: <20200925151926.2658-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-Headers-End: 1kLpWO-005ddM-O6
Subject: [f2fs-dev] [PATCH] f2fs: fix uninit-value in f2fs_lookup
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

From: Chao Yu <yuchao0@huawei.com>

As syzbot reported:

Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:122
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:219
 f2fs_lookup+0xe05/0x1a80 fs/f2fs/namei.c:503
 lookup_open fs/namei.c:3082 [inline]
 open_last_lookups fs/namei.c:3177 [inline]
 path_openat+0x2729/0x6a90 fs/namei.c:3365
 do_filp_open+0x2b8/0x710 fs/namei.c:3395
 do_sys_openat2+0xa88/0x1140 fs/open.c:1168
 do_sys_open fs/open.c:1184 [inline]
 __do_compat_sys_openat fs/open.c:1242 [inline]
 __se_compat_sys_openat+0x2a4/0x310 fs/open.c:1240
 __ia32_compat_sys_openat+0x56/0x70 fs/open.c:1240
 do_syscall_32_irqs_on arch/x86/entry/common.c:80 [inline]
 __do_fast_syscall_32+0x129/0x180 arch/x86/entry/common.c:139
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:162
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:205
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

In f2fs_lookup(), @res_page could be used before being initialized,
because in __f2fs_find_entry(), once F2FS_I(dir)->i_current_depth was
been fuzzed to zero, then @res_page will never be initialized, causing
this kmsan warning, relocating @res_page initialization place to fix
this bug.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 703cf8e21fc0..83630341ffa3 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -357,16 +357,15 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 	unsigned int max_depth;
 	unsigned int level;
 
+	*res_page = NULL;
+
 	if (f2fs_has_inline_dentry(dir)) {
-		*res_page = NULL;
 		de = f2fs_find_in_inline_dir(dir, fname, res_page);
 		goto out;
 	}
 
-	if (npages == 0) {
-		*res_page = NULL;
+	if (npages == 0)
 		goto out;
-	}
 
 	max_depth = F2FS_I(dir)->i_current_depth;
 	if (unlikely(max_depth > MAX_DIR_HASH_DEPTH)) {
-- 
2.22.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
