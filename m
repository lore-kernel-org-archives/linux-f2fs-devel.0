Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE10606A323
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 03:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JI2cpqJq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CjPkofGG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=X4fJH0/z;
	dkim=neutral header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=gsAwXELb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=D6LrOcgfPIjUcBe36bssECB379BA56ebbSoQnqoOLtA=; b=JI2cpqJqzCAz1/yXPldXsJPeHW
	pvNeg4DCkJ15knRuPxOIds7FFHWmlAjIxeDx8K2xiGFTQ956rXkFgw7VfsiB5QXJN/oG+g39H5Rf2
	RlApcbPlBWwGDhGasRrGSRgnSqgbgxd2weNUIeYXzF56y6b/KAJ46NPt1fAkHicHXNwM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xT9bq-000000008A6-1HUY;
	Tue, 17 Nov 2026 03:11:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <hengyul@cs.unc.edu>) id 1xT9bn-000000008A0-3rkM
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 03:11:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VU3RfTLNpfs/n3MAsR8jkSfjakNJoajlPmMOjTMtrf0=; b=CjPkofGGttRcTs6rKycsFiqaxa
 aUyJI3MSTFdmp8Oebj/TQB7DlmJydwmZoJQg0tT0Obml9JKFgNonyXf1sSHs6A+rWEWjrtm5DcJPK
 ZK+FJPz83ckdeOWL3dvRBcQh4I2e4ybKOA7fgBDU1rda7VJGmXqS5Af+qTw+hd+QhPtA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VU3RfTLNpfs/n3MAsR8jkSfjakNJoajlPmMOjTMtrf0=; b=X4fJH0/zaTQ5md3xfZwIwur70m
 3EH6vQTUoWYDvs7hVHFd97Plrzk1syYQOjgLbqh3SNGQvjWUr067xZ58FoFVqV5y09PGlmOqLkYFY
 nVJn3iZWDit6asvOc9UgRAZIDREIVDllVrThV721r3/sn71RnoscPFPkakFgbZSuszFg=;
Received: from mail-pg1-f181.google.com ([209.85.215.181])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xT9bm-000000004Ap-1PRh
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 03:11:47 +0000
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cde1479f76fso104094a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 19:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1794885100; x=1795489900; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VU3RfTLNpfs/n3MAsR8jkSfjakNJoajlPmMOjTMtrf0=;
 b=gsAwXELbzQJav0+QzR02Rwt6kgFlpNTzSVh4+C2Gjn5+6gWA2+Y9a3uJXNSr18b5Dw
 X+M6tsQzBQURuWpoz+VYNP9y+1nfBdGsbhAVVAJXO/f2Q3XMl75U8vN+fnXeAE8KHLtw
 YGLoYdw9mtxRTXPProLzZpYJZ+MO3AkfqrpOTDGcy1BUmPq6HjxVc4f4/33sPdg+hFFo
 wfkumZyf/TPf3MGPbK00njr3XrUEwO/eXiteDua3S7hGrK2aaRxakMpbLd8U2xQRZmdA
 uDLWERhmy13GBYlR05Hgm2v0Kid/IGGVJ8fzcB930yp6MKEDsW9bE9zEqrUdk4jV2HKx
 o2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794885100; x=1795489900;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VU3RfTLNpfs/n3MAsR8jkSfjakNJoajlPmMOjTMtrf0=;
 b=qaFf/+ZA8V2a1zMMNB9oxyXCjMz/mFH4GdHsjAMxMCGJXiwvCHS5PQQXQtBA1Ks4em
 49WacPDcvxw8Fm0XkYivOMdzn7073emt+1YsllXRBaD+9InzQHEww3148iUVpvSdDL+m
 EgrFEXDvGJvmskA6xuaf9oMDMkfdx1taQXOng9L9ac3ABBUT8VE+/qnoepK5qfN3+H7+
 DafFLAYPfha2omn4lZarXoZldKliFJEsHdkCaUIXFSkyHz++5xV/9RGXbqQ/DjBy81vd
 KOuugFXYe+LGvE3MWLcxocxSK7N6Xo7GMb5Yl1VOxBgNz+vUhD967T3oGH3y2pcpkCHD
 STWw==
X-Gm-Message-State: APuU4Z/MwlAqrMQqSpkg5iXqywlgedT1CtVcwab0W3ZzuXMeLwrPMto+
 fQrdhuo6IOVm1lHcN+WdsuaVJEm9B0cmRy3zxk3wzpznPOx0rnA8G1QGuOCc4vTT/Ps0jBf8P8h
 hey5rIHwu
