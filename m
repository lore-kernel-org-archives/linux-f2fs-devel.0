Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C73606A321
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 04:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WIyGplGF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YZNcbneB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FCBJp0AU;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QoPrt67Z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=C1eCD/Q+Q0IorUG9zUXNRqO9Dfm4Iar05NffxXB9gYg=; b=WIyGplGFzNnyqvXcPJMMo31KVI
	gMZ4Jc8eto8JOkhb3Yscmj/rOL8LfIb97sd+GU6Ud7CinV0A6/ythO2Dpn7WmWBxeTcmxF0WWMcNC
	Nh6oBXMNH84KRfIybkOUKf1LpGHgOIJJBhl93wjuv+L9X2fU9MOyA28ANjqYep2X1Rlg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSo22-000000001H2-29gd;
	Mon, 16 Nov 2026 04:09:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xSo20-000000001Gk-0u7e
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L3WVF7wLC1qtA/cSTgOZWvmgczBWmPyJaRon0cMtZBA=; b=YZNcbneB3FRUHKnDQudVv9QciJ
 OSENYEM0SQjB3FRKVlwGdExTfqQpFBw7i0WS0CYV6LkM7HJ1408DXFvi2RsA7eJWOFIGW4Vr1MBLN
 YTvfrpIvkVvX52PELG5CaeexCZN3YOB2uh9OjjLBhDhMKwUqSnx7SxWpYpLArCXZ0Yh0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L3WVF7wLC1qtA/cSTgOZWvmgczBWmPyJaRon0cMtZBA=; b=FCBJp0AUW6AZr+of+CDGB6nBiH
 le0RWM70ITrBbE8Zr8tQGJ1CdWatTSR/DV18YCBrZtWBPYB0FTIQJsgx/hlZdZlqQsglApWFWcVsH
 Q2CO29pxF+YJtxKZiAnIwWv/sqRSrulXJNEP/zFUFm61SQATM+AfvKOL5ZCdJkwSu6n8=;
