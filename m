Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209ECCA9EBB
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 10 Oct 2026 02:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yzjCDd3dm3aiqDDNaCyKo0o7NnGpJ3thd3yzkCukgN8=; b=kBXmVn8QMO0lwTrRHMYkAxRY8L
	gywhMeGknImttWDslB02Ur4DOhCNyP6B4fnZqFLGSlfUpmkNkIuG5+B8T9JuLTp20ApM0x8pH7I/j
	mOHxY9T7Corp+GbQkVK9sxXUl5/saP06xrAe52VL+ltkOLGEK3qF+M5moI96NsrlAkNg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFN1y-0006Ft-Ps;
	Sat, 10 Oct 2026 02:41:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1xFN1x-0006Fk-JD
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 10 Oct 2026 02:41:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Wq+5ysuHPmHAmM+EKqXmZYLCFhM627kiHhJZlYnVB4Y=; b=F/ZzUNQJJP7sUdopZsHhYhkmJZ
 pPP8R8h37ngSnTAgywXp+0tpeW1wzqreh3rqTUOxrWFieHpFvnXTjZFU91hcVvkYKh7/rX3JzadSH
 tX7fPvTx9HKmjKNFc1pCX9e+TKOYgEjGZn5cnOTd7N6UCRO8zPTba8CjVDrGOYfunP2E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Wq+5ysuHPmHAmM+EKqXmZYLCFhM627kiHhJZlYnVB4Y=; b=c
 KqUjXr6F51lN+jQ1S6OQrrKlo5ycZBUlWyg4QuasoPg3Ioi1mW/g/PTU9pqSsTxPbLnVjFA2WfB5P
 QsVj2MNLoY3e8/6y7B3DgGcfsq+n73JD9z864Q+41PMxZj8iQXzivhPzVBNH7QLAl5vi6HrVdjPUD
 oqAcgBzJhbKuDS/o=;
