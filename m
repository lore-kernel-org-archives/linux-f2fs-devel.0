Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED17BC021B1
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Feb 2025 08:51:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tl2HT-0004Sv-1L;
	Thu, 20 Feb 2025 08:51:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <arefev@swemel.ru>) id 1tl2HG-0004S5-JZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Feb 2025 08:51:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d8GxD/nSg4QuXrGtxNLMlKR9bIHa3KWtotKGTok0/mA=; b=gY8Dhh7e0qNMxDx3hS1HEpuI0g
 eYGFKoSQwKES7/3Qip0Md4HIsTekDkC52txfwjAVZpSyWtGv95lng0sRMin0jfF9TYwd8GVOlwd1U
 GQcv2UwRu4c+MLngLTmApm69qyZSjZ/LvqhyDcUSgp4Eu+WXva44z7MVCD/h0kw8Apqk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=d8GxD/nSg4QuXrGtxNLMlKR9bIHa3KWtotKGTok0/mA=; b=h
 mi7SJpW4z7ngaeY5YzUbK30g+gxv5dreCFccMeg3XoJA9CAiLYTNEiTgXQmpbWMZmTjqihz4IHR1Q
 ln916iZQDnvoGgAHW8fL3DLgbflcFbJx8uAeCMxquKlWWEHuE1AEwrSeow2JA9emzqQ1gjBj9Ndr6
 fF4wxtWnLMugAxlc=;
Received: from mx.swemel.ru ([95.143.211.150])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tl2HF-0003hg-IC for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Feb 2025 08:51:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1740040393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=d8GxD/nSg4QuXrGtxNLMlKR9bIHa3KWtotKGTok0/mA=;
 b=fNn9OBnEuMjVle3FsNoiA6nIPNk86bfhvQN8qzyIvyFOo8+lGKt2OkCMvJTWvSSrNm6RNl
 0A2sz9j3MfbNH81CuWl+HMKCsI0AwkNnqy4QHKovG/Cw5MOAm7kVjZ01UFoHtqnQyR8FPU
 hl6UlfwQIWGUK15bP8K/FM2KbaaW9ao=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 20 Feb 2025 11:33:11 +0300
Message-ID: <20250220083313.5918-1-arefev@swemel.ru>
MIME-Version: 1.0
X-Headers-End: 1tl2HF-0003hg-IC
Subject: [f2fs-dev] [PATCH 5.10] f2fs: fix shift-out-of-bounds in
 parse_options()
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
From: Denis Arefev via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Denis Arefev <arefev@swemel.ru>
Cc: lvc-project@linuxtesting.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

No upstream commit exists for this commit.

Using an arbitrary value that does not fall into the required range as an
argument of the shift operator when outputting an error is wrong in itself.

Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3bf/0x420 lib/ubsan.c:321
 parse_options+0x4ad6/0x4ae0 fs/f2fs/super.c:919
 f2fs_fill_super+0x321b/0x7c40 fs/f2fs/super.c:4214
 mount_bdev+0x2c9/0x3f0 fs/super.c:1443
 legacy_get_tree+0xeb/0x180 fs/fs_context.c:632
 vfs_get_tree+0x88/0x270 fs/super.c:1573
 do_new_mount+0x2ba/0xb40 fs/namespace.c:3051
 do_mount fs/namespace.c:3394 [inline]
 __do_sys_mount fs/namespace.c:3602 [inline]
 __se_sys_mount+0x2d5/0x3c0 fs/namespace.c:3579
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3b/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x68/0xd2

There is a commit 87161a2b0aed ("f2fs: deprecate io_bits") that completely
removes these strings, but it's not practical to backport it.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Link: syzbot+410500002694f3ff65b1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=410500002694f3ff65b1
Fixes: ec91538dccd4 ("f2fs: get io size bit from mount option")
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9afbb51bd678..5fd64bc35f31 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -722,8 +722,8 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			if (args->from && match_int(args, &arg))
 				return -EINVAL;
 			if (arg <= 0 || arg > __ilog2_u32(BIO_MAX_PAGES)) {
-				f2fs_warn(sbi, "Not support %d, larger than %d",
-					  1 << arg, BIO_MAX_PAGES);
+				f2fs_warn(sbi, "Not support 2^%d, invalid argument %d",
+					arg, BIO_MAX_PAGES);
 				return -EINVAL;
 			}
 			F2FS_OPTION(sbi).write_io_size_bits = arg;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