Received: from mail-pj1-f50.google.com ([209.85.216.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSo1y-000000007cH-1j0W
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:24 +0000
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3ac91ac8924so1527610a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 20:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794802157; x=1795406957; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L3WVF7wLC1qtA/cSTgOZWvmgczBWmPyJaRon0cMtZBA=;
 b=QoPrt67ZJ3BPWL5n59+Ty+akkEvnSS24UGTWu988yaiI8YEHKIn0eABC5PHu1COnZ0
 xfactI0oj8/UJjoe3X/F+Y9709I1akwv8hcaTaD5ugpD2bRvsotRwfSaSEQqUOw62cim
 JpQCy79hK2Ic7b51Yz++TxAkDrHwlGPnLysScvWjExzfYDeKTD5dzPhlyEbS67k3Lqpg
 Pd4tkrnS1g7q00QpS3BTwKcHDskORVdhONgT1dKsZ2ykZ/YPzqo92/SKjLcDxkvOWJhI
 ZrwaJ0O1kxx8u3MItWOvR1UCI9BwYXdvBRDBDFOwKN9NqjmT9wXzQfmpL/3r/egUMyBa
 hByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794802157; x=1795406957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L3WVF7wLC1qtA/cSTgOZWvmgczBWmPyJaRon0cMtZBA=;
 b=D2gt8JcoWoyCsIuK20iwqjwaCfBm9YH0tW1HUAJhgIdlnF846g15DWK7PU60sVTlu5
 /2Sgx/YuVfQuZGdU9tG41D8cfRRZiRAxjtRUXtZym3qoFlnpVpBYGzeem/5HnqXGxBYH
 95irx8lGnkrzYz05fcs6ZxG0rudlYRDYNno/d5wDhnBg0RqIqCuamXSI28E+Vfb50XEE
 QnT3yHneHq9tt8FgUQWa/xkJZKWJbb7Wai67cNugYlp98U2DJOK09MEyRsn3Sy+slvka
 ESmQjbG+vOFltkPBW7kewzfZfOdeLrs8VBJRfvoo9meW+FQAT3j4AH7rB9rPZ1TwPIAf
 tkGQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGga1K/7/rpvV2rDoaTreh3K/u4qdcI3hrqM6T4ZgaVkxiRIFFQblnaYJe4Y0juoK97dYUObQ5YHllySIAx5Ht6@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/1UH5LkVK6sJQD53kIoGr+EnizvJvhgUkQLkizsZEDiuods+aL
 jJQx9Nd9/1x9/W+6mpqCPQ+B5vWwXHBH0VXonXi3mdHuHBKszYxKz5nf
X-Gm-Gg: AYBFou2mKH0R9gBNEzf722/YkqjA+LUFu0wW8GwSeWl+OpEINfc0CiEo/bLF8Q1Ynhe
 A08vv8EULCsPgJr8Ay7cwAAPuG7v1SLnjqd3APjGOiZU+j0tGDYRBEZsJ04ceQxhk13ym/YBxoK
 3foisItsDPPZ3UNEBcjFLPl7pywS6cNr/PBaETeRIs0VpzWz1sw7x7nwrSt5K7imn0aFg4nnjAz
 Kz/Hh1XFw+CMy2PFdy0H4Y4hL890NQtfNgGzV8Cph9fgHrWoYBAl14FHpcEm8uaO/OHi+yulLi1
 zWjvMMmTvE3GvEGUW00JUdf+I0lr0Lx/NS8d7NJ1q+xXnzucMzAhLWzdM/34NlLnRuhjWQYhbGv
 /n2v9yiRLbSpKeUQd8USG4fudcY9F7HZpfnqqWb8dbsDDxlejr4COd9RxjQCaa4a2/yAtzodPCq
 z4K4p4iRvPive434zObvSW8Zkr3D2jWKni3+/CbEwhnpYczeyA00pOuJBVMgx5AOQ5/YzZGZvOQ
 CjwLwb6waY6hgUMye6RavWOW7oaQrrZPM6aV3p0vTKa7Vf+aWSMeNXeVwgPjXpgZTBQL2D1jC8c
 F9yOt352Mq33Whn2WB/0TmGJuLMRom0ixo+fFkyusGI2Mw8mLKanWj31FgwjyaiohQa+nqI1y0x
 rAppnZet8Xd2meJ8SbnMmDVauxXMZwx+88St2bX14NNfUiQg=
X-Received: by 2002:a17:90b:394d:b0:3ad:47ce:3876 with SMTP id
 98e67ed59e1d1-3b1b0ca9dfemr8786684a91.61.1794802156682; 
 Sun, 15 Nov 2026 20:09:16 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3f09b92sm7191989a91.4.2026.11.15.20.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 20:09:15 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Sun, 15 Nov 2026 20:08:40 -0800
Message-ID: <20261116040851.2849696-10-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261116040851.2849696-1-daeho43@gmail.com>
References: <20261116040851.2849696-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xSo1y-000000007cH-1j0W
Subject: [f2fs-dev] [PATCH v2 09/20] f2fs: support subpage blocks in pinned
 files
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daeho Jeong <daehojeong@google.com>

Pinned files must not allocate blocks outside fallocate(). As write()
does, return -EIO from page_mkwrite when the folio range up to EOF is
not fully allocated, and remove the -EOPNOTSUPP checks.

page_mkwrite keeps failing a device aliasing file with -EIO, as it does
when the block size equals PAGE_SIZE. Its block addresses are only in
the extent cache, so f2fs_overwrite_io() does not catch it.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index bec7988ca54b..72c601d240d4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -142,7 +142,8 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	struct folio *folio = page_folio(vmf->page);
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	bool need_alloc = !f2fs_is_pinned_file(inode);
+	bool pinned = f2fs_is_pinned_file(inode);
+	bool need_alloc = !pinned;
 	pgoff_t pidx = folio->index + folio_page_idx(folio, vmf->page);
 	loff_t pos = (loff_t)pidx << PAGE_SHIFT;
 	pgoff_t bidx = F2FS_BYTES_TO_BLK(sbi, pos);
@@ -245,6 +246,19 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	nr = DIV_ROUND_UP(dirty_len, PAGE_SIZE);
 
 	if (f2fs_has_subpage_blocks(sbi)) {
+		/*
+		 * A device aliasing file has its block addresses only in the
+		 * extent cache, where f2fs_overwrite_io() finds them. Fail it
+		 * as f2fs_get_block_mkwrite() does.
+		 */
+		if (pinned &&
+		    (IS_DEVICE_ALIASING(inode) ||
+		     !f2fs_overwrite_io(inode, folio_pos(folio), dirty_len))) {
+			folio_unlock(folio);
+			err = -EIO;
+			goto out_sem;
+		}
+
 		/*
 		 * A writable PTE covers the whole base folio.  Like ext4's
 		 * block_page_mkwrite(), prepare every filesystem block through EOF
@@ -2285,8 +2299,7 @@ static long f2fs_fallocate(struct file *file, int mode,
 
 	if (f2fs_has_subpage_blocks(F2FS_I_SB(inode))) {
 		if ((mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE)) ||
-		    f2fs_is_pinned_file(inode) || f2fs_is_atomic_file(inode) ||
-		    f2fs_compressed_file(inode)) {
+		    f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
 			ret = -EOPNOTSUPP;
 			goto out;
 		}
@@ -3828,9 +3841,6 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 	__u32 pin;
 	int ret = 0;
 
-	if (f2fs_has_subpage_blocks(sbi))
-		return -EOPNOTSUPP;
-
 	if (get_user(pin, (__u32 __user *)arg))
 		return -EFAULT;
 
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
