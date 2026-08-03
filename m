Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4D5C55184
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 11:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=myEwR6A6jrx4Rmr4UB4G7gbUG5VttJxzArUf1nY8OaY=; b=NX6Rz0wCG9J7QBAGS7rM1TpjRs
	fWQ8tunQe0k1BuV0CSPO2vdb5lKMRd69j0FwXdJ7ce9DSjgj3jcYxs0ZRoViZjKD8rtH4YEwoO7Xu
	DLAT/suC+v5uQb+zXdh8aK5RUEXRh+a5Kho6R6kstjUrBi7O2PCcbo3eioJBuVeFarac=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqr3b-0003gS-8F;
	Mon, 03 Aug 2026 11:42:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wqr3Z-0003gL-MI
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 11:42:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=66TqE0GY70NfftLhEOihtiNKAYH2cWMQlF34dt0hI5Q=; b=htvzl64D9A1Z4Ay8pGhSwKXP6N
 ZMmRQF5WwhBvSFf6OUpko1mWOxBoxy8ksHw/F3RLR+OMgmsCFhBZSKCbxUMAroZMo8s4uNEpprHdY
 n8Iy2UR1AZjVIf9arYHeEZscGLkc/4/MnWFzbmR7rf1Rd9NG0WuhSNuauePezjvIQWpg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=66TqE0GY70NfftLhEOihtiNKAYH2cWMQlF34dt0hI5Q=; b=F
 u3diSRzOqdhOGQPzBS1v/6S5wFY+z/07ESu8lqNZkT6JQnnmr4DfX6elONeUwnsnxz9HdpzbRYvi6
 LTLBRrTVomK3t+dSGvQUecfIxB13LxjFoL90JPGIIIjLw3k3NidSlZJ0J5zDXvewAVQ5/MjG7HmBT
 c4QgDiMxd/wLkfKA=;
Received: from mail-pf1-f173.google.com ([209.85.210.173])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqr3a-0008Sj-AT for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 11:42:07 +0000
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-848d21bbaffso3495009b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 04:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785757321; x=1786362121; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=66TqE0GY70NfftLhEOihtiNKAYH2cWMQlF34dt0hI5Q=;
 b=knzGf/F++LnstnnWfNNlBrN1B8Pm1r6dHUbBpuBuDV3BYr9Xz5HxTRIrdwt+fVkGQq
 OggGHhn4zNPAg1d8PsD/N1Qi2LUMUyTAVx7bXFS/MmuB9V2q9RJmdT4FuIZ6Yc1LEFEP
 teI0PMRnwNVGGHW9qJ6H+M/dD/rXsYopQz+WCK9+9PAuxN1k+gSwh9QWAefQ2VnFKRWp
 WoPy0+gweqZ6hfuZxxu5RZoNIpDoCotjL0i0Cuw/bYHIcOAgNxO0zH4BNc5KPRgPq7lu
 J0xILnfuRSI1vV8ekTgmPJ4XQcUns3/4yQDgG3mHnXB39P2bC1LylYQK2GymxCo2DAdW
 GqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785757321; x=1786362121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=66TqE0GY70NfftLhEOihtiNKAYH2cWMQlF34dt0hI5Q=;
 b=egt7u/hmxKNsEp28WjyBK/hvCJ4d00EVvYTVe0z82XxonS5fP/VN3N1XJtS7Dkr7gA
 wmD9F/HVSiV1vRpP7CGQQ7+f3qtmoswfmekKJTgMZy3SgmyYfMPuNBQZ16JHTWTWKFqG
 0053w7d7XlAj4Yta0pMBtqwuR+0xeJzonHzjdSgXLNMlCuV1jrNqFwamDWrSMxyxLCB4
 aWNpbm1rqEg/pVPdiELMRx7NBN67gXI2dUtWBqgOGeSHZ8fHy2f0HSIf9zxaMZ+nGTST
 00/79ARozEA/iBx/4PhRjnVf4v87acQDTxECX30zaXZ4RBN9kNxKin7d36tpM7ZyFJxt
 2IpQ==
X-Gm-Message-State: AOJu0YwLYWhbetTz+rWg5YBbKnl5iYJyIzL6ndHa3i0zN0VDjlZJN2wU
 cUtq80dszXYrlHBSeLPbDxsBsUS1TxYqGy8jdJ5LOFybN48yaFKcpnJN
