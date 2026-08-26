Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CD3C61DC6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/7gv3om7dlXz1Zc8N0TXqUff63ViFeXzAtn3Ycnhe5c=; b=kPGDgJTzPkeUemPn8nGJrSPL68
	24MV0ynSWPAprKrJYyGtK/Tv91ofWUts8jhkVoaYn3RU4WzBIqsJ3KtPyEwqxsg9J9vEW3TfJN3+W
	xglpn3wcuAIYF93nL3vMu16sUpPrN0XnihtVgsW8vCh0r4b/4N6ZrIpOUY9WBmrRvAoI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzF9X-0006sm-8G;
	Wed, 26 Aug 2026 15:02:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1wzF9Q-0006s6-QD
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:02:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HB8vD9Vghuu1IqwMhGeSD/BVqt+ianc/vWTayOF09mg=; b=FjszhVQXyN6lk1QxYzFTuQmRSJ
 glMkQKxH1UKYGnCTa2dHqcN2w6afJS41R6Do3pMgsZ+knuc3m8zstSvzoMhjf3htxIh0OlgWMrfAN
 7jsKVy7dgNMaipomb4QVxcmnoXoYneOtluVcqRlFOyugGch4llbePz6Iq70l4Yy6xx4k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HB8vD9Vghuu1IqwMhGeSD/BVqt+ianc/vWTayOF09mg=; b=GvBc6VmoCwqo8IIN3QGpato0cl
 VSAzUxEhyz36feS7AnHOyQnNyhc59wSQ66jJ71/beU56hB6LSaByFJmBfX6Y/FdsG6/20CzZBQfEb
 Sona/eQfOzHw0QMoNUoHoWSsqiejThLbC8XV4HgKKJBLkYdaVOvY/5sIjCc6xTv+m7jo=;
Received: from m16.mail.126.com ([117.135.210.9])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzF99-0006Ui-Vf for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:02:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=HB
 8vD9Vghuu1IqwMhGeSD/BVqt+ianc/vWTayOF09mg=; b=JRRbX9XSxud2L0P30k
 ZonoXSo4ojNeZmJT+OX252a7M/igxPQOqZaqmIbBzmPXkH6Mbkb1LQvMF8Mbn7Vi
 o5eg2QvOuA5kbjQ5XEBSTl79EMwwUUCLeV22DD6drCdrbAlWAtbUcrqS4EzYmsDA
 VbQt4JRRwhRpYGWEban9kvNdg=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wB3P5N85Y5qx4G3Gg--.15517S5; 
 Wed, 26 Aug 2026 21:09:19 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 26 Aug 2026 21:09:15 +0800
Message-ID: <20260826130916.2231342-4-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
References: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wB3P5N85Y5qx4G3Gg--.15517S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr43KrW7Aw4kJFWDtF4DXFb_yoW8Jw48pr
 WUGryrKrZ5Xa4j9w18Ja1qgr1YyFykGay7ZFWxGw18AF15Jw1F9FyxK3WS9FWUKrZ3Z3Wv
 va15KFy8Xan5taUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joc_fUUUUU=
X-Originating-IP: [114.247.175.250]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsR-WpmqO5X9YngAA3m
X-Headers-End: 1wzF99-0006Ui-Vf
Subject: [f2fs-dev] [PATCH 14/14] f2fs: make compressed files compatible
 with large folio
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
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The compression flag is the hint indicates that the inode can be
compressed, when the inode is using large folio, we expected it keeps
using the large folio read/write paths and its data stays uncompressed
on disk until the inode is evicted and re-read

Let f2fs_write_begin() skip the compression overwrite preparation for
such inodes and remove the compressed-file gate in
f2fs_read_data_large_folio() so the data is simply read/written as
regular blocks.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2e20833c6417..befcdc3742f6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2955,12 +2955,6 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	int ret = 0;
 	bool folio_in_bio = false;
 
-	if (f2fs_compressed_file(inode)) {
-		if (folio)
-			folio_unlock(folio);
-		return -EOPNOTSUPP;
-	}
-
 	map.m_seg_type = NO_CHECK_TYPE;
 
 	if (rac)
@@ -4935,7 +4929,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-	if (f2fs_compressed_file(inode)) {
+	if (f2fs_compressed_file(inode) &&
+	    !mapping_large_folio_support(inode->i_mapping)) {
 		int ret;
 		struct page *page;
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
