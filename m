Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8792F459EB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xMEiAFfkN9a/t/DDMEBzVa6Ze9uHh+cZtU2/prRlf1E=; b=PDy0TtCkjvhHHYXjjw1VJpKvKp
	RU96vnP50wyaPAd9jf+fID074n247vaKZ/urbItgey3yMayrCnd5keMhsoIQl0PWIO76M6ISrllkz
	ILpFrk/qc//DNClt0SeLe0mqyDPspjbOQB57uNakfsZwqEt0VxLk6vE8k8Jd5b4Xng5g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wBDSH-0004AQ-OD;
	Fri, 10 Apr 2026 15:07:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1wBDSG-0004AD-Bc
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Apr 2026 15:07:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QYLaRT/6zwHkuhTkUVTteVkTCIsm2F/KAybLFFalK34=; b=PmfSU19AZAPGWpAanP02lL4IhK
 eopu/DjmT0UqIcgshIiOJDLaNGemtZMNTajifaGcI0m+QKjcrlXeBGwLO3T8opqBTF1ShwawOdajB
 TnnNgHDOnf++X7zUTr3rkX3XCTrg1nBd89EhgSv/jQKXwFp6WCuXLaBYc4GUph6MKoDw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QYLaRT/6zwHkuhTkUVTteVkTCIsm2F/KAybLFFalK34=; b=BqyowR/pWA0EY42BNOAD7Gqd6t
 SQIQaTH6wIOjX/Q451HK5M8N146A3fWRu9xIfSmz1hdOHPhGYG7pnNjOWIZQJtxjPe4R9cIBsVzuX
 3N76kNlHCH5ffE33/G7AR6zqGNKuZ4yUYM86p+T07ZZTa+McTj7WzQnOawLhnbz3C0Kg=;
Received: from mail115-171.sinamail.sina.com.cn ([218.30.115.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wBDSG-0005FY-D9 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Apr 2026 15:07:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1775833652; bh=QYLaRT/6zwHkuhTkUVTteVkTCIsm2F/KAybLFFalK34=;
 h=From:Subject:Date:Message-ID;
 b=j3snvDpaqbFPjzDYrldd9lVPcHi6lz5OldFFw1YlLqru8WCE4fN14H2b4htnl834G
 oxjC/lERfWxF6lEzJ7kWIXWgqxv3I1FaCNSB2YNSTY2VN4V3chr3itB+ZFiWa68Y6R
 O0WCL3rzK6eVP0l6V6vN7X7PE9SYQmJpkK9WUf5I=
X-SMAIL-HELO: xiaomi-ThinkCentre-M760t.mioffice.cn
Received: from unknown (HELO
 xiaomi-ThinkCentre-M760t.mioffice.cn)([114.247.175.249])
 by sina.com (10.185.250.24) with ESMTP
 id 69D911F1000046BE; Fri, 10 Apr 2026 23:06:44 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 4142810747981
X-SMAIL-UIID: 8A7FEB21842F4B038D174AC63F264F98-20260410-230644-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 10 Apr 2026 23:05:39 +0800
Message-ID: <20260410150537.1683974-4-monty_pavel@sina.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410150537.1683974-2-monty_pavel@sina.com>
References: <20260410150537.1683974-2-monty_pavel@sina.com>
MIME-Version: 1.0
X-Headers-End: 1wBDSG-0005FY-D9
Subject: [f2fs-dev] [PATCH 2/2] f2fs: protect extension_list reading with
 sb_lock in f2fs_sbi_show()
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

In f2fs_sbi_show(), the extension_list, extension_count and
hot_ext_count are read without holding sbi->sb_lock. If a concurrent
sysfs store modifies the extension list via f2fs_update_extension_list(),
the show path may read inconsistent count and array contents, potentially
leading to out-of-bounds access or displaying stale data.

Fix this by holding sb_lock around the entire extension list read
and format operation.

Fixes: b6a06cbbb5f7 ("f2fs: support hot file extension")
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/f2fs/sysfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 5fbfdc96e502..c04eff3ec6d1 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -379,10 +379,12 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 	if (!strcmp(a->attr.name, "extension_list")) {
 		__u8 (*extlist)[F2FS_EXTENSION_LEN] =
 					sbi->raw_super->extension_list;
-		int cold_count = le32_to_cpu(sbi->raw_super->extension_count);
-		int hot_count = sbi->raw_super->hot_ext_count;
+		int cold_count, hot_count;
 		int len = 0, i;
 
+		f2fs_down_read(&sbi->sb_lock);
+		cold_count = le32_to_cpu(sbi->raw_super->extension_count);
+		hot_count = sbi->raw_super->hot_ext_count;
 		len += sysfs_emit_at(buf, len, "cold file extension:\n");
 		for (i = 0; i < cold_count; i++)
 			len += sysfs_emit_at(buf, len, "%s\n", extlist[i]);
@@ -390,6 +392,7 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 		len += sysfs_emit_at(buf, len, "hot file extension:\n");
 		for (i = cold_count; i < cold_count + hot_count; i++)
 			len += sysfs_emit_at(buf, len, "%s\n", extlist[i]);
+		f2fs_up_read(&sbi->sb_lock);
 
 		return len;
 	}
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
