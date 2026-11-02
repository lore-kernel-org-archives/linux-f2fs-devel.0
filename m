Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEFE606A324
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 00:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HLKHfthO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IcmLElSQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Bd+UwDIa;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zqFEDqPQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=UL4urStJxXOCkuoS4xD726fyP+HRSyas2wMdwqouH+k=; b=HLKHfthOpNEwPi67pOPGI8SeKf
	pmcV+7wrlcWHbgoMed6g9jGQ1hg9mIx23z6FZOMPmGlDnkfI+3qFeEMxCtOMF6G6Oh7tLt8di6c99
	dUZta9gSoISPvAief+GLpIGI2w91reCZbh7XE0704z35yU1aDjEqyH/k65rjDubBUSJc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNgEK-000000007ql-2zR1;
	Mon, 02 Nov 2026 00:48:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dennylin0707@gmail.com>) id 1xNgEJ-000000007qe-3iEd
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 00:48:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9fErfkULxtwTRPKMq6WDcnHnyNfqKUVzTDigvp7MrnI=; b=IcmLElSQqV+MApZ+fvk4gRUvMc
 /ngCw7LJrB1GcJkv8DO76x7p3hB+mIZ1ZH5hbl674JKxavPrU6xxZQHN7t8zxN8yW4/+8Dg4T7ZiS
 ODPDJZM8xRZCNGsEpuv5utCu0z+5qLdk6wz8I4EM9vJGOn/84BAznxt5fhV6P+Hu7Gfc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9fErfkULxtwTRPKMq6WDcnHnyNfqKUVzTDigvp7MrnI=; b=Bd+UwDIaPGzCSAf6zD5sgwtR53
 OYcjctZLEg2XkIbjOAy5LImUKQmErcrnpLCIXM9gHt61pEZflobpQCiSlqZxzngjRazsP+7gwPUSv
 klgCm1Pfq5g5WpLJzgIuHpgZEdPuLv4yLh9rvTa/KPzBm4HeGavNbdA4ooxK8Bcc28vo=;
Received: from mail-dy2-f5.google.com ([74.125.229.5])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNgEJ-000000007B6-15rf
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 00:48:55 +0000
Received: by mail-dy2-f5.google.com with SMTP id
 5a478bee46e88-3535a54c09bso2540932eec.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 01 Nov 2026 16:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793580530; x=1794185330; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9fErfkULxtwTRPKMq6WDcnHnyNfqKUVzTDigvp7MrnI=;
 b=zqFEDqPQcEVuiLFwbAvOFYlfwv0nWNouGft684gqXnLoSlgmy6FY53N//Z8qkaTuxf
 f7p+VZ/7wYVHnp7VgUE61V0caeMZL9JoWv5yfof5rQ60fDgN3EHqM1SB6LXdMRMhlZFT
 sdivpYlOjyywR6+Ga9/ni/SO4ChMMVbEbToUXBcudXLwErBOI5qVSxOQXIVEStS/fs1p
 83yJjdde6Yzpr+1/IjqAXEsf/Y4v2lRGvX4x3hAJe6S/ihk8L7RkycoSU2KE08I/nlZH
 X9nJOjvg5fspKU834sP9UU0apTPar45FGcekWbnLzIL7P7Myk1LMuX1VMnl4llsFeQTC
 ZU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793580530; x=1794185330;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9fErfkULxtwTRPKMq6WDcnHnyNfqKUVzTDigvp7MrnI=;
 b=vU+HnTT7SpuexskaHojgEbsQaI22T4b2j1yy09U/BfiHWbewgBwEGccspoLK/pKIRz
 JTYg4pXtBV6yAPhkL/c1yk8hlhN2+GI+3y0dd1oJ5y15r7eJhdEq2XIe3mh8lKu7c6Rt
 XK4ILXY6ZXLRhqgDP8xISveT2maerf2I/GCfpjFzvreBozbzuM+mb73y0tVAYTLdN2xL
 mwVatl4nDVTqmObRqfVjd4jGG+1jFV8TdHkuAR1AMiSbbBbIkFIPyJpb9pbuaonW4/az
 nxnpmw3yAs33fTuT3kDhgUZpafpbpn5F1XowcV7om+I1goNUSl3xEnE9IMHoPK3mnQdf
 DiLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByXPnWvXaiJw6yY3znaF9YZ/UR7Np5u8v8Hrrcu8eKE0TbcbBQh7wF1zGYncXkozz69NWUjECs4hRnSax3h9eWI@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKfSm6kcvc+PQPoiUD1/WmLk/HnFotZg6qaUE8KexS2PuYMnmAE
 nxJr/Cx9BRCwf71cJxYHtaUAiYG3+xWDPzoYOngRQSA9rhBES/0i2eZ6
