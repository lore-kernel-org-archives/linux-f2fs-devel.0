Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152BDC4451C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=V+iIylISiV8d6PQeMOCDeh8XubxDgdRC1hlr3d5iKcg=; b=FGJg43PR/UEF4AzGlnuf6zgxg0
	2XcT7Sg307eNI/vZgn37ZO7kg9/FTj6A7q7JrMiOZGLQMqW/ZGhh1hsan3/K4GEZax0VuvLQCjpBp
	vFxwzn0Z/7IXD3MFNVMIN7v8y5WIkpYunFLGr/9VCmBFefZFT5fVI55kmHgWxEuhXnM8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmDdV-0008Oh-1w;
	Tue, 21 Jul 2026 16:48:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wmDdU-0008Oa-6N
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 16:48:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=inz+NczIyfD75/aT4SMO9AaIVsqUIFXw6/sFSpbA0SM=; b=LtugmBcR28++tWxLAtX40iUPPW
 8KJAYZj/RtEcDjKutfbb0DUF6ULlyJDQM99T9Fg0wwdyyHUrNbTIL/FGtg8nOUw4KgyqFxRlAwYea
 4AruOA+KTjoqBaJIrQ0QlkbxWHoS/Q0Fyl11FLxVgIJFUDm+h2p3QBoodYVaYDV2Ej38=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=inz+NczIyfD75/aT4SMO9AaIVsqUIFXw6/sFSpbA0SM=; b=I
 4JagxJdtGmKEcl5l9/SXWQ+HFappMq60XqYEOhZN/cr38FXj/Yfkj75lqRTmmKM6RF+LYT2+n22FD
 aTVVbx5GF/2UvdnpdTB0FP2v8BcDlZYTVwgeDXRvHbCilyi+TiDy4qcOQY1kpQPD2i9GL+TlPnn+6
 zX64zSXeihMOc2V4=;
Received: from mail-pg1-f175.google.com ([209.85.215.175])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmDdS-0005lU-RA for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 16:48:04 +0000
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-cbb85186d43so569294a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 21 Jul 2026 09:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784652477; x=1785257277; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=inz+NczIyfD75/aT4SMO9AaIVsqUIFXw6/sFSpbA0SM=;
 b=Kf/85zTK5FItfllXoNNGwyn+5cXF5uTFyiiIKY2HhNZD5V7Aum7bVHjK7C4R/Z7xKA
 zYSBU4x5MPJcrLG2pFiFyPLfcH+nHO+O4GQHwcPMSAk0W02epbPRUom9uexEkKDWeouV
 lASEFEqTrjOO3/YxIbBkUzLEfoZU9jXCo33+ua72TM6J2OgDvJ8YIum/7pVnryjGtw43
 wBMVUvA10sKdXOkROmc9EV17kkzJDRKeJsfGvqimsqte0J8F5PJdqyJJQDgya29fYknO
 AIOOfmTde9FSPpGs67wH77KcDqI+wVR6suijIHcFS0VItug3Ba6kYqwwqwDGyZcIvpd+
 CsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784652477; x=1785257277;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=inz+NczIyfD75/aT4SMO9AaIVsqUIFXw6/sFSpbA0SM=;
 b=Nq+mnUrJ8eb5op9d5OnKVJLF6p5KQgIso4EUIONyARsarliSgB0FnalSgXFYrurzD/
 Yduq3wKoa3lF39dRUh6CVgPCRW5dwKiCvCt5iv7utxB40A+M+w8ccBY1xevqsX6Cbi4P
 CMzaS5dbjFPMQ456e3THlCQ2EVIfiM2cOOFLNgy3F/zTVTAFgHnypv79tGZrfsTuysKj
 IeGwOp1zdUlHR2ux5pTAO0GaLC8GfaYJpIHXsihDumhm8uuJyJ/dMj0l6s1aj29Do3/0
 62hS+qXxQ5j1CTAu4OaMcRoCwccW6pF3o3z/ExEimrSD8k2cRe6voFjNSCVST59bqPk+
 KkwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp0325EzUDc7mHdyrf9DgIBn2t6qv1UOSvCNGe+7BwU9AIwX6RqEQpKwCZTIiiS+RVdUTDnQtn7aOauyqeH5Y3T@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzLQgN424D+df3aFNOGdp8+XIXZLPmdh+mgJ0NGFK3bSupYC3Af
 FR+KuShsdk0vgJNNt5xPrWAHzWD9JhKFSjy53kNQc5IyZ0/l+bMDScAz
