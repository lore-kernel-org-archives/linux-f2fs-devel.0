Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F85C77B7F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Jun 2025 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UNa2O2GewYe9AJnzzSkHr6VDW0W2AT75eO2qJKjG3zU=; b=NJsPdjiOl4ZIzlJ6kYFj6RHCgN
	eGln3QLTbDSXChJX/mf10PY4AmQiS6J38b8jtedVDD7abtIEAi7UbplUz6Dw7X76A703B1FtIa3WL
	1VF29wmrbvAg1+10np4GOisSNDJXKvDbbFvSfCGLwUeTm7WgwuqVeQWRxxPEy5jzMnD8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uU7Ae-0002JS-4Y;
	Tue, 24 Jun 2025 17:10:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <abinashlalotra@gmail.com>) id 1uU7Aa-0002JJ-Sp
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Jun 2025 17:10:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lG+ZZuTebOcNyYjtmjeeFWTjaLvNrp0eyAHME7aTcJE=; b=RzIVFlais7eYKxP7TPxRZWoyeT
 5qAsoCUgf7TtS/J8RG7r00Dngyq7lGluGeHzpLpZY4ssfft9KE2KQbLBxeWOJBxighy79j5bNYKsR
 ijs3+J5c1Ir9sc+MuXfQ7+XZHpwyn/+YtxaLfxgqBK+GBD5GmcM5OCWj4qrUibRdIKn8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lG+ZZuTebOcNyYjtmjeeFWTjaLvNrp0eyAHME7aTcJE=; b=IML2cGemk7SPhD6x6REDwLJlzY
 2pwKO1g43IhYKF6cEYt0B9OvbO++FIPC1r7AD8ggJmKlR8b/nF+e5rwdnH5kJq/xtyPx77b0FYAlJ
 QH42TLCCtw37owvNe24w3GoFQIsH13dQWoUH7TBYx6BqQE+Vazno+X+fv7ii1nE8f94U=;