X-Gm-Gg: AYBFou0x5OReGFYeM8KcaeqKkVpcejMPwLhWM/cQMFHZaXi31V5cVCTtiu3w7I6Rl1l
 B7qdx5Br6UAWG77bIy4zfeOEj9SfNZRB2nTEo02reFcLHmAI/KsqnItcDT6umOityyGDhfRqNOK
 eMpJSG/xXewVmUtem6wjGRC2z+k4E3LBGkxV+8hwKKxN9WRdJMmimC4O5GOaelcvzxmMO1IhhxN
 GVBywSUPuvQ6KX/5Rvhg+yDcWpZe8B8X2W8d8jk2qgywseXNpIoKWjhcraprWPU/XCT5Z4AddSm
 ut9PhUAlb4+FKe1vFPWwdJCqk7+qN58SFMEdF7CoY4C+1j7XoVT0JSLDXoBAKlYo0lJIgZvd8rh
 0kTkFwDu81VTi7CxdVKkyE819LHPRnib5zP13nXDsqa1ldL8NSdjDXNOumQF65xMsOPDgbiRyNm
 p5jKHBSjfP75OeJHb0ZaJvq1JsjkakxUmDo9odvTEaJv9by4KpmU1EnNAd/Twddrh2Bg8+ND04g
 HgZGMfXsvrLcV5hNvhjV7httkFMelNOtOnlj4pQmcGZgBX7VhpW4WM2U7SOQsP/wvLoIqFK+i+8
 ljZ6lLUnl1/yd2WuZPMwCtj93Vtz6Rb7eJV3UYIQxqgqrB7+H+keFzww
X-Received: by 2002:a05:701b:4505:20b0:154:fa0b:6df1 with SMTP id
 a92af1059eb24-1ac5d69f9c1mr11829668c88.37.1793580529505; 
 Sun, 01 Nov 2026 16:48:49 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42662f23sm36188295eec.2.2026.11.01.16.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 16:48:48 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon,  2 Nov 2026 00:47:41 +0000
Message-ID: <20261102004742.55105-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xNgEJ-000000007B6-15rf
Subject: [f2fs-dev] [PATCH] f2fs: update inode ctime on exchange rename
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Hungyu Lin <dennylin0707@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When two regular files are exchanged with renameat2(RENAME_EXCHANGE),
their ctimes remain unchanged. f2fs_cross_rename() applies its explicit
ctime updates and dirty marking to old_dir and new_dir, which have
already been updated by f2fs_set_link().

Update old_inode and new_inode instead, matching the ordinary rename
path. Keep the existing parent link-count handling, which dirties the
parents through f2fs_i_links_write().

Fixes: 32f9bc25cbda ("f2fs: support ->rename2()")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/f2fs/namei.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index ce5d536d892b..880dfd44c04a 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1287,13 +1287,13 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_pino_write(old_inode, new_dir->i_ino);
 	f2fs_up_write(&F2FS_I(old_inode)->i_sem);
 
-	inode_set_ctime_current(old_dir);
+	inode_set_ctime_current(old_inode);
 	if (old_nlink) {
 		f2fs_down_write(&F2FS_I(old_dir)->i_sem);
 		f2fs_i_links_write(old_dir, old_nlink > 0);
 		f2fs_up_write(&F2FS_I(old_dir)->i_sem);
 	}
-	f2fs_mark_inode_dirty_sync(old_dir, true);
+	f2fs_mark_inode_dirty_sync(old_inode, true);
 
 	/* update directory entry info of new dir inode */
 	f2fs_set_link(new_dir, new_entry, new_block, old_inode);
@@ -1306,13 +1306,13 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_pino_write(new_inode, old_dir->i_ino);
 	f2fs_up_write(&F2FS_I(new_inode)->i_sem);
 
-	inode_set_ctime_current(new_dir);
+	inode_set_ctime_current(new_inode);
 	if (new_nlink) {
 		f2fs_down_write(&F2FS_I(new_dir)->i_sem);
 		f2fs_i_links_write(new_dir, new_nlink > 0);
 		f2fs_up_write(&F2FS_I(new_dir)->i_sem);
 	}
-	f2fs_mark_inode_dirty_sync(new_dir, true);
+	f2fs_mark_inode_dirty_sync(new_inode, true);
 
 	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT) {
 		f2fs_add_ino_entry(sbi, old_dir->i_ino, TRANS_DIR_INO);
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
