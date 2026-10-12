Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77FBCA9ED0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Oct 2026 18:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mfk74nzrVZgkQ4pcz6ftzGJz0K2uQz2dEZIPuoB4h2k=; b=RtiSjVGg/7JVBIov17Zhq34rH4
	i1rzdXmP/wy2kJKrqYyIJgVUSlGzk6HX/DPwbG6QBvA1aON72V9kvnFvjaVdOmjnkZKWNTPMPXcyC
	w+F8cnjduXX3v/TUVZcPZCrq+UIT+Gz4fd+YBg3TrNRquwbkzY4mTVToRTBHL3wIDCvk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGKgE-0008G7-J0;
	Mon, 12 Oct 2026 18:23:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1xGKfl-0008FS-5R
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 18:22:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gbZDE8rwgwP6vxNIiACurdFD3ae7zMp/sZ7U8r6EHqw=; b=OK1whHXBl9u7Lqkwivj22NKPA6
 PExJC62wJC4oYK7J36CwYcnsQ9dF6PTLosI6VR5CPuPrcoYuMdvZynRYjosEZYN6UVL7ozYGF6hBH
 BEpknJYDTYULcSenMqQFDK/JE1zx9pPFKmb1VJTLfgBiT7XigeAULvbvdfdEj89fMI+U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gbZDE8rwgwP6vxNIiACurdFD3ae7zMp/sZ7U8r6EHqw=; b=E
 lpwKKFJHNXy4JngVDKflZUVsJPLgUW11PSnAwNnuVY+bgkFAN6XSa4Kz5QthnhYP9HoUoB6hn3dCk
 yBsLqt1zRif9l7kiTQyz7flrVeW8Hu3xvhVR8JN0dk1BtkjfVfn31Xy4eTfT+wRhiGl7o7mWa7Ajr
 27Hi239tOgv9uig8=;
