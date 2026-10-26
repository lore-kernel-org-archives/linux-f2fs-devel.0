Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C901606A332
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JD7l1EWk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mYz0Ttrn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=itLZjiir;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KboRcv8r
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=CRhlWNqez1Mx079COq6u04u/IoUlSS4+nWAMpbLptXE=; b=JD7l1EWkLucARgjsjPcaj81yOm
	npg7khJqjAuftv5PGPU0/ewnzHWNNRiqTjJevf6xeKTllEYXADpCRxVaJTcdnl6AhG5mtfiRlY7Qd
	E+OyJDYTZYPxQv3GZrfGOwGGFslGr6uPdcUXb/CTOAo18SY37xSpm2TYBw9lNcJpMxN4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLIIC-000000006w8-0zwc;
	Mon, 26 Oct 2026 10:51:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <teel4res@gmail.com>) id 1xLIIA-000000006vr-25pe
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 10:51:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zpoGBsTQ1MMQtEr8iRtFOb/elu0nHODI5EyL2pzDfwY=; b=mYz0TtrnPd3Wpk7F0Ruf1gzzqw
 wqR3qAJPJUVN0NoAK/Z4N3TigdWULnQe9iiC3AQgtoSe3lVkX2kTrhKXMAblxdk+HFAqVZ2IZFJ3/
 ME8EIEjdr8JLcWsiGynq5AYuu3hhECSh4sCDOhw+a4dA2eiRPV9KjNM1t3GE4NWCYEi4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zpoGBsTQ1MMQtEr8iRtFOb/elu0nHODI5EyL2pzDfwY=; b=itLZjiirL2uopFYZFkwc4Sngbq
 718IuyS9HU5wO0DM4eJrAcUu23/Mc2R/SSlLzwNNKBffV0D0/oeejm9eQFo/4m4fY/wpPPyILv8Q+
 NI/mEtHwun/rWXxpDTi5W7Ta1EInF7MayyWDPczCbXeizsFsdaSP8aPXphAy7xEQQ57w=;
