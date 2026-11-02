Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82A96083609
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Q9PxhS58;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=C9v9eNuD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lcWTUKuv;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PfGg7XNb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=JXQ2rDscXwVbkNdphpQV9YlN6Ktwnj+K3LbRAJV6oK4=; b=Q9PxhS58PHxVUbTgAOidroIjsN
	PvJXYvGwsT00oQXNpIIgQ2S3KfbK4Regv4SEdDMnNMmep8P39VzLlmgVs1XbPHyjgbXAdxXXWzmHi
	jzAqbmBruCF1uGO2Ni2PqkBzVZb83YEeM2FwekCUSBujOg97n2PlgEiIBJX/SYkt2Lco=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNxtW-0000000040D-2G2m;
	Mon, 02 Nov 2026 19:40:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xNxtW-000000003zz-0Axf
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rd8V4N1evy9DczvQBg1wfWJC9W1eLroMus6O4D6BjKk=; b=C9v9eNuDz0kc7tZv2anp48645L
 5PQIEKdBItiV5clzo4V+wL671iWpWs8OGlLd3XRMOItTKN1+/uYGvwIpwPISTB1jWUUqaMGBoD1Fx
 hjL8jjc2gxu9xMOXcxHshkXiDa16CgzfaCn1amtcniqkdIb1ZURUCBR16HYou0ztAzpk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rd8V4N1evy9DczvQBg1wfWJC9W1eLroMus6O4D6BjKk=; b=lcWTUKuvrGNM05ji89wFfROqq7
 04P84gut228mbxBP+qslrzubY9sugozQ8+IFKMk6VgK20KcMBWXlZJ/asWQNhbpjAGnHuZsgEf6Pa
 JR0Vljf9t0eOiiHnPB+GmPbdAfOsOySLSgnosJ5uxvObxVPE9Ej1XJpXnBKw7FLYG1fM=;