Received: from mail-pg1-f178.google.com ([209.85.215.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGKfh-0004Ns-BW for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 18:22:50 +0000
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-cc4aa0246b7so901237a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Oct 2026 11:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791829364; x=1792434164; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gbZDE8rwgwP6vxNIiACurdFD3ae7zMp/sZ7U8r6EHqw=;
 b=sq8TV1SJ3WDQQggnwFfe2BYLsqOxI8MeVFS5fC99KqVHF4MKQzSU8xASAmU1gTuh3s
 0urueYbXUQXLWYJJonfdWk5WscbmV6nVpYcV6eAod/GnQ03aGve+2h532xh7cPQqI3Cu
 Fipms8EQAM3xsndfc9DlFCWGsf6WZQ6w4vOx7HlQKsoWDbffZLiqGAuYbZSlfMT4o2xC
 2OkMYyAJFcZhPNBNrMAg+VukENXuNcuDKqp/PPMJ/VIwaUhwkb6jH2UqggXuTHtQ0CQm
 KtH/ypWMc4kyAwcIrIE/2QsW0+o+LuqoJyaFv1XI193hecQhzhLSCco5jDOohCQc+rVh
 W5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791829364; x=1792434164;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gbZDE8rwgwP6vxNIiACurdFD3ae7zMp/sZ7U8r6EHqw=;
 b=kmuN9opzpbRRnk0JJ3Faw8m5pe5sb22W9xT8D02+7YK0BY6CnDr5fFnjMmLzbmUorW
 meXvTXqJwL6efyIN+f6t/MLNOx+qYXnU1qJ452LQwlLGYpewzjPKYWGkxFzvMne3oGdb
 mLA9ZQr3PEUWjMWRAp3AYuLGSqaWwhXg3Nm1U6YZKd+PEMxflRKG0RqJO+oIU3xA8yS/
 f67LiRhyiOq4ygKCpHj6EaTROU1K9w14Uqa0SAW9XW88cZoBVTqA7YWnfAY2qS3zpLVM
 AmBpDWeKrmcJqAkBuIErZGnzPI70Wbt1dYH/vAWfghNTr6Ybjr+44MYb0HMEs5d60vFK
 2lLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWSyb7B5vGPTOOInizTSBBbyNXHVX6Lfa3oBHKpaf/44GTpsdPC1t4Uqm92P3x6P8+DWTeEq0bS7M3CRnTKGb6@lists.sourceforge.net
X-Gm-Message-State: AFq9FYL/9/C/b9XTywTfVzQWCGVfYMcttVP+W7QPNHrr76lToOKsbUBT
 XFmqRufvyakKKYDDR+mYUM9g4GWQB6lrALF8Byw98VOnMOacnisPCOYb79Isbw==
X-Gm-Gg: AYBFou1RMxdRrx8pZ01zOmcWH2Hdsg0r14jjuZ3YprrSZFLx7XjbprmokO+xlcDaKyr
 nTePAhRfEvT82LlHWtRqi0dPtj7GySUDo2d8c9CHy98GBcbgwvoScKENq//JZ3KQGtl5fs5LT1k
 TM4CluGKS9/r25s0/Ouso3n7Cnzeeb+tsTYq05efaXU2shnUUBOoGMaCDvR2TtWOj/iWWiPtleF
 8DwXwcNadtr0/pB3stAQGnpkxgKx0fNPeIHxt4flAr/XigVBV6Cm3lv0F7iz9EWH7r+Y0EpBOAT
 Je3iZA/6u1Z1iNJyMV93Bx/cnFkUAIbfQ6Fj2etssru7eZIC3nUP0vNvjWFAT0t+LkNShuDZcRA
 drP4QvqrEf/3letia2Vd3xVuG9P/cntpzxICBpfxR9tVmSwqblxW0mOAQ2bL2wfJrQ5bq7Vr8Th
 IEKFjCoR63RQyfLLETNy+cUq1IT1EJIbGpkijLZkwfcsGQBKkR0Voox3AW5I87BXkQsmRKRtjHq
 wexzsvEtaK1GwJpFP6BxeJj3Hj6/l4tFg8SX6dM3LhNXsi0VZjumJ0C1HjTlbA326pbh49wi49e
 FJ2EKof5iyHo8N1kVp68ocSsNA==
X-Received: by 2002:a17:903:476f:b0:2e7:94fb:262 with SMTP id
 d9443c01a7336-2e842ce2a76mr76278985ad.43.1791829363505; 
 Mon, 12 Oct 2026 11:22:43 -0700 (PDT)
Received: from f2fs-test.c.googlers.com.com
 (225.134.16.34.bc.googleusercontent.com. [34.16.134.225])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e841a009a7sm46451645ad.11.2026.10.12.11.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 11:22:41 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon, 12 Oct 2026 18:22:33 +0000
Message-ID: <20261012182233.2685282-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
MIME-Version: 1.0
X-Headers-End: 1xGKfh-0004Ns-BW
Subject: [f2fs-dev] [PATCH] f2fs: return -EIO for a lost inode block after
 cp_error
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

After cp_error, dirty node caches are dropped without being written.
If such an inode was never written, its NAT entry is still NEW_ADDR,
and reading its inode block returns -ENOENT.

f2fs_get_dnode_of_data() passes that -ENOENT up, and callers take it
as a hole. Since the inode block is missing, the next offset can only
advance one block, so fiemap walks block by block up to maxbytes,
about 2^30 blocks, while holding the inode lock. It took hours in a
power-off recovery test after shutdown and blocked unlink and umount
on the file.

Return -EIO instead of -ENOENT when the inode block itself is missing
after cp_error or shutdown. A missing direct or indirect node is still
reported as -ENOENT.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/node.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index be14dfa31e5..55008f18afd 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -832,8 +832,20 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 
 	if (!dn->inode_entry) {
 		nentry[0] = f2fs_get_inode_cache(sbi, nids[0]);
-		if (IS_ERR(nentry[0]))
-			return PTR_ERR(nentry[0]);
+		if (IS_ERR(nentry[0])) {
+			err = PTR_ERR(nentry[0]);
+			/*
+			 * cp_error drops dirty node caches, so the inode block
+			 * of an inode that was never written reads as NEW_ADDR
+			 * and returns -ENOENT. It is not a hole; the inode is
+			 * gone. Callers treat -ENOENT as a hole and keep
+			 * looking block by block (e.g. fiemap up to maxbytes).
+			 */
+			if (err == -ENOENT && (f2fs_cp_error(sbi) ||
+					is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN)))
+				err = -EIO;
+			return err;
+		}
 	} else {
 		nentry[0] = dn->inode_entry;
 	}
-- 
2.56.0.385.gd3acb90ef8-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
