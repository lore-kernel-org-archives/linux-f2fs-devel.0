Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B6CC2A09B
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hTg05UHhl+RmVNSOSY7pTVc8F+B7Rjx9bKkz86VEJ4Q=; b=RJFnqUxETPHPhMkKlluWfhAX11
	EiLuKTERZyZd+N2fhIR7HyFE2/rWG7J2Pc7wFArefSiEsxcK3h/TzAwFMbVmnUC8EfLhojlCMZrIb
	dg5SbWE6METdblrRTv0N71B2JrrRyhoxRcLEJ4x7glkTORB8ficDZtrohv29bbKKwPjU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wsMZn-00084z-2a;
	Fri, 07 Aug 2026 15:33:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wsMZl-00084h-31
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:33:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ONjh5TUXhhK3JhleuwW/hxnhM9FZ/AtVZQ6QRhWPGNg=; b=mSL43IA+tG3hC18W17scbeTxV9
 stxUcTof1jrZsYq3691clSP1Buq/aUDJ+UNO4itrDvFFdcqwki3Hd40Et7zK0eMkO8y1g/3J5wG5f
 nNL/yhZyX30enStnYNPftcRXOqj5u4Ir/DHe64yOHV/eKv0eLoykZaLeqiy1p0qYzIPI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ONjh5TUXhhK3JhleuwW/hxnhM9FZ/AtVZQ6QRhWPGNg=; b=j
 b6YjzRoskGBdXCAsZq7FvVY7ttmHB0PJV2iNfJrzv8ICZfk/ihSM1d5mpPjLhhq8+kVjsfFLH5Wpr
 Qu4jwVlmxHsIlXKWWOPcsuUGTklEc2vhocAzFV4F3HLMVi8Eqlsb4ngtXFllz2RjEJ1gTrTA5gX1S
 f0dCt0gjmrz+Y5wQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wsMZn-0003iw-S5 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:33:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BB2764391E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  7 Aug 2026 13:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73361F00ACA;
 Fri,  7 Aug 2026 13:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786107980;
 bh=ONjh5TUXhhK3JhleuwW/hxnhM9FZ/AtVZQ6QRhWPGNg=;
 h=From:To:Cc:Subject:Date;
 b=IlTsade1fqwQh4LWylCX3ZCxiuTxqVYw4S0XGJOPRrD/lIcZbOEIU/c1rk7Yj32/+
 pg8DUrnm9ALqJleoPnE2oj9ooQIxSWVSGeA2olpfeSCy7g06tZNttr4IEI4dIe0lgt
 LYINJVWVxSjsmy7HM0OJ14Fs1JJlhQws96ve+8bAmFbRWiSKk6BDDzJj7fAVZF/Bld
 sBwpMiMLRKjfU06fJZ7I0w8DJG3HXj9qB0lmhUq4jbJphEKQERS7+ahllC9smANTC8
 1dJVAW36wewkdLy6uqSHGHMSz6dNsyJIhwtYoViNi4xL3TCEvFTHGPb4s9DEt8RKR5
 tNAdhaLqG8/ng==
To: jaegeuk@kernel.org
Date: Fri,  7 Aug 2026 13:06:09 +0000
Message-ID: <20260807130610.2615940-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
MIME-Version: 1.0
X-Headers-End: 1wsMZn-0003iw-S5
Subject: [f2fs-dev] [PATCH v3 1/2] f2fs: fix to off-by-one issue in
 f2fs_zero_post_eof_page()
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Otherwise, it will drop one more page after new_size which is not
necessary.

Cc: stable@kernel.org
Fixes: ba8dac350faf ("f2fs: fix to zero post-eof page")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 56529a82e027..9dbe509926b2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -50,7 +50,7 @@ static void f2fs_zero_post_eof_page(struct inode *inode,
 	if (lock)
 		filemap_invalidate_lock(inode->i_mapping);
 	/* zero or drop pages only in range of [old_size, new_size] */
-	truncate_inode_pages_range(inode->i_mapping, old_size, new_size);
+	truncate_inode_pages_range(inode->i_mapping, old_size, new_size - 1);
 	if (lock)
 		filemap_invalidate_unlock(inode->i_mapping);
 }
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