Received: from mail-pl1-f172.google.com ([209.85.214.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1uU7Aa-00068R-EI for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Jun 2025 17:10:52 +0000
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-235d6de331fso82301445ad.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 24 Jun 2025 10:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750785046; x=1751389846; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lG+ZZuTebOcNyYjtmjeeFWTjaLvNrp0eyAHME7aTcJE=;
 b=U11d6iO2kJKRoNnPERkeyHYh7sQfRnCnilPN/ddT4oDFwcfRjSHjzFkHOlOzqmuA4f
 zYqyqmU8efpzuSJ3McTHaYjyMrCu0NpSOO5mGZd0k69jwlDan4Yze0di/9yzWVtIOGTJ
 QG0h4X+PSng/1tPCNAHc50Pl4G5OVcHgMv3AeM2cJCRxc/o1JadUBcA9tKZwa5uoXVo9
 nMj0jxwlTwjyhI0hhigWW/b6uojeBgF1IzK7xuuCxAJUW32m7uutyTY1tmAZpon8NdFZ
 0nefBoIjHACczD8nICFxY/2KNXV1KclxrzYqMtrrxVWH3BUqRlV/7spmgoN+NXF7kLsu
 8r9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750785046; x=1751389846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lG+ZZuTebOcNyYjtmjeeFWTjaLvNrp0eyAHME7aTcJE=;
 b=HmKbecGcrEynQfDTIw53DyhUkixr31rs1jbg2mmvcwZYtv/00coWBKfBmPBXfIcU0Q
 9g/CVSUixLgqAfIEnFr2CULwfaEjBbnMDSu/Bpyw8KKffvji8dmaqcBUC2yWLZPbCK5f
 N7nTVpUhecKx89wz1M6iAxGqueAND/x7BSDivcuKtaRHCK0kC8KsY6fMFJv3lOgXKysr
 XuV74FoLwpCUPATqtsMLtXZNlcjvgG89S+QUrFZX4AyaQdyFg6nhDn0LhqwvJ4301rey
 yLsSpc7T21ptMvb4ny1ky3nluLgjNeRN832IUDWmxQkvgUEhqEirlkw0DqOtnGrM8uI2
 HwXg==
X-Gm-Message-State: AOJu0YytR3i+KgCWULVf1S9PJOncTyTowxr5UhLANpOULa7T0+NgIufa
 vjebxmPbSV3DFRboAfwFBu4LbCab6p01dRuirzJV7LkucnpadaNyol/wTTD2hzy3
X-Gm-Gg: ASbGncsRWx7eD397w6QvubyS6C4ix9lj4lQfHH2RZHDfshQ26iJZM87jA5uwSoom8sc
 6Q1Yn+iy0R+yP2IM/I3gw5xgw2BIGk+3ZnQrtvLecYZa/SxFGerxDnqrQ0kR6ADvkiKo7ywDJwF
 Ml6XhBbrgOB+vk50PBaZ7tVeP9Gyrfaz2UempO5kZRquk3uAQJqOVIOGds6RwDtbG0QumQu/W7b
 pNzm5ceQQJiOm0ma6eZ/NRNwcs45y6rReKHIdxHwWmZfsR2mrTkBaYLOklfqIDegpgaIC616vJK
 wJH+wWurCKE0B5c7KZhEaBOpD9o12vp0GtDqVaeZ2Y5wiuFt+vFihYWFkXr98hnOPv+zucH0yS2
 L4uz5NpseBDAdCnIr4h+p
X-Google-Smtp-Source: AGHT+IHQ+kKtjXs47Z0CsvSOM6Q2xOutPeY6vjjbt/IWFEEiKukZaAkj6ZuCQOvD6igvW5iETOwfYw==
X-Received: by 2002:a17:903:b8c:b0:237:e3a0:9d63 with SMTP id
 d9443c01a7336-23824060224mr1267205ad.43.1750785046407; 
 Tue, 24 Jun 2025 10:10:46 -0700 (PDT)
Received: from avinash-INBOOK-Y2-PLUS..
 ([2401:4900:88f7:9fa5:7c44:c012:b691:46c1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d83efa44sm112033045ad.77.2025.06.24.10.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 10:10:46 -0700 (PDT)
From: Abinash Singh <abinashlalotra@gmail.com>
X-Google-Original-From: Abinash Singh <abinashsinghlalotra@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 24 Jun 2025 22:39:48 +0530
Message-ID: <20250624170948.59013-1-abinashsinghlalotra@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1669c05c-7468-4347-a924-cfc4145c8c75@kernel.org>
References: <1669c05c-7468-4347-a924-cfc4145c8c75@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1uU7Aa-00068R-EI
Subject: [f2fs-dev] [PATCH v3] f2fs: fix KMSAN uninit-value in extent_info
 usage
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
Cc: syzbot+b8c1d60e95df65e827d4@syzkaller.appspotmail.com,
 abinashsinghlalotra@gmail.com, linux-kernel@vger.kernel.org,
 jaegeuk@kernel.org, abinashlalotra@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

KMSAN reported a use of uninitialized value in `__is_extent_mergeable()`
 and `__is_back_mergeable()` via the read extent tree path.

The root cause is that `get_read_extent_info()` only initializes three
fields (`fofs`, `blk`, `len`) of `struct extent_info`, leaving the
remaining fields uninitialized. This leads to undefined behavior
when those fields are accessed later, especially during 
extent merging.

Fix it by zero-initializing the `extent_info` struct before population.

Reported-by: syzbot+b8c1d60e95df65e827d4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b8c1d60e95df65e827d4
Fixes: a28ef1f5aebe ("f2fs: maintain extent cache in separated file")
Signed-off-by: Abinash Singh <abinashsinghlalotra@gmail.com>
---
v3 : Added Fixes and Closes tags
---
 fs/f2fs/extent_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index cfe925a3d555..4ce19a310f38 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -414,7 +414,7 @@ void f2fs_init_read_extent_tree(struct inode *inode, struct folio *ifolio)
 	struct f2fs_extent *i_ext = &F2FS_INODE(&ifolio->page)->i_ext;
 	struct extent_tree *et;
 	struct extent_node *en;
-	struct extent_info ei;
+	struct extent_info ei = {0};
 
 	if (!__may_extent_tree(inode, EX_READ)) {
 		/* drop largest read extent */
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
