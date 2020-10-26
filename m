Return-Path: <SRS0=JrMS=EB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A3DC5DF9D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:52:36 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA5E20882;
	Mon, 26 Oct 2020 23:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="HVG50AIK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="EWbhv57e";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvqDNmtD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA5E20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kXCHw-0000Ro-S5; Mon, 26 Oct 2020 23:52:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1kXCHv-0000Qu-3A
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Oct 2020 23:52:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v0rGW9GjUzHcP9d2HMwFfukuAwitZTkYC7CF2ZTX86s=; b=HVG50AIKgRyJdn6/owoYkqJrBZ
 xb/hQeWpTtdImckf1zr5XhkD06jd//3PuoDLZzF2rSCAY3+4Er9p0yp/9KqlntZ8bGxOUDFQV38Tk
 WcXPivO41xF2n8ERSdCXM2IWOsxZYhnISgmvnoB1IV6lMAgK5X+PIgCY2QKAgpPLJ6/U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=v0rGW9GjUzHcP9d2HMwFfukuAwitZTkYC7CF2ZTX86s=; b=EWbhv57egLVpmUPRi/YBlNL02L
 UFwatYpziwNfAKkQ/q5+JD7WAhk5HO/4fe07pVphIsWQW9C+Gsv7v0w9+LzWI8awsYfxwSw2BoT5W
 9xvu7pRIVzY2UHVooX6B2/TKZBucrsK40KO4VQyrRtcN5dHNOdGH29nTac0DB5vGlBhI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kXCHl-00Eu9H-OG
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Oct 2020 23:52:25 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B092C217A0;
 Mon, 26 Oct 2020 23:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603756336;
 bh=9tZeHih8e7Uh4LwY8MPzkfHHfIefV9R/hNqCIllSfx0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SvqDNmtDZ2ONNJTsdldX6NnxZHRUqICrlPseNLkXCEKyKbqcZHlgflrPDTCF4tGlB
 7AkxanL/z7iZSqyuGdJdhZwk1pF9J8oQFW7qREaTtyve+o49D5rwO7R5giKz0P/y9e
 rErGH3thfr928Wg53m97+cW6jkGKCx7u1FcQMVOo=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Mon, 26 Oct 2020 19:50:01 -0400
Message-Id: <20201026235205.1023962-9-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026235205.1023962-1-sashal@kernel.org>
References: <20201026235205.1023962-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Headers-End: 1kXCHl-00Eu9H-OG
Subject: [f2fs-dev] [PATCH AUTOSEL 5.8 009/132] f2fs: do sanity check on
 zoned block device path
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
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 07eb1d699452de04e9d389ff17fb8fc9e975d7bf ]

sbi->devs would be initialized only if image enables multiple device
feature or blkzoned feature, if blkzoned feature flag was set by fuzz
in non-blkzoned device, we will suffer below panic:

get_zone_idx fs/f2fs/segment.c:4892 [inline]
f2fs_usable_zone_blks_in_seg fs/f2fs/segment.c:4943 [inline]
f2fs_usable_blks_in_seg+0x39b/0xa00 fs/f2fs/segment.c:4999
Call Trace:
 check_block_count+0x69/0x4e0 fs/f2fs/segment.h:704
 build_sit_entries fs/f2fs/segment.c:4403 [inline]
 f2fs_build_segment_manager+0x51da/0xa370 fs/f2fs/segment.c:5100
 f2fs_fill_super+0x3880/0x6ff0 fs/f2fs/super.c:3684
 mount_bdev+0x32e/0x3f0 fs/super.c:1417
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 do_new_mount fs/namespace.c:2896 [inline]
 path_mount+0x12ae/0x1e70 fs/namespace.c:3216
 do_mount fs/namespace.c:3229 [inline]
 __do_sys_mount fs/namespace.c:3437 [inline]
 __se_sys_mount fs/namespace.c:3414 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3414
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46

Add sanity check to inconsistency on factors: blkzoned flag, device
path and device character to avoid above panic.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0deb839da0a03..28ab6cf26954a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2782,6 +2782,12 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 					segment_count, dev_seg_count);
 			return -EFSCORRUPTED;
 		}
+	} else {
+		if (__F2FS_HAS_FEATURE(raw_super, F2FS_FEATURE_BLKZONED) &&
+					!bdev_is_zoned(sbi->sb->s_bdev)) {
+			f2fs_info(sbi, "Zoned block device path is missing");
+			return -EFSCORRUPTED;
+		}
 	}
 
 	if (secs_per_zone > total_sections || !secs_per_zone) {
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