Received: from mail-pj1-f48.google.com ([209.85.216.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xFN1x-0006eb-30 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 10 Oct 2026 02:41:49 +0000
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-3ab27c7e68aso114264a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 09 Oct 2026 19:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791600103; x=1792204903; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wq+5ysuHPmHAmM+EKqXmZYLCFhM627kiHhJZlYnVB4Y=;
 b=mko67bj/aKeuCEYPn2R9INNuG/DhZ68pNrT/QYOr2Ru3Rks4srJP4kNtYhEi9TzEZX
 suES4unHpxVzoUtHqWHhP63julS6oWRV6XcqfBb7CuKWlzn3x4RXoYcpcfRK1ndugZXe
 Wvfl/+mQ1TRx8klbXCeZIz/4C7XrxXE7vxR2J+Gmt+oigrLI6zXTq1lNsxFklUnMWY9T
 vgTLH/o2x2UBB2dSK0r4YaTFx0/1yF1v5Cz0tlBsmvT+eS2h4jDxACICvN9e3WSikThr
 qtQvdXf38UIJ4157kNSSJDlCn9IuqZ9ov9+Ej/E5mlNKoqeOS4i3fAiDyxLt92lsWr9d
 WZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791600103; x=1792204903;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wq+5ysuHPmHAmM+EKqXmZYLCFhM627kiHhJZlYnVB4Y=;
 b=FG4IY6gfqbqClzFPBMCgDAZPY0NerrV+LG/xCPxGFJULYYyBCIGHWlal610a1cBDL/
 0jWAWqCrjhQsX0yyGpVl9qYKIWw9neuFmp8gwfy2QjRGcMyl0IRlSsYa6UQhWDDX35pV
 MAFlOR8DTEAQcexty9KP6UGiUltM2lCB8/wggrTKxRVRxp/LV16pEgcZkIHiqYHzMXhH
 yQ8ARuYsSLpXLbVzBKyg7AGrPnf+yQzWJblf+5VS+bOQkRGSxWcx0scvhp3hzHY7qQj2
 xHMUcQ17hJv9mOYAprVuvQU7iSkGblZRSKAauIrBKNoXBf9zTzNH42SoONRnjA80rYd0
 cwZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBymerTMcAjcCz4YccUWy/beHW7yYfpLlI3O082uTG7iI07IY3qR4/ZAYQEixris8Aybo90cf2kEmhH5uHMvvZV3@lists.sourceforge.net
X-Gm-Message-State: AFq9FYICbjSksSNqzNyEVF2HJzTeVRleWl9RMDcLc8euTy+3UlHEvKyS
 JW17zN/pGn7j/cdX/au0MHwes6c824E1rfJoEggU3RS4TfS956avOr3I
X-Gm-Gg: AYBFou3j+2gnkp8dTfbObLvcfqmRGRZ95TWJQ7pOOiAtawu3MfbDhbeSsg5b3oKZ6Au
 Ti7p/CFy03grpxwTKPTCblQed/hGR4d1OlJQhcA8rKfa3qOj8Nw8DNE3tkfkPYRV9+Xz12mG3OW
 aDyL5JAonza2FHQR+Wg9yQjGpOJz1DNLYpjs+j5CYcINWqbQBeI769abxZpdgQQQn6OYTAwTkE4
 c5XgCzlKyaEwn3ktYJucrfjsBZkvGIoRNUud3hlIlMglAlsUdc7Kh52X2XkChuJQ34uc9KuKDFv
 yEh6U8BH5iu2P5LB/wEvEDtqJbMqS59KQZJs1EyOGlJ1/srz/teGgmRDwbX3GrpcL6Ob+pjblrp
 2m+jTQkBAeEREtSYOdG08tsD7ToYjWNuRFbXA1z5DJULAd08DKYmrnXYLRqFuv2qv9jIDrFqL/g
 GK18OqSN5FqveeE/HSn9fzk1L0+O3DmbYQfUVzPwV55mElalvls8pU+89HRMwYsuAUXzD9K/SL1
 LxLXT1e+JI1Zdo8uw4xygQ4dLyMEONcpwhy9eR6BtMlZZXeSI97swrtCtZ6bASAk/8vK8x1PvI4
 xPDCwpD6eBHLCBo=
X-Received: by 2002:a17:90b:4d88:b0:3a0:c85a:ee02 with SMTP id
 98e67ed59e1d1-3ab3ac57201mr3454410a91.17.1791600103250; 
 Fri, 09 Oct 2026 19:41:43 -0700 (PDT)
Received: from f2fs-test.c.googlers.com.com
 (225.134.16.34.bc.googleusercontent.com. [34.16.134.225])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab36fdc75esm6296183a91.12.2026.10.09.19.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 19:41:42 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Sat, 10 Oct 2026 02:41:33 +0000
Message-ID: <20261010024133.2444761-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
MIME-Version: 1.0
X-Headers-End: 1xFN1x-0006eb-30
Subject: [f2fs-dev] [PATCH v2] f2fs: disallow mmap write and data-modifying
 fallocate on atomic files
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
Cc: Daeho Jeong <daehojeong@google.com>, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

Stores through a shared writable mapping and fallocate with
FALLOC_FL_PUNCH_HOLE, FALLOC_FL_ZERO_RANGE, FALLOC_FL_COLLAPSE_RANGE or
FALLOC_FL_INSERT_RANGE do not go through ->write_begin, so they bypass
the COW inode and modify the original inode directly. Reject them while
the file is in atomic write mode, as fallocate already does for pinned
and compressed files. A write fault gets SIGBUS and fallocate gets
-EOPNOTSUPP.

fallocate without these flags only preallocates blocks and stays
allowed.

f2fs_vm_page_mkwrite() cannot take inode_lock, so check the flag under
invalidate_lock, and hold invalidate_lock in
f2fs_ioc_start_atomic_write() from the flush until the flag is set.
Otherwise a fault could check the flag, then start_atomic_write could
flush and set the flag, and the fault would dirty the folio afterwards.

Cc: stable@kernel.org
Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2: serialize atomic flag check in f2fs_vm_page_mkwrite().
---
 fs/f2fs/file.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ef4d218e694..7020b3e8940 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -187,6 +187,17 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	file_update_time(vmf->vma->vm_file);
 	filemap_invalidate_lock_shared(inode->i_mapping);
 
+	/*
+	 * mmap stores bypass the COW inode and would break atomicity. Check
+	 * under invalidate_lock: f2fs_ioc_start_atomic_write() holds it while
+	 * flushing dirty folios and setting FI_ATOMIC_FILE, so either it sees
+	 * our dirty folio and writes it back, or we see the flag.
+	 */
+	if (unlikely(f2fs_is_atomic_file(inode))) {
+		err = -EOPNOTSUPP;
+		goto out_sem;
+	}
+
 	folio_lock(folio);
 	if (unlikely(folio->mapping != inode->i_mapping ||
 			folio_pos(folio) > i_size_read(inode) ||
@@ -2113,9 +2124,11 @@ static long f2fs_fallocate(struct file *file, int mode,
 
 	/*
 	 * Pinned file should not support partial truncation since the block
-	 * can be used by applications.
+	 * can be used by applications. Atomic files should not either, since
+	 * these modify the original inode directly and break atomicity.
 	 */
-	if ((f2fs_compressed_file(inode) || f2fs_is_pinned_file(inode)) &&
+	if ((f2fs_compressed_file(inode) || f2fs_is_pinned_file(inode) ||
+	     f2fs_is_atomic_file(inode)) &&
 		(mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
 			FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE))) {
 		ret = -EOPNOTSUPP;
@@ -2403,6 +2416,8 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 
 	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
 	f2fs_down_write(&fi->i_gc_rwsem[READ]);
+	/* serialize with f2fs_vm_page_mkwrite(), see the comment there */
+	filemap_invalidate_lock(inode->i_mapping);
 
 	/*
 	 * Should wait end_io to count F2FS_WB_CP_DATA correctly by
@@ -2458,6 +2473,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	f2fs_i_size_write(fi->cow_inode, isize);
 
 out_unlock:
+	filemap_invalidate_unlock(inode->i_mapping);
 	f2fs_up_write(&fi->i_gc_rwsem[READ]);
 	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 	if (ret)
-- 
2.56.0.385.gd3acb90ef8-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