Received: from mail-pg1-f172.google.com ([209.85.215.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNxtU-000000002Dj-2AjN
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:37 +0000
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-ca766c1c9ccso1095203a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 11:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793648431; x=1794253231; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rd8V4N1evy9DczvQBg1wfWJC9W1eLroMus6O4D6BjKk=;
 b=PfGg7XNbLx+CmLi2ItgR3KJhedWgjl/U0qUgKx+SRYhg9uXNOFbuYBYQOP76KAQLrc
 Gh4YjHfAS+/6mFm2pR4kVmT8Dqar1rtqQttB2IXfD7RAgR6orobg6OI3czWQjC+ADA0L
 H2XKCJcUdQVchXoziljZVFd20B0McOYkQI9llD2K5XmwVcVXJS+XQItSSEl/JYYTo/0O
 CyfNiR2D0cIruqVWyLxBWxis7VbBwu7VfJODGmzBTBRugChD5q0wsX0ZKJFbJNJBSWXR
 2isTXEAUAgHnS2ro1kyDnBL+Njc8e2lUxw4lOwTPl9AsfVhRPfPIQSnCCqaso5kibkVU
 dNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793648431; x=1794253231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rd8V4N1evy9DczvQBg1wfWJC9W1eLroMus6O4D6BjKk=;
 b=oXzpEVfywhBu+gVJLszaEiM2mcrSQXmjgK0yQbno/SJWcajsxoIf7woQwpIAqmZIU1
 e4bkorH/tH88kcHOsdxWJuBh805DbrSKA45lj5SyUcDVj9QYlSr6MsN4yJxpsCAEx1Kd
 qYrk6R/6VJeaPMV9DlJeUIDw758WuyzwaGvMt8te4F1HJ/KsAPctWSXhcHCw2b5yOSCZ
 hUlCvEyNwwimCLSVrBNvE7ewjZXLgd2IGisiagNi48VQ9XLkh3QUzPB4fA3F2wpTVHRu
 16PDOnN/Dzbj6EbE5kyU/Vmkqt7pqkTO2+wjgsWz4sFo4U44J5WWnHA7BON5phQEEAir
 l1ng==
X-Forwarded-Encrypted: i=1;
 AKwUvBwHOrbPrEKQZYJ0WpDISZ1Y3IITULRrD3euAIZSKz6kS50NnlDOO1OdfFRhU7s7vSwNS+0E7R+4Xjj5TXsafvln@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJHPblwr5682M77heoYB5RcQPBpTTvo1dOHcDWFNx2g7lnn1d+2
 TfZQ+LXp/S53CYskM93/XSTKWyP+NeHc4b+qWLYroXLqtUq3C3ElZtc9
X-Gm-Gg: AYBFou1BUCC3mHqtSTUKOXCwf9P8WGOsTU2/EWdzWrmSAfMw6GsZCBtFFkdDA8wHw8k
 oWUTsxcz7iaxbh/tvrTQpOzwyNavMncmmFoEaUBvPcy/CX5DrJeiK6fePENlTHamhfwXtyj305V
 LoWTXxWLWGJHKZYKqBuzpJjc8MW/AtpVnrhz01MKDE8j1yaSOzfJaY6IjRR0KsahGKseLaJW1BD
 vU64xV+325IdmvyWdNExkrMefHfcp7v/C3L9g7lr0ax6uV9HqKNsSlzs3GHkUe9J3wafMbjBNE4
 84DSvYQQcDrxUv9rAoRtJ0XFpo2sV9oGRrTsycBmmIcu5pnnkaOrd76bDCj66w+5IK239JHQexr
 ozdSBh4CjnZT1JX28lwmMRF1DQA0ZQC0cHIgdd8BrjyPAcC1LApWyklRzbp18agIy9er/wnUuKl
 7J72Pnwv5uUbZomVsfR2/vbQ/sVqTjtk8ibDSoQt8NzTQaF1j/dYKMgvjB3iraZAS9VT+khuCLs
 JjEqnDYm7AZiYQXQStq8FVyLzG9LaZvtHcKaIQEzQppB56hA03+fMYZwIyqPWYlNJ/YnelKzR64
 QTfZRwWWT8xaCK5I+9/r/y5pg/6lDzu6ItpyHNo/CzsDpNTnRGawTqW2cdFT5UN1UMQANNUsPbJ
 MkoWkSPDPUsmr/V/KQG4OCc61fjinzjKy4C4cwIf9vnxBOQ==
X-Received: by 2002:a05:6300:618d:b0:3e2:8f64:e500 with SMTP id
 adf61e73a8af0-3e928e26560mr8796626637.62.1793648430787; 
 Mon, 02 Nov 2026 11:40:30 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb364c48d4sm241826a12.27.2026.11.02.11.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 11:40:29 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon,  2 Nov 2026 11:39:44 -0800
Message-ID: <20261102193952.3002018-13-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261102193952.3002018-1-daeho43@gmail.com>
References: <20261102193952.3002018-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xNxtU-000000002Dj-2AjN
Subject: [f2fs-dev] [PATCH 12/20] f2fs: support subpage blocks in
 defragmentation
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

Mark only the target block, not its whole page, dirty when redirtying
data for defragmentation, and read a multi-block folio once instead of
each block synchronously. Remove the -EOPNOTSUPP check. Reading the
folio once also applies to large folios when the block size equals
PAGE_SIZE.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0fad86267256..29cfc0e2719a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3312,6 +3312,20 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 						cnt < BLKS_PER_SEG(sbi)) {
 			struct folio *folio;
 
+			/*
+			 * Read the whole folio in one I/O; otherwise each block
+			 * of a multi-block folio is read synchronously below.
+			 */
+			if (f2fs_has_multiblock_folios(inode)) {
+				folio = read_mapping_folio(inode->i_mapping,
+					f2fs_lblk_to_folio_index(sbi, idx), filp);
+				if (IS_ERR(folio)) {
+					err = PTR_ERR(folio);
+					goto clear_out;
+				}
+				folio_put(folio);
+			}
+
 			folio = f2fs_get_lock_data_folio(inode, idx, true);
 			if (IS_ERR(folio)) {
 				err = PTR_ERR(folio);
@@ -3320,9 +3334,13 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 
 			f2fs_folio_wait_writeback(folio, true, true);
 
-			f2fs_ffs_mark_subrange_dirty(folio,
-				offset_in_folio(folio, (loff_t)idx << PAGE_SHIFT),
-				PAGE_SIZE);
+			if (f2fs_is_multiblock_folio(sbi, folio)) {
+				size_t off = f2fs_folio_byte_offset(sbi, folio, idx);
+
+				f2fs_ffs_mark_subrange_dirty(folio, off,
+							     F2FS_BLKSIZE(sbi));
+			}
+
 			folio_mark_dirty(folio);
 			folio_set_f2fs_gcing(folio);
 			f2fs_folio_put(folio, true);
@@ -3363,9 +3381,6 @@ static int f2fs_ioc_defragment(struct file *filp, unsigned long arg)
 	struct f2fs_defragment range;
 	int err;
 
-	if (f2fs_has_subpage_blocks(sbi))
-		return -EOPNOTSUPP;
-
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-- 
2.56.0.317.g454f8302e1-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