Received: from mail-dl1-f42.google.com ([74.125.82.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLII8-000000006Da-35m4
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 10:51:02 +0000
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-14394530ec6so3440589c88.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 03:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793011855; x=1793616655; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zpoGBsTQ1MMQtEr8iRtFOb/elu0nHODI5EyL2pzDfwY=;
 b=KboRcv8rmQopvDgF7tw3N+XRJoenhjoy/G9lllaCGhyv9eHco3s3yTzEvGuOZHJl1J
 S8uD04xof5VmoVwQGLVkD5OtvhrDCqUrv1bE4m5C8RNNuF1kCsJ35oYXOLB+gKRImgvh
 oPAY3o1agPImAeHyUrZDZjf0COBMSaU0JwSSsoTnf/m1FK30ylFY7oOKj9Py7Xn6vAG8
 zFmVeHA5GY3/GifV2CRQfqYvMx3jNn4xe+NZTUqnpUDkQG86RfY73JeGA1bRgT3oZwhS
 Nu/sh+2M4vkIDGiUR/PP3LUXO1lIkjb1s8iLplhrdxF9RidOWGD3Acbw/3tnPuif6irN
 kq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793011855; x=1793616655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zpoGBsTQ1MMQtEr8iRtFOb/elu0nHODI5EyL2pzDfwY=;
 b=OONdhAqg24MrxLcnn0nUKn/z7P3ogynK/g4e0SefqlcJXGTiRnmsMD6Uj5Eo3LFe3P
 D9E3MX6pPAqzxF/embnjm7gz5B3tc4kUOQ8xqPRlX1SAmMDeRIbXnxsbtdsW1BdDh4Je
 tywdeEfnFParrKSKj+1gn8hrr/AtX8QgkAIK+MXaXnXE3NSeXrK7/9YX0/GWYt+G8vUk
 PpGep5tvqNNNV0gg3Gel0CGxI31OpRRdETIJUcpd4YdKZ98+Us89LjLbaA8COgHcWp2O
 SKtgylw5oApoiDUH2VrfIlgQsMDeu2uOUIa/LpYU7LneNMWcd04pTRDKO7FvDWS+sCbG
 QW7g==
X-Gm-Message-State: AFq9FYI+UHr67TpPu6GtcOmSJPrZz5TBHJOXy7yTd/CnoYSD1MBO5T2u
 Q1vbQOHKL+GO8FByIi/qQhhM6U2nE596TAV56ZCJo1bMekOViPDAdYVV
X-Gm-Gg: AYBFou0nE3hi6rrrQ1EXSWWbu6hCDZHBUhRrBl6HJSf0eyUD5Py2xEVQi6AsOtwmyUG
 bLOnum41VfGX4ke4u8W7tLP63W3WZJ/vdMeResTxhWEyDL2mWdy9/e2ok3NFdMKGnQhTmwI4mca
 a16P3rp/KCZseGSBszaGlnDi8pJytVZgCoN7P14cxePA4F3gQXnDSyFqQZthFeRGjJGl6PEH/oY
 epvnx0IHqbsEQ5HHFyfqpP47u3rcoOmvY3MlJfnxoG42EFpFXdzjfDBvZI5v8ttIS9D+W318Bbg
 CSezkHh3kwjj7n86wr8JCyNIwzOs8NRcDI/Dmyx3UWH79bkcpEY0yCJcVgcKWcWFdYGYPYEyjAN
 irvdxkWh4sEjU2qfxfyr94QnQXxz2sL8fvxgW42bo38bmdq8EAvGGKdIy6+89FTJTFRWb13J8G+
 TKTTe18tOF9aQnacY/vbKbhB/rZndmxbngm5TKGwDcFt/3dcIR8t9Kn4UbAULwTrqO4snL5Oc9Z
 U0c1YgHDOaqC8zD0/WdtRXVTW9/PQDIRRUSBilNrEj04XyJ7kdyo7HklnuejAKqHKYAlkJmKY+D
 NJDZYhmDdGwuGRAeqpM=
X-Received: by 2002:a05:701b:4586:10b0:196:4eeb:76e8 with SMTP id
 a92af1059eb24-1993562594bmr9140816c88.20.1793011854790; 
 Mon, 26 Oct 2026 03:50:54 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com.
 [67.216.200.102]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a020df20sm27897863c88.6.2026.10.26.03.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 03:50:54 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 26 Oct 2026 03:50:39 -0700
Message-Id: <20261026105042.1148554-2-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261026105042.1148554-1-teel4res@gmail.com>
References: <20261026105042.1148554-1-teel4res@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLII8-000000006Da-35m4
Subject: [f2fs-dev] [PATCH v3 1/3] f2fs: reject non-directory parent inode
 during dentry recovery
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
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

recover_dentry() takes i_pino from the on-disk inode and uses the
resulting inode as the directory for __f2fs_find_entry() and
f2fs_add_dentry().  A crafted image can set i_pino to a regular or
special inode; the recovery code does not check S_ISDIR() and then
writes a dentry into a non-directory inode, extending its i_size and
changing its directory-only metadata.

Reject the record with -EFSCORRUPTED and mark the filesystem for fsck:

  F2FS-fs (loop0): recover_dentry: ino 4 is not a directory
  F2FS-fs (loop0): Cannot recover all fsync data errno=-117

Fixes: d624c96fb324 ("f2fs: add recovery routines for roll-forward")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
 fs/f2fs/recovery.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 54b524660..3e8054324 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -209,6 +209,13 @@ static int recover_dentry(struct inode *inode, struct f2fs_cached_block *entry,
 	}
 
 	dir = fsync_entry->inode;
+	if (!S_ISDIR(dir->i_mode)) {
+		f2fs_err(F2FS_I_SB(inode),
+			 "%s: ino %u is not a directory", __func__, pino);
+		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
+		err = -EFSCORRUPTED;
+		goto out;
+	}
 	err = init_recovered_filename(dir, inode, raw_inode, &fname, &usr_fname);
 	if (err)
 		goto out;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