X-Gm-Gg: AYBFou2+Z0J2cjoeh1XMJRtgJKMF6JkLjtiBzk8d3wiIjisMYbm4LCD7q2YcfOlOGyI
 d0z/nvIphN9Gehh+s+lneEtczDV2JMUO58c3BNigvn1cgpDJxE2QeuGyhkXaJJ7R4Neo63YL6nI
 B0loGXAYr76v1J83AgFJPHBiLKeCgYlaw40gmNkOIsqninjqZqc5cf/EjGOoh1rqJHe2WIj2mne
 lSQ03c0HrwBNUEIGV2MR/lP0+Hem8fJZ61Kdwcb7vxU4Lzl8RQE6M/VclOlCzh2C2+waPyVsJz/
 GimiDJS1PCP/6+80X0DMdOMXjusJPwl1xMY0LbQ9FVDW1MMlHgJ8DvzmWO4J0uOKjhh/Q+OXW2B
 6yLSxymFXCiyVZAMK+UoGDhLOl7qYY6imzD+UftkHnEznOqyzJADpN4cOUiGz24VeJyFUe4oX0O
 GoXEXoOts8Gr0duVNUdT4GSQGwDDQW/UgoyW7cLacUl93eU+zj0nLtRJOajKOuanaIcLM3ApfHJ
 DECjYn5TUjI6Zi5aCvRlDX5hh70ZbtYaLrtvLRppULGPd2+TY+l3g8T5LHMruVHHTpVgIkcAROF
 G4jAmsAYAwoI0lCPFXFw5EsVoGy4+kd4BAwduh67/dZX316tB1ho
X-Received: by 2002:a05:690c:e08a:b0:8b4:d882:4a14 with SMTP id
 00721157ae682-8b4d882572bmr17276377b3.5.1794883161880; 
 Mon, 16 Nov 2026 18:39:21 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4ec46a9d2sm13822747b3.45.2026.11.16.18.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 18:39:21 -0800 (PST)
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 16 Nov 2026 21:39:17 -0500
Message-ID: <20261117023917.1583819-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xT9bm-000000004Ap-1PRh
Subject: [f2fs-dev] [PATCH] f2fs: fix data loss when zeroing post-EOF data
 of a compressed file
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Hengyu Liang via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 5eced87b7d19 ("f2fs: fix to zero post-EOF data when extending
file size") made do_zero_post_eof_page() zero the rest of the last
page with fill_zero() and write the page back when a file is extended.

However, fill_zero() does not decompress. When the page belongs to a
compressed cluster and is not in the page cache, it gets a page of
zeros, and the cluster is written back with that page. As of now,
extending a compressed file with write(), truncate() or fallocate()
replaces the data from the start of its last page to the old end of
the file with zeros.

The issue can be reproduced with:

    mkfs.f2fs -q -f -O extra_attr,compression /dev/vda
    mount -o compress_extension=txt,fsync_mode=strict /dev/vda /mnt
    yes | head -c 16000 > /mnt/a.txt
    sync; echo 3 > /proc/sys/vm/drop_caches
    echo end >> /mnt/a.txt
    sync; echo 3 > /proc/sys/vm/drop_caches
    tr -d 'y\n' < /mnt/a.txt | wc -c

Before commit 5eced87b7d19 ("f2fs: fix to zero post-EOF data when
extending file size"), the result is 3, the length of "end".

After that commit, the result is 3715. The file has 3712 zero bytes
before "end".

This patch will prepare the cluster as a write to it does, which
decompresses it, then zero the rest of the page and write the cluster
back.

Fixes: 5eced87b7d19 ("f2fs: fix to zero post-EOF data when extending file size")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Commit fda0c0dcefc2 ("f2fs: do f2fs_zero_post_eof_page for all the
time") in the dev branch drops the fsync_mode=strict condition. With
it, the commands above give the same result without that option.

Application impact (Ubuntu 26.04 user space): rsyslog 8.2512.0 appends
to syslog.log on a volume mounted with compress_extension=log,
fsync_mode=strict. It is started 16 times and gets 400 messages each
time; the volume is unmounted and mounted again in between. On v7.2,
the file has all 6400 messages. On v7.3, it has 6327 of them and 9620
zero bytes.

Tested on the dev branch with and without fsync_mode=strict: files
extended by write, truncate and fallocate keep their data, and rsyslog
keeps all 6400 messages.

 fs/f2fs/file.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 05061254c3b2..59480c3ba2e8 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -63,6 +63,33 @@ static int do_zero_post_eof_page(struct inode *inode, loff_t new_size)
 			return err;
 	}
 
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	if (f2fs_compressed_file(inode)) {
+		int log_cluster_size = F2FS_I(inode)->i_log_cluster_size;
+		void *fsdata = NULL;
+		struct folio *folio;
+		struct page *page;
+		loff_t start;
+
+		/* a page of a compressed cluster must be decompressed first */
+		err = f2fs_prepare_compress_overwrite(inode, &page, index,
+						      &fsdata);
+		if (err < 0)
+			return err;
+		if (err) {
+			folio = page_folio(page);
+			folio_zero_range(folio,
+					 offset_in_folio(folio, old_size), len);
+			f2fs_compress_write_end(inode, fsdata, index, true);
+			start = round_down(old_size,
+					   1 << log_cluster_size << PAGE_SHIFT);
+			return filemap_write_and_wait_range(inode->i_mapping,
+							    start,
+							    old_size + len - 1);
+		}
+	}
+#endif
+
 	err = fill_zero(inode, index, offset, len);
 	if (err)
 		return err;

base-commit: 9b12299b437e0cc3ebf402e7b36a89cc69151238
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
