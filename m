Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E341075276
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jI8e5iXyiZGCQh3e7pYx+aeXDtW0ngwrHew4quBa5MM=; b=BKVAK3qKi9heJNpvlLHeTbjAzL
	BlttFzWuX+78cXxpqkH4sSPX8W0xihbeTRmT+hnJiYKgeJtk3gNQepzqs4Q0vbRSHwr2yJwAc9BY7
	VkJfyAoGwbG9TSOnt4a/u+6cll9sJwrid//ZDDaHKZTFWTHZKXpQIQF/CHkpmkNRnR3Q=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w38tF-0005AI-G8;
	Thu, 19 Mar 2026 08:38:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1w38tD-0005A3-V6
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Mar 2026 08:38:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JwG6MhKduduFbMjJXKgLpkSSgn8bAwG/EPSdsHWRu3Y=; b=VY/UJVdxMyLVWcJ4nfnNouE8V7
 lgVwONQwsPGcAq+oTVyR/IFoUTGqw9k7znxGXUzk40TIs32VxwMZ+Kh9m1KcePsxGvM1jfAGzxjaL
 lLGB1lpkBF2+4gouYAIp5OrZgdRXsa3VknEpQo1YttMM4R7oR7sBMpC32fJnZp1MB+nw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JwG6MhKduduFbMjJXKgLpkSSgn8bAwG/EPSdsHWRu3Y=; b=a
 aOY9GRjQfPlYQrKrwkleKjVRDAoB9Sdn8sTYQ/szjze7ndb+GZsq7ULx6HXxxWmuLhNijUvgwq9JF
 V5blAmcidGKewUOGrCDEqs9hx7kmhYPnq02D2OhC6iO8ZENqwzNAqbLp3IOZwVpFl9fillwnZ1FWW
 KqsQTISACe7y5ZCQ=;
Received: from r3-18.sinamail.sina.com.cn ([202.108.3.18])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w38tC-0006VY-9O for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Mar 2026 08:37:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1773909478; bh=JwG6MhKduduFbMjJXKgLpkSSgn8bAwG/EPSdsHWRu3Y=;
 h=From:Subject:Date:Message-ID;
 b=uAqehWN5bPrCuXx8Ue3eAkuJquU8HalNjeN2u0r6v8ivDnqqmrdeumbHPmxgawocV
 a6MgYQ/3QAYjeLz/u+5wQ1zM/BRvsoOGOcV8NgEH6IAU2BsKKbDLz1AeLoJST/M+Za
 MzOvZq2k0JAzffJEmLNNdb9zLyiWYDg6cYi7afeM=
X-SMAIL-HELO: xiaomi-ThinkCentre-M760t.mioffice.cn
Received: from unknown (HELO
 xiaomi-ThinkCentre-M760t.mioffice.cn)([114.247.175.249])
 by sina.com (10.54.253.32) with ESMTP
 id 69BBB5D700006EFF; Thu, 19 Mar 2026 16:37:45 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 8185774456816
X-SMAIL-UIID: 62863E60861949E3BFFB23B206D84E21-20260319-163745-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 19 Mar 2026 16:35:27 +0800
Message-ID: <20260319083525.603728-3-monty_pavel@sina.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1w38tC-0006VY-9O
Subject: [f2fs-dev] [PATCH] f2fs: drop unused ri parameter from
 truncate_partial_nodes()
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

The ri parameter in truncate_partial_nodes() is unused. Remove it along
with the related code. No logical changes.

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/f2fs/node.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 6bb810d0f4c3..497712f7bdaa 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1116,7 +1116,7 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 }
 
 static int truncate_partial_nodes(struct dnode_of_data *dn,
-			struct f2fs_inode *ri, int *offset, int depth)
+			int *offset, int depth)
 {
 	struct folio *folios[2];
 	nid_t nid[3];
@@ -1187,7 +1187,6 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 	int err = 0, cont = 1;
 	int level, offset[4], noffset[4];
 	unsigned int nofs = 0;
-	struct f2fs_inode *ri;
 	struct dnode_of_data dn;
 	struct folio *folio;
 
@@ -1215,7 +1214,6 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 	set_new_dnode(&dn, inode, folio, NULL, 0);
 	folio_unlock(folio);
 
-	ri = F2FS_INODE(folio);
 	switch (level) {
 	case 0:
 	case 1:
@@ -1225,7 +1223,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 		nofs = noffset[1];
 		if (!offset[level - 1])
 			goto skip_partial;
-		err = truncate_partial_nodes(&dn, ri, offset, level);
+		err = truncate_partial_nodes(&dn, offset, level);
 		if (err < 0 && err != -ENOENT)
 			goto fail;
 		nofs += 1 + NIDS_PER_BLOCK;
@@ -1234,7 +1232,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 		nofs = 5 + 2 * NIDS_PER_BLOCK;
 		if (!offset[level - 1])
 			goto skip_partial;
-		err = truncate_partial_nodes(&dn, ri, offset, level);
+		err = truncate_partial_nodes(&dn, offset, level);
 		if (err < 0 && err != -ENOENT)
 			goto fail;
 		break;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
