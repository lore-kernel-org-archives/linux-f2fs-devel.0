Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F93606A332
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KTIsKCwY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IV/mHXj6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=I/sPeUsP;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cFkKoKec
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=7WLo2VlP2cPEPE6g9YAACX5rSIK/H2lhMUsxI1P4S3M=; b=KTIsKCwYSlrVkIAZqd0fGjxbUb
	x4pt4ca1Vu3b0P7NtbTAIETQdg7KEGy2dD+72rQUwD6FxZ6NIdvejjdD8DJgllmb9XHeBMm1NtVPg
	jUYhwjBSUglMXxNnQAPzArWPL64yVAau0cVxcTPeHNTNFs6KZa0t9X4PdhZICY4mORiM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xWAMj-000000004f1-0Rhf;
	Wed, 25 Nov 2026 10:36:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <fourier.thomas@gmail.com>) id 1xWAMG-000000004cr-0NJ5
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 10:36:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L63JJ2Ypd0n14icsjMGD3F1OXiYfHiYHbWPvy6KkKKU=; b=IV/mHXj6l6tJbiFeIdJyAytoCO
 xBlIiYiWTnYXhlBcF83NV51AE28CfBlzIoYZtK7/0Ee4CDN077tD1IULEdvIpaRhV+zstRr8Z7HC6
 uG8ygonxWNi/PPqYcY3nWi82Ovmb31fFbfoUMzZqY0mEwss4gww/kSUEt5NDFkBcyGMs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L63JJ2Ypd0n14icsjMGD3F1OXiYfHiYHbWPvy6KkKKU=; b=I/sPeUsPwTTplFmdYQ5JKFWhHI
 Bglbjv/Uy91ohu3qAxRIMoVrBR/sf2N1lolN3j7uRv/d3fEM7D8Hrx+yY12oAaoFV4XgraHate+zg
 Ta6LpBMdxA/M6WMQ8cxobQUMsoP0gTBHb/Ej6qFfU8QraZ4kUkOCSt36IH2qTmFolN/o=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWAME-000000007Z0-2LXS
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 10:36:12 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4a8eed31158so465705f8f.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 02:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795602964; x=1796207764; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=L63JJ2Ypd0n14icsjMGD3F1OXiYfHiYHbWPvy6KkKKU=;
 b=cFkKoKecupbVD4v444xV9/drDmeRCQUvAh9292wO0RWS1M7kQ5MfmTp/gc29+TPXv+
 +4DN/YzHtIuC0V5ClxNqC6soSmiElvhqZXLBafaxNucSTEMgykV/KcKMq4r1EHobjD+y
 duRv7XYFpiE/AKejbMJJhXTjbIBWs3jN1oYLItTKXb7gJnySeVwDcazizlv448N8v0jQ
 k+K/zSPKtzCHEtam5T8qgZ6nVg+ZosmtUSt3sCEPgHYYVKHEVw+kiYiNXNTN5Oj62voL
 QqHUgJPwGPRmKfVI58RBQ0vyWcGitimXt3y5iygsbt5xXd4+IRpr9ARBt82++BFmDWwj
 zNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795602964; x=1796207764;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L63JJ2Ypd0n14icsjMGD3F1OXiYfHiYHbWPvy6KkKKU=;
 b=hFEYVHNsQFveeonRSJeeqCj9qnLt89QakTXsnhvQvHOG/ROS3YopT6mmsQAhft87PT
 ftwb85vCdW+ULwbUyuqB4zHcRCzeR+VUVmdDVGERPJHnv89UOdIz4nQ8abLMFXKumUT/
 8tv5lbwPL8uEBuEmgZvBQMQvzsgCyGC+CRhBCem+AuxVPmknlUwwd1gzyfMbZSKLAiHX
 MKkddy6HUcyLSHEM1+qI56kDvqccHUro+wve/caVYjBbhnT+ZDQayWZEBbKo4iAPeiXV
 ef7sRyC/3M4/Ww23c6Exhh4jOtCxONAUxw/ku7rIccJ2LMXPS+e9BpvItO0DuSQPks9Y
 uZVA==
