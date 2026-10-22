Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39847606A319
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Fad3kSq5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hgLWnkeL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=csEfx3Fp;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SkKv3r0q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=JdUp9lrcCIPYxGupFui0bomf2Ii4RTuDkEinr8I7h3Q=; b=Fad3kSq5YBlqI+wWE+Nt4VrfTg
	9hXIWo+TcvQNrzwigTvECNtofa9kkReVYrZzG4AAE92ZHwGEhjGQmcS6l2/z3LIG8ivgL52abCG2q
	GTM9TSh590tdY0YLzGpQZLZfhVtoFNvZ4R/zY8IVadv6Clzn+nVv4q2IA4M6ipWDRH9Q=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJndI-000000006yc-40EX;
	Thu, 22 Oct 2026 07:54:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xJncz-000000006wX-0IJ9
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 07:54:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dbX8nwakU6g+Gs6/KxYHt1pBiW5NFblLEduXjkYsL8E=; b=hgLWnkeL5tm31hRJhy5kiHyrHD
 6Uy2nnkY68GC5OUqE3s+BkH+1/niQgzHlE5XhDeu25oDDO+PfO7xUrYgPgS3kFKhaNqHeh+UsJCa+
 UxW0a0pMdZxNeXKqtDDS8hC0vUgdYJjg8S7jkQyPHIvQLoNU6wyqxAbX2K7fEHoXbNe0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dbX8nwakU6g+Gs6/KxYHt1pBiW5NFblLEduXjkYsL8E=; b=csEfx3FpDRkKrA3iepokwD3Ksx
 perRuV07rWi8PR09qivSp/QLkgXlkA7Z5U7HLDoqwBLr41/Bui1ok+8+mfWcPq2AhVmLvOV4hw2fp
 7cfcbVluamYH4bxqyk9fO/IwTXBlPSDLYYxy8kkMF0AyiYy++ZHfeU7dz4bNxoaAeWB4=;
Received: from mail-pj2-f10.google.com ([74.125.227.138])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJncq-000000004zx-1H2t
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 07:54:13 +0000
Received: by mail-pj2-f10.google.com with SMTP id
 98e67ed59e1d1-3abe4fb64d2so756930a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 00:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792655646; x=1793260446; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dbX8nwakU6g+Gs6/KxYHt1pBiW5NFblLEduXjkYsL8E=;
 b=SkKv3r0qAKkVoSXghOwz2qHpPIEGwvXm/I85WbdDjL3mQcHcmvOGmxqWzH+N00hCvS
 wL08J0SkI00iffu3Zh1HmeS46UZ9uO5FBb7oDOy2HCWMWHf/z+Olaf6Au1cjm/SzA9VW
 Vz/Mv0sCaU/yCx2mzo17DeIZhZVCpUnTB5EYR/pUXYGyimvWYreQCpssLFv9yEjrntev
 HShCkqPjgJECZTesBImyIuzRk0L70uLQps2H8qinGnQ0nhtBUWxlobxLdPLtIyCe3cxY
 O+mmqnTZwFXDMYYiVYcY9wjtSRZXQznyeNs8QSdb6hLzYsu23evrlHOqXsXQoS9fKR2O
 2PAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792655646; x=1793260446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dbX8nwakU6g+Gs6/KxYHt1pBiW5NFblLEduXjkYsL8E=;
 b=tF0g0wJdhTFez3konf2ND2Td9AQf3Eg9sFuKrjjA0NdUgxbl5dro4BnBQnqg9/I3tz
 ieDu1VLMLV14vT6LQib48crai0eEl1++sCUz/Ws6n7zi3nQJC0vsmmsh/a9YtcpcKDs6
 7JoZPxHSMi5xTItxUh9UyHRK4RSPLvU6SYiwSP2jwbMidgTKVMK4fbU0OeT74LW6Mxbe
 bgyQ0ODefd3kRK5xdIkx+vXB9J4jh+U0x/MyG27GiWvoh9eOtjtlWl1yWUMXXq5gtHEP
 63J8eBAD86Stz50cZFJuqEOgGPTd1E5QwjB6o+Ot9/xzBic2dXaN1Q7XIuwOZZ/j3bG4
 gt8w==
X-Gm-Message-State: AFq9FYKQDM4BdRAIEMBBWx5z7KgJ19F1vm2cuf3WW7r77o4xn5gvU1vh
 wTmAlYh/QQ28FdsBjc2c0z1Ul1tAPr+c//Yw9oLsVhcNbn0WoQts92PJnU5kpnedL+I=
X-Gm-Gg: AYBFou3VPxwvJBZRIr6LVdTW73rL7YxEeu8bBYUQ84w3lyFfmmYCXriwh90TIi9WtfQ
 DGPQK94eyrzJIF3AvGVCXIONd4gRWD2iNutVQB7SBgprPaqJLlzsBejV7Iju23a1H6uWpoDj6Ux
 UQYqMWfXtEwGresJ3WAxYjd+FYgjO1wL8Qozts8ovgyxfg8D6MhYsnb48rR1kBEP2UuBcsp/miK
 zBMKDfRW3284rFX3T6EfJeT/ImdDJyAutMC9jVy/GkMwTamUTGzNRbYWDJbt6c9KtS9O2TXbqPN
 sJPEjNqPr/BI5x4NcodUEkdVQgYHaHZMRNgK4GOSmYwt7YObWoChHie9i/ikGMSWbjSX59HtCzb
 2k0uosxJdb4Wx06DsPA0bdQR4mqpeHDsj3bO8Yq4moxmt/S3AQzGOJwoSTSY4bzlowwUvO55TQd
 eGKnehI3RTomtfmKZAw4czOK5UyIMUDjjdNj42/Sctprrr91uNG8jmdB1owAdoU6Jq/BTjH0oaj
 2eG3hTFF+wJL0qZw5d2bCPkLLAV+YozYA/XD207zf+9KhDZoOjZCLMbvSwQHtcgEnG/ajYgNmKd
 q8/rGX9zRiM9ZinWxw==