X-Gm-Gg: AR+sD13f18FkRY4ivfrW7osoPGlFXck0LyRugQ/w5d+JNNIDjZC/nQlUcbml2sEXLfh
 A6uhv0k9sEmMIa8sMzk5mZqlcPcXaRDg+kmGIP7yzYZjfWJC1LLVbZtP+WR2yV+gRIV/BpPjSNX
 iNXhfw+cNMg5AZNs7woZnfv5WkjgrG7mDZM8GwIOancUXTEL+vToGzTCRwfDVmvhtffikzF0hXS
 8Cs45nM46SywwtGIkRTlEfHQ1UqEBS3yAVFFjEyzADmnWvwRNXq/1of0IqjLuKTPh8Vy0r+LWGK
 BWc0zYQLBx9GI8Wat7zwvSHzsK6Y1N+UxfvmJVDpTjWiAst7kavzsXxME5g3lJGtY1PTHBBxmEn
 oL5AxmCFQfpbKOwOk5jURroqbpFkFTZD/Wm2ZrQ6stUxQcJQlK9f6RTellQOq4FGq9rFYbUdQGB
 q1/yhhu0jXzevgJIhLsEKr0qu4Nk0Dcn4NEhnfVOIU+3csiVJFhCz5Z6thySKSv0rTMlIO7RIDW
 vPJWovC9srH7+huaVeqmGmh
X-Received: by 2002:a05:6a00:1706:b0:84e:2bb:2d39 with SMTP id
 d2e1a72fcca58-84ee48ff5e9mr8105452b3a.53.1785757320924; 
 Mon, 03 Aug 2026 04:42:00 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84edbd36eb1sm3640620b3a.11.2026.08.03.04.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 04:42:00 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon,  3 Aug 2026 19:41:53 +0800
Message-ID: <20260803114153.1499527-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wqr3a-0008Sj-AT
Subject: [f2fs-dev] [PATCH v2] f2fs: reject invalid recovered filename
 lengths
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
Cc: qwjhust@gmail.com, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Recovery uses raw_inode->i_namelen directly when rebuilding fsynced
dentries. A zero-length name uses no dentry slots, so recovery can
report success without recreating the dentry.

Treat zero-length and oversized recovered names as corruption, mark
NEED_FSCK, and stop recovery with -EFSCORRUPTED.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
v2:
- add unlikely() to the invalid recovered filename length check
- move the invalid-length corruption handling into init_recovered_filename()

 fs/f2fs/recovery.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 89af8407b667..268b00536869 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -116,18 +116,26 @@ static void del_fsync_inode(struct fsync_inode_entry *entry, int drop)
 }
 
 static int init_recovered_filename(const struct inode *dir,
+				   struct inode *inode,
 				   struct f2fs_inode *raw_inode,
 				   struct f2fs_filename *fname,
 				   struct qstr *usr_fname)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int err;
 
 	memset(fname, 0, sizeof(*fname));
 	fname->disk_name.len = le32_to_cpu(raw_inode->i_namelen);
 	fname->disk_name.name = raw_inode->i_name;
 
-	if (WARN_ON(fname->disk_name.len > F2FS_NAME_LEN))
-		return -ENAMETOOLONG;
+	if (unlikely(!fname->disk_name.len ||
+		     fname->disk_name.len > F2FS_NAME_LEN)) {
+		f2fs_err(sbi, "invalid recovered filename length %u for ino %llu",
+			 fname->disk_name.len, inode->i_ino);
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_handle_error(sbi, ERROR_CORRUPTED_INODE);
+		return -EFSCORRUPTED;
+	}
 
 	if (!IS_ENCRYPTED(dir)) {
 		usr_fname->name = fname->disk_name.name;
@@ -184,7 +192,7 @@ static int recover_dentry(struct inode *inode, struct folio *ifolio,
 	}
 
 	dir = entry->inode;
-	err = init_recovered_filename(dir, raw_inode, &fname, &usr_fname);
+	err = init_recovered_filename(dir, inode, raw_inode, &fname, &usr_fname);
 	if (err)
 		goto out;
 retry:
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
