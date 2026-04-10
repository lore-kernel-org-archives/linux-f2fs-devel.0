Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D92F459EB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iq80amtxneDpP0wX4qGeaNNeaRpHvwNrei86Ya7VFts=; b=eR979nZyn2YtTFUCo7bJgtCqMy
	20qyZa0wC3n6o+AQBlaZky8xvWpPxBmo6sRTQL8MEDXLfXXA/F+LtN1kBEUsuvcBF/Lj/Ykmue5fz
	w8iQ7FRbLVaZWBPHRMseMWjRVh3hHNaTP3f2ZFLB5JLOJaNr4yAy3OMNE5mdnaVeuv2Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wBDS7-0007Ql-6t;
	Fri, 10 Apr 2026 15:07:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1wBDS4-0007Qe-In
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Apr 2026 15:07:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RT/aBnrn9Wio2+JvgY0l8e1Lib1a2ABX2LeObdPB2OA=; b=DnxpzwQCNBrQrz/gKxMfwDkyrQ
 bLAJ3glnLxTc/EEIv0vb0BWamyNDmrEUimMAdZrKVX1PQ9l4wDmXalkV5KN1mrT5engvCIXIOGA+E
 c6k7tbnfuVNLExmIVlVbE6DWcqlZIfPgzSJjq5aOQT8wIw5LQ3rfeFgWUWBbghj7zHYI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RT/aBnrn9Wio2+JvgY0l8e1Lib1a2ABX2LeObdPB2OA=; b=H
 OlRbDCG6vRgOS/flaSV7ICJ2X0gMR/6Hlg9QR3Fo5rUiMpQk9EWbMp80li94zjd6cizyrLcjLUL8O
 q4MKH/XHzrbSaDpOlisgkxZT7xTzmZsNMmaO5UjcHNlSSB2SB62EiY7+8CU25CLLOfdAF/05XkdfQ
 LDkdtiQ6OcGUBu8M=;
Received: from mail115-118.sinamail.sina.com.cn ([218.30.115.118])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wBDS2-0005Ee-Ho for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Apr 2026 15:07:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1775833638; bh=RT/aBnrn9Wio2+JvgY0l8e1Lib1a2ABX2LeObdPB2OA=;
 h=From:Subject:Date:Message-ID;
 b=rV9Li0jP5u9Wh6W6ds7zHltCEAgWcGmZAKWqksvpc8k0TR57B9Ra+p3jYlcIBH6UG
 kGrOqjv2q2WZzgA2kZZe+2SgyYSTo7MhcbxEdlaOeRoMgrORYuYjhPWEeTBP6XOUzZ
 5GaDLuaKk2FizF0j46Ik805S1f/yJGO+fFiPW6+Y=
X-SMAIL-HELO: xiaomi-ThinkCentre-M760t.mioffice.cn
Received: from unknown (HELO
 xiaomi-ThinkCentre-M760t.mioffice.cn)([114.247.175.249])
 by sina.com (10.185.250.24) with ESMTP
 id 69D911F1000046BE; Fri, 10 Apr 2026 23:06:28 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 86980010748035
X-SMAIL-UIID: 762E49F6052F42F4A6DE740A20C849DC-20260410-230628-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 10 Apr 2026 23:05:37 +0800
Message-ID: <20260410150537.1683974-2-monty_pavel@sina.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wBDS2-0005Ee-Ho
Subject: [f2fs-dev] [PATCH 1/2] f2fs: disallow setting an extension to both
 cold and hot
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

An extension should not exist in both the cold and hot extension lists
simultaneously. When adding a hot extension, check whether it already
exists in the cold list, and vice versa. Reject the operation with
-EINVAL if a conflict is found.

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/f2fs/namei.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index e360f08a9586..3215983dc030 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -83,6 +83,21 @@ int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
 	if (set) {
 		if (total_count == F2FS_MAX_EXTENSION)
 			return -EINVAL;
+
+		if (hot) {
+			start = 0;
+			count = cold_count;
+		} else {
+			start = cold_count;
+			count = total_count;
+		}
+		for (i = start; i < count; i++) {
+			if (!strcmp(name, extlist[i])) {
+				f2fs_warn(sbi, "extension '%s' already exists in %s list",
+					  name, hot ? "cold" : "hot");
+				return -EINVAL;
+			}
+		}
 	} else {
 		if (!hot && !cold_count)
 			return -EINVAL;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
