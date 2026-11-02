Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F937606EEB9
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dSa6LRI6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=R77iYB6o;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UULb23xZ;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YJJ/V2Ln
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=HpSpFHiOjfIqbiQYi9xJegKWPJtR2Y5KTV5P7wqgQAM=; b=dSa6LRI6Aw5igzfOz37D0wzmky
	dIXEm4JY2uwNOeAabvVfzgYCMej8IND17ElevuSuw7xbZP7f9wdPSVr8n+xLuJGBdcWJ5+fIr3rHf
	hNEfvvnQ+7iFnJAgj+7Un8eDL7OFHJJYSsi2pVLHNuJjfQy+LreU9bU5mzg0QnzTtC2w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNxtQ-000000003Oc-0kSb;
	Mon, 02 Nov 2026 19:40:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xNxtO-000000003OK-1Xnt
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F0LkGc0IY+tztiqbz+e9wDBwhgON6uLBkjFz0/qxkac=; b=R77iYB6o0TOtDhjxAvvURfB/Z/
 PrhUMNBO7s2Usrdp95G3Fei2em/mII+riqSuvBxuG0NoQhT07HiEJMVJBrS8fGvbhSHzWOwmtmYoO
 FXaR4lLIPidCKA/RK5u/IhyciY6YazFHczduyDN7iRKrvUDbUk1mGr6/vjSso7btjvnI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F0LkGc0IY+tztiqbz+e9wDBwhgON6uLBkjFz0/qxkac=; b=UULb23xZyGR5zyfyiDcSHnYDfc
 sYSHt+19Xy3AjTlMaLaxNjU3evIpnGgrCk76Vs0mHm/PHuMRzFSmPrz3mqUPUUMW+kzJiVNBAzpHY
 yYC7I//sH9jOwDQzY6SbHnEJY9fW0XC+45Pi0Mp1vJmIX9bLIXjsXqZa2b4JiobZyMB8=;
Received: from mail-pg1-f174.google.com ([209.85.215.174])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNxtM-000000002DQ-33ra
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:30 +0000
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-ccca948203aso1272019a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 11:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793648423; x=1794253223; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F0LkGc0IY+tztiqbz+e9wDBwhgON6uLBkjFz0/qxkac=;
 b=YJJ/V2Ln2cWQXrv9CZaXQGVzWgSUR0rbrHL1XZ3kUgIMr2kEYhYJejqJd1dF7DKA6p
 ERYjnO5+evKmCapnAIem/mGF9APv5nJbPcCoeaJRj2N6Tpu/4/yg0Y7btPhfe5jNe0kK
 SZavRcPtlqxLtgCJSn/ylbd0hR+Iu/dGoyzCWJOrWogqBls9sfV5FabKmNlVmHn6dbpb
 NVbjKWckq4QB7CTsYUFV0V+Ic2RPgEZombrE0BVHKYAX0Ode1SWQmd4CQpWSW1xXCLUr
 PUkB2Q6Rs+oo14pbgU/MUP6I0agX0ykhgAr2x8Bw5Z8sIdXzAdPvVfYaFsUWZnzfrvWl
 sP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793648423; x=1794253223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F0LkGc0IY+tztiqbz+e9wDBwhgON6uLBkjFz0/qxkac=;
 b=Ygjc3VxkT9MPPg4s3vjBdgp74UFE1YunIZ6NrGfHOKgoBBCLJgU4DnCaP4DooGgf7z
 Ft4ZTYSnkOdWj33Rp5HoiCiDxQbw1V15USCPGmJiaSqwM/8JQW6UY9bPGLFpPPqDC8Fn
 rXgC7jSkJhrX7kga6mgFGYG7hEyfJaq/I+XqIkv/zBIb9GZE1zu/aFXSliW0QkwiWhTH
 /b+bRlhtL2qeH0nQv1zFuzUbsVyjUIe4J943EnSaffATpc5wAGwifpqlkv26NBosqVGY
 xgsmQSDLCitqnWKESpRy/s9/EbFsYU4athdpc0F6a/+yt6NMkE9Sgunov6cDOjApYW/U
 eAlg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFDvrAb9mH3c0VbiD1ARp1hBY0yA3viYggmV6cbX6vQbit/X42o78XOvbld+TMCSYfE/l4d8KnbETFbMp9bsJ6@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9LWTwtVFkewn3lTbVlyb2ZuGaUTmROm5BRmy/Nm+SqSv+520yC
 bhmuOibFceo8zhIU4IJ5Y3XrJUd2NXuio+CcXfJBr6LOqtAi3hOcrHJu
