Return-Path: <SRS0=JrMS=EB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B44BC2D0A3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:52:41 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E25218AC;
	Mon, 26 Oct 2020 23:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="iJAZC2Rg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="e6Ip0BMQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9Q+rlRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E25218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kXCI4-000496-CQ; Mon, 26 Oct 2020 23:52:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1kXCHv-00048g-39
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Oct 2020 23:52:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UUmKT3pkzS5HGPCI4i7NiznTO+CWvAQcCeq9Qxe1GYQ=; b=iJAZC2RgR36AVdsnDa2FtGbRip
 eVht70WxWEuALjZeeYMuio6gVeLW2TZwNrul8AIoSqMeNtubRA0oBvknShXeYFxlNyLoQVVFxYFt5
 CoCZ/d6Ah2roGyMTzfe/0M2fh6ezgofgHez/5dC5C9gl6m31nLkT9Ez+4SiEehC3ztiY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UUmKT3pkzS5HGPCI4i7NiznTO+CWvAQcCeq9Qxe1GYQ=; b=e6Ip0BMQRUFmdWL+AVwMcxdCZP
 csegB60CfrfTFas9XVAXUkpueZAGK1Vf0afJAIXfBII1pejM3D6P87Dcpn1zy3Ta/wkRdF4xjXrrq
 i6i93l1pe2HXCJN4jko5FR2uwCfezA3tTUCTtKo22P1JgOFioDIqmBD92MNDo328G6ok=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kXCHm-00Eu9J-Q5
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Oct 2020 23:52:27 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BACA821D41;
 Mon, 26 Oct 2020 23:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603756337;
 bh=8Z9jchd33DQJs31NN60Fj74YhSBCJwiqF2Ue3VPMBb8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=H9Q+rlRd3n0Wu3AmlntvijCjCKSQaDt71RnlZsoZXZzPibiYZpiUigb15jfi5h+KR
 ZvCuKph9Nz4nwXoAlOKJSacpXuz25BF02OROjAzDw5iDrdKzTQFm+wNKVTp8SKftbc
 0m65hd8lvhJZmNZqC3+CFCha7L7SNoBN0EmVz4B0=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Mon, 26 Oct 2020 19:50:02 -0400
Message-Id: <20201026235205.1023962-10-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026235205.1023962-1-sashal@kernel.org>
References: <20201026235205.1023962-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Headers-End: 1kXCHm-00Eu9J-Q5
Subject: [f2fs-dev] [PATCH AUTOSEL 5.8 010/132] f2fs: fix uninit-value in
 f2fs_lookup
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
Cc: Sasha Levin <sashal@kernel.org>,
 syzbot+0eac6f0bbd558fd866d7@syzkaller.appspotmail.com,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 6d7ab88a98c1b7a47c228f8ffb4f44d631eaf284 ]

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

Reported-by: syzbot+0eac6f0bbd558fd866d7@syzkaller.appspotmail.com
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/dir.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index d35976785e8c5..961d41fb84a57 100644
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
@@ -377,7 +376,6 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 	}
 
 	for (level = 0; level < max_depth; level++) {
-		*res_page = NULL;
 		de = find_in_level(dir, level, fname, res_page);
 		if (de || IS_ERR(*res_page))
 			break;
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