X-Gm-Gg: AfdE7cmW0NQ2nwREEMAe4oDJESYUhD5hPG3MRKE/F/tzIO3/BLy3cjvAUEUKkqcYPTX
 tYtDYNjcUU4+52/s+Mj8gVEAEXHT4OnpKuWSw11+prYYrXdPXn1bR2Hm8mM3clzpskMLWrvtB+o
 mp7Zfew2/Eg+aPEtrdypW5ti+Cm7syeY6IrNX/brN+WrEugfkFSKuUlPRYKEYxnJebpfj8lGQ41
 oxdCaho91qe3XrNgx/E+iLts8dlKtSdpuxB3j/GHjR7ae61wg9dM4MUy11H9N+cWd8UnI2e6nnR
 7MV3NcSkaagMoaZFJvoAFYqshvJPEKzg46SkJlEJOEUmdFmCtB3WSrz5/u0S3yFIyMuk0amixP8
 nH++VXAiW1Uqd5Z1EB4TuJ1Q/VYGTSCsN0HCP4/GpH8ZItk4rIVB0vi17ac41tqF28wpTNYN2zc
 MDkIBpxJnWWub+bJT/VdTdIP3QWfUflp1jvqW/OPKFTEMqm19+ZaX9oGsihpLbhrIhptz5EOd08
 RfW1VEBmdJIQ35gWh34DDbwSF7w
X-Received: by 2002:a05:6a21:1f87:b0:3c3:990b:2292 with SMTP id
 adf61e73a8af0-3c3ad9e2445mr20674940637.57.1784652477045; 
 Tue, 21 Jul 2026 09:47:57 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:911:9a85:99a8:c518])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1cf8fasm479226eec.31.2026.07.21.09.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 09:47:55 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Tue, 21 Jul 2026 09:47:52 -0700
Message-ID: <20260721164752.3853201-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
MIME-Version: 1.0
X-Headers-End: 1wmDdS-0005lU-RA
Subject: [f2fs-dev] [PATCH] fsck.f2fs: flush device buffer before zone
 transition on zoned storage
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

On zoned storage devices (F2FS_ZONED_HM), fsck.f2fs opens block devices
with buffered I/O (O_RDWR). When a curseg fills up its current zone and
moves to a new zone in find_next_free_block(), pending buffered writes
to the previous zone may still reside in the OS page cache / I/O queue.

As a result, issuing a write to the newly allocated zone can happen before
the device hardware finishes committing all blocks of the previous zone,
causing the hardware to see an additional open zone request that exceeds
the device's max open zone limit (e.g. open zones exceeded error).

Fix this by calling f2fs_fsync_device() right before allocating a new zone
when crossing zone boundaries (!(segno % segs_per_zone)). This flushes
all pending writes to physical media, ensuring the device hardware
auto-closes (FULL) the previous zone before opening the new zone.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/mount.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index 6f640a0..3bd40fe 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -3073,6 +3073,9 @@ int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left,
 			if (!(segno % segs_per_zone)) {
 				u64 new_blkaddr = SM_I(sbi)->main_blkaddr;
 
+				if (c.zoned_model == F2FS_ZONED_HM)
+					f2fs_fsync_device();
+
 				ret = find_next_free_block(sbi, &new_blkaddr, 0,
 						want_type, true);
 				if (ret)
-- 
2.55.0.229.g6434b31f56-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