X-Gm-Gg: AYBFou1bhbIhcRjUVILfT5ZrxMg3SzQ9ihrzd22WK3FXH2F30/fOnKD/5MIZus3OYzv
 oAYCFZCR0PzDpxvaCtiY4+01Vr8bTUfAtGfa8QqAwB4T2zfmxvdsiDCURiI3TMh00/ZTaK50E2K
 8AM0oRZ0fRVzkde1e6kagtPSwWpaP4ypJuF+K7RHjT23DIng9BaCqL0Vkg4fTjQD4NvojblJLyq
 4RJXO+813IYSVJK4H5a0/sK29FkEE84zOzdOq/k5KWnrvyIUW6FfOBgygmAogbUZCiCDf6emFFR
 pWsI3+suWVtm/+c/60KbY7ylLDMLhSfc0gJiYDjUATMYWY9cXY2pp7EnQ4HkDs5X5twEKxVPXdo
 eMwTg7TDsFSYIk2bTXeWSoksgoId/GP+dFZf+9cnnIwI+vEgnoaW49eqDHYQnOhViGZ/K3crfaD
 39grN6D8aHyaLkhjp8Wqf5owPzPieli/EXCZALNx9g3cTBAwY2T+uxbSDXSofwnwtAAgRXtjLAo
 4ePJDJIZuJ9wlhXd0I9uwvdkcXv341JOG21B9S9HEZpQwtGfv0w26LK6OMTbGZ4LJl1VsM1XFR4
 5kkRjIv1uNM8e0dTTavDxuGWVrVBXxILXWRpoNLqEvCa/OjGhSel8aBdetM1dyxg7KM7faD05SP
 EZV3Iu/6ePeXAKsdfTADwiiTvD11e4P8/ybbPhPv8SZWNOw==
X-Received: by 2002:a17:90a:ec8d:b0:3ac:b7b9:6484 with SMTP id
 98e67ed59e1d1-3ae897ae130mr8244693a91.45.1793648422986; 
 Mon, 02 Nov 2026 11:40:22 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb364c48d4sm241826a12.27.2026.11.02.11.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 11:40:22 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon,  2 Nov 2026 11:39:41 -0800
Message-ID: <20261102193952.3002018-10-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261102193952.3002018-1-daeho43@gmail.com>
References: <20261102193952.3002018-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xNxtM-000000002DQ-33ra
Subject: [f2fs-dev] [PATCH 09/20] f2fs: support subpage blocks in pinned
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
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

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e68553cef777..36da0d558ef0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -240,6 +240,13 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	nr = DIV_ROUND_UP(dirty_len, PAGE_SIZE);
 
 	if (f2fs_has_subpage_blocks(sbi)) {
+		if (f2fs_is_pinned_file(inode) &&
+		    !f2fs_overwrite_io(inode, folio_pos(folio), dirty_len)) {
+			folio_unlock(folio);
+			err = -EIO;
+			goto out_sem;
+		}
+
 		/*
 		 * A writable PTE covers the whole base folio.  Like ext4's
 		 * block_page_mkwrite(), prepare every filesystem block through EOF
@@ -2280,8 +2287,7 @@ static long f2fs_fallocate(struct file *file, int mode,
 
 	if (f2fs_has_subpage_blocks(F2FS_I_SB(inode))) {
 		if ((mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE)) ||
-		    f2fs_is_pinned_file(inode) || f2fs_is_atomic_file(inode) ||
-		    f2fs_compressed_file(inode)) {
+		    f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
 			ret = -EOPNOTSUPP;
 			goto out;
 		}
@@ -3823,9 +3829,6 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 	__u32 pin;
 	int ret = 0;
 
-	if (f2fs_has_subpage_blocks(sbi))
-		return -EOPNOTSUPP;
-
 	if (get_user(pin, (__u32 __user *)arg))
 		return -EFAULT;
 
-- 
2.56.0.317.g454f8302e1-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
