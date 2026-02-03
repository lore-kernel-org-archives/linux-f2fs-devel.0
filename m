Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF51DE83065
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Feb 2026 09:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DCmOoLqyp4rhNryWL7eFlpeRftaCY9udKakAX8WT91E=; b=ATCRIy4b5XmnPHWMr5upnx8d4c
	SyAjYQGHuwBXVWQcT4f4Xn10V6iG3WlHspa1r8Yt2ElUnk7jRK5rSV04vtNx0K/5T/YAYQIKw5lBg
	upF7xurfUH6Ov6vy2OJziGdWG3TnDcwZhDSHjiESNJ4F78u4dgzO37llrxLLXq5j4dFk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vnCTa-0007W7-D8;
	Tue, 03 Feb 2026 09:13:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1vnCTY-0007Vz-Oi
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Feb 2026 09:13:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yjZfH6bz5pShRJYAhug080bcmcoUe4xbRgRq6K1+Q7I=; b=eTlzOu8XrNs6clDJvkXmIlKxmZ
 1xU30NSEDkWj2eYEBnPBGPwteuxb7jH3xobDPNnPi5ZnG3A9zJ0eqPIkqykFC7XZ3GYHCSMmEt4+1
 GbAzr1RHKHO2ArJbD+uqyWDDLPZiLkqJBeBd4hDK+0S3OXdg+EUVnXL8mu2wqxxDuP/I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yjZfH6bz5pShRJYAhug080bcmcoUe4xbRgRq6K1+Q7I=; b=M1sskeVLelP3n9Yd3pZ5+EomcF
 16O2+XnZuImsJcX0iytGC4y2pkVagkXYZGCtFApOs9/ydxcK4RIvQXNAC/My5GgZF1SS2wNfwkMs2
 i54pZ2PzS3qsUCWs1VJ87LPBWByh+uFoNdl6WHfdRpGTSmHxxXINt8nw4a69DES1snzc=;
Received: from m16.mail.126.com ([117.135.210.9])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vnCTX-0004WD-T9 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Feb 2026 09:13:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yj
 ZfH6bz5pShRJYAhug080bcmcoUe4xbRgRq6K1+Q7I=; b=NznS2U2IwUMstu58Mm
 zYS1ccIgXDxXR+/J9o3A+46gb8ErSwpReFrJFlmWnqSUCTQgAykhNx+A0vhxcwtX
 I1Sl4JI0wqSSSZ0jDvA9sMckpyEBrNDVG8cUbU+IM+tIqFNkWDILTlJeE7fxKmGq
 9J7C0NgRzu8e9H/37EpO/NUf0=
Received: from YLLaptop.. (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wD3l2kivIFpOegGAA--.25117S3; 
 Tue, 03 Feb 2026 17:13:10 +0800 (CST)
From: Nanzhe Zhao <nzzhao@126.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Date: Tue,  3 Feb 2026 17:12:48 +0800
Message-Id: <20260203091256.854842-2-nzzhao@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203091256.854842-1-nzzhao@126.com>
References: <20260203091256.854842-1-nzzhao@126.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3l2kivIFpOegGAA--.25117S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF48AFWrXw48Xr43XF1rXrb_yoWkWFg_Xw
 18AF1kGw1fGryft3W5Cry5AFZagF1Fyr18ua17t39xCr1YqrZ3Ja1qqr9xXw1qg3WUJrs8
 Jrs7Xr4I9347ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRCg4SPUUUUU==
X-Originating-IP: [58.240.165.118]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBogbywmmBvCb9VgAA3N
X-Headers-End: 1vnCTX-0004WD-T9
Subject: [f2fs-dev] [RFC PATCH v1 1/5] f2fs: Move f2fs_folio_state to f2fs.h
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
Cc: Nanzhe Zhao <nzzhao@126.com>, Barry Song <21cnbao@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Move the definition of f2fs_folio_state to f2fs.h
for upcoming changes to PAGE_PRIVATE functions.
No logical change.

Signed-off-by: Nanzhe Zhao <nzzhao@126.com>
---
 fs/f2fs/data.c | 4 ----
 fs/f2fs/f2fs.h | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f70efb040c73..3a40db6894fc 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -35,10 +35,6 @@ static struct kmem_cache *ffs_entry_slab;
 static mempool_t *bio_post_read_ctx_pool;
 static struct bio_set f2fs_bioset;
 
-struct f2fs_folio_state {
-	spinlock_t		state_lock;
-	unsigned int		read_pages_pending;
-};
 
 #define	F2FS_BIO_POOL_SIZE	NR_CURSEG_TYPE
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a6e7368fc40a..bdcd446f6b18 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2042,6 +2042,11 @@ struct f2fs_sb_info {
 #endif
 };
 
+struct f2fs_folio_state {
+	spinlock_t		state_lock;
+	unsigned int		read_pages_pending;
+};
+
 /* Definitions to access f2fs_sb_info */
 #define SEGS_TO_BLKS(sbi, segs)					\
 		((segs) << (sbi)->log_blocks_per_seg)
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