X-Forwarded-Encrypted: i=1;
 AL+hErE//Jj55QxeJzY8ZGmY4ux7astRbUmjmzSLpxCvh54OduPgUSmzPNx2DvbfOJO43Ur8rQSp4loT7zrlkJFA9X0s@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+QF7B3MzbIBukBPuIHCug1vEzGwajpfF6rmfXTrBil9Joig2yg
 tQAKooqRF8EBQKtWd8XBrlCNqJSmo9AjYxtkT6jd54f6EubbnDWY3hzdUNwF0Q==
X-Gm-Gg: AZFdTZciDjnqyQvQQ60uTT8BCc8vzQmQcnirKiHZ++eb33tGOJJz+9RSqtWIUfcahpp
 DSouKbo92/uDfa5ax1begEVFoDmhBb2/R5WFRdnSBvFRSDKu7zgQAnoapmvE6VsLpU8GslsiymY
 xv0vJZeJZnCnODQ+lICOn5O+knUc8kZmzl2TIy/Il4c5Yt6mGeiR644GJSy7d1QGE34B/uLvzvU
 iQVdmagBxA5xXJt0qMiqV1x/FtqEXGzfVUSMTeIc7OTTNr9eJT91QLQELLt/7KhIWJZZG/U+N5/
 D6sJE6wWlNYXnsOQzYusdlhMPjs4z1hlzqb2LZKPaTYkzA/ebIvgbnNKW1y1RTOWpXZnxC0HhH/
 NJL6FbvTU2vVSQ/v9jT6dhiXVVxM9WCAKJqTPTk19yY+v3hDzLlxZl0rEUJ7qMOIWrQaLRQ3wIy
 HaSyWIwlro5crHYCZ8LBEXId8BuDmulb2xPGbLeXITvaf0nd5m/7wvUMBGOQoBq1X3qds09D4HQ
 uSugZQM3t6FWKmq1lDYsaZ/mqXbO2xyGP7fMjCMQs/9YK4IT0emGo8sUhlerqrDkrNZx28wCleI
 /zzqUo9j0hnT2sHcfpv5RmS3dAn3ct8gYlPxCn85CrJgmETOTsdcGJWLWv1hmW9oxvILWtUPIns
 0bX6E1cv6eABQqzPhpFk=
X-Received: by 2002:a5d:5888:0:b0:49d:2e96:4d55 with SMTP id
 ffacd0b85a97d-4abb46bc931mr31985965f8f.6.1795602963822; 
 Wed, 25 Nov 2026 02:36:03 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr
 (wifi-pro-83-006.paris.inria.fr. [128.93.83.6])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b2c9sm34661276f8f.31.2026.11.25.02.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 02:36:03 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Date: Wed, 25 Nov 2026 11:34:54 +0100
Message-ID: <20261125103502.30568-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWAME-000000007Z0-2LXS
Subject: [f2fs-dev] [PATCH] f2fs: fix use after iput() of inode in
 gc_data_segment()
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Thomas Fourier <fourier.thomas@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In phase 3 of gc_data_segment(), if f2fs_has_inline_data(inode) is true,
inode may be freed by iput() before the error message reads
inode->i_ino.

Report the error before dropping the reference.

Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Fixes: fc01008c92f4 ("f2fs: fix to do sanity check on F2FS_INLINE_DATA flag in inode during GC")
---
 fs/f2fs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 0a00180c21dc..c7dc65acd052 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1650,12 +1650,12 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			}
 
 			if (f2fs_has_inline_data(inode)) {
-				iput(inode);
 				set_sbi_flag(sbi, SBI_NEED_FSCK);
 				f2fs_err_ratelimited(sbi,
 					"inode %llu has both inline_data flag and "
 					"data block, nid=%u, ofs_in_node=%u",
 					inode->i_ino, dni.nid, ofs_in_node);
+				iput(inode);
 				continue;
 			}
 
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