X-Received: by 2002:a17:90a:e7c8:b0:3a4:b0a1:c7ed with SMTP id
 98e67ed59e1d1-3ad86e97f59mr3590074a91.13.1792655646453; 
 Thu, 22 Oct 2026 00:54:06 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada4896c71sm3202562a91.6.2026.10.22.00.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:54:06 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Thu, 22 Oct 2026 15:53:31 +0800
Message-ID: <20261022075343.3043003-5-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022075343.3043003-1-nzzhao.sigma@gmail.com>
References: <20261022075343.3043003-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJncq-000000004zx-1H2t
Subject: [f2fs-dev] [PATCH v6 04/15] f2fs: support atomic file large folios
 buffered write
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

ioctl can convert an inode with large folio support into an atomic
file. Support large folio buffered writes for atomic files as well.

Add a large folio atomic write_begin helper that reserves COW mappings
for the write range. For partial head and tail subpages, read the
existing data from either the COW inode or the original inode before
marking the subpage uptodate.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 70 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ffc25eb09a92..e3d6e3087bb9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4287,18 +4287,16 @@ static int __reserve_data_block(struct inode *inode, pgoff_t index,
 }
 
 static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
-			struct folio *folio, loff_t pos, unsigned int len,
+			struct inode *inode, pgoff_t index,
 			block_t *blk_addr, bool *node_changed)
 {
-	struct inode *inode = folio->mapping->host;
 	struct inode *cow_inode = F2FS_I(inode)->cow_inode;
-	pgoff_t index = folio->index;
 	int err = 0;
 	block_t ori_blk_addr = NULL_ADDR;
 	bool cow_has_reserved_block = false;
 
-	/* If pos is beyond the end of file, reserve a new block in COW inode */
-	if ((pos & PAGE_MASK) >= i_size_read(inode))
+	/* If index is beyond the end of file, reserve a new block in COW inode */
+	if (((loff_t)index << PAGE_SHIFT) >= i_size_read(inode))
 		goto reserve_block;
 
 	/* Look for the block in COW inode first */
@@ -4480,6 +4478,61 @@ static int prepare_large_folio_write_begin(struct inode *inode,
 	return 0;
 }
 
+static int prepare_large_folio_atomic_write_begin(struct inode *inode,
+		struct address_space *mapping, struct folio *folio, loff_t pos,
+		unsigned int len)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	size_t ori_off = offset_in_folio(folio, pos);
+	pgoff_t start, end, index;
+	int err = 0;
+
+	len = min_t(unsigned int, len, folio_size(folio) - ori_off);
+
+	if (!f2fs_ffs_find_or_alloc(folio))
+		return -ENOMEM;
+
+	/* Inline data must have been converted before reaching here. */
+	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
+
+	start = folio->index + (ori_off >> PAGE_SHIFT);
+	end = folio->index + ((ori_off + len - 1) >> PAGE_SHIFT);
+
+	for (index = start; index <= end; index++) {
+		block_t blkaddr = NULL_ADDR;
+		bool node_changed = false;
+		size_t off = (index - folio->index) << PAGE_SHIFT;
+
+		err = prepare_atomic_write_begin(sbi, inode, index,
+						&blkaddr, &node_changed);
+		if (err)
+			return err;
+
+		if (f2fs_ffs_test_blk_uptodate(folio, index))
+			goto balance;
+
+		if (blkaddr == NEW_ADDR) {
+			folio_zero_segment(folio, off, off + PAGE_SIZE);
+			f2fs_ffs_mark_subrange_uptodate(folio, off, PAGE_SIZE);
+			goto balance;
+		}
+
+		if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
+					   DATA_GENERIC_ENHANCE_READ))
+			return -EFSCORRUPTED;
+
+		err = f2fs_submit_page_read_sync(inode, folio, index,
+						blkaddr);
+		if (err)
+			return err;
+balance:
+		if (f2fs_balance_fs_folio_locked(folio, mapping, node_changed))
+			return -EAGAIN;
+	}
+
+	return 0;
+}
+
 static int f2fs_write_begin(const struct kiocb *iocb,
 			    struct address_space *mapping,
 			    loff_t pos, unsigned len, struct folio **foliop,
@@ -4569,12 +4622,15 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	 */
 	f2fs_folio_wait_writeback(folio, false, true);
 
-	if (f2fs_is_atomic_file(inode))
-		err = prepare_atomic_write_begin(sbi, folio, pos, len,
+	if (f2fs_is_atomic_file(inode) && !folio_test_large(folio))
+		err = prepare_atomic_write_begin(sbi, inode, folio->index,
 					&blkaddr, &need_balance);
 	else if (!folio_test_large(folio))
 		err = prepare_write_begin(sbi, folio, pos, blen,
 					&blkaddr, &need_balance);
+	else if (f2fs_is_atomic_file(inode))
+		err = prepare_large_folio_atomic_write_begin(inode,
+					mapping, folio, pos, len);
 	else
 		err = prepare_large_folio_write_begin(inode, folio, pos, blen);
 	if (err) {
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
